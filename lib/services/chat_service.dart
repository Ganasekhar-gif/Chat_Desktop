// services/chat_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';
import '../models/room.dart';
import '../interceptors/message_interceptor.dart';
import 'auth_service.dart';

class ChatService {
  final Ref ref;
  ChatService(this.ref);

  final MessageInterceptor interceptor = PlainTextInterceptor();

  // ---------- SEND TEXT ----------
  Future<void> sendMessage({
    required String roomId,
    required String text,
  }) async {
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) throw Exception("User not logged in");

    final msgId = const Uuid().v4();

    final raw = Message(
      id: msgId,
      roomId: roomId,
      senderId: user.id,
      text: text,
      createdAt: DateTime.now(),
    );

    final outbound = await interceptor.outbound(raw);

    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(outbound.toJson());

    await _updateRoomTimestamp(roomId);
  }

  // ---------- SEND FILE / IMAGE ----------
  Future<void> sendFileMessage({
    required String roomId,
    required String fileName,
    required String fileData,
  }) async {
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) throw Exception("User not logged in");

    final msgId = const Uuid().v4();

    final raw = Message(
      id: msgId,
      roomId: roomId,
      senderId: user.id,
      text: "",
      fileName: fileName,
      fileData: fileData,
      createdAt: DateTime.now(),
    );

    final outbound = await interceptor.outbound(raw);

    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(outbound.toJson());

    await _updateRoomTimestamp(roomId);
  }

  // ---------- STREAM MESSAGES ----------
  Stream<List<Message>> messagesFor(String roomId) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snap) async {
      return Future.wait(
        snap.docs.map((doc) async {
          final msg = Message.fromJson(doc.data());
          return interceptor.inbound(msg);
        }),
      );
    });
  }

  // ---------- CREATE OR FIND DM ----------
  Future<String> findOrCreateDM(String otherId) async {
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) throw Exception("User not logged in");

    final uid = user.id;
    final roomsRef = FirebaseFirestore.instance.collection('rooms');

    // find existing
    final query =
        await roomsRef.where('members', arrayContains: uid).get();

    for (final doc in query.docs) {
      final members = List<String>.from(doc.data()['members'] ?? []);
      if (members.length == 2 && members.contains(otherId)) {
        return doc.id;
      }
    }

    // create new room
    final roomId = const Uuid().v4();
    final newRoom = Room(
      id: roomId,
      name: "DM",
      members: [uid, otherId],
      updatedAt: DateTime.now(),
    );

    await roomsRef.doc(roomId).set(newRoom.toJson());
    return roomId;
  }

  // ---------- UPDATE TIMESTAMP ----------
  Future<void> _updateRoomTimestamp(String roomId) async {
    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .update({
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }
}
