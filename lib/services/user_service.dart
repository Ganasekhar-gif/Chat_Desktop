// services/user_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_user.dart';
import 'auth_service.dart';

class UserService {
  final Ref ref;
  UserService(this.ref);

  final _db = FirebaseFirestore.instance;

  // -------- CURRENT USER STREAM -------- //
  Stream<AppUser?> get currentUserStream {
    final uid = ref.read(authServiceProvider).currentUser?.id;
    if (uid == null) return const Stream.empty();

    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? AppUser.fromJson(doc.data()!) : null);
  }

  // -------- FETCH SINGLE USER -------- //
  Future<AppUser?> getUserById(String id) async {
    final doc = await _db.collection('users').doc(id).get();
    if (!doc.exists) return null;
    return AppUser.fromJson(doc.data()!);
  }

  // -------- FETCH ALL USERS (EXCEPT SELF) -------- //
  Stream<List<AppUser>> allUsersStream() {
    final uid = ref.read(authServiceProvider).currentUser?.id;

    return _db.collection('users').snapshots().map((snap) {
      return snap.docs
          .map((d) => AppUser.fromJson(d.data()))
          .where((user) => user.id != uid)
          .toList();
    });
  }

  // -------- SEARCH USERS -------- //
  Stream<List<AppUser>> searchUsers(String query) {
    if (query.trim().isEmpty) return allUsersStream();

    final lower = query.toLowerCase();

    return allUsersStream().map((users) {
      return users.where((user) {
        return user.name.toLowerCase().contains(lower) ||
            user.email.toLowerCase().contains(lower);
      }).toList();
    });
  }

  // -------- UPDATE USER -------- //
  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    await _db.collection('users').doc(id).update(data);
  }

  Future<void> setOnlineStatus(bool isOnline) async {
    final uid = ref.read(authServiceProvider).currentUser?.id;
    if (uid == null) return;

    await updateUser(uid, {
      'isOnline': isOnline,
      'lastSeen': DateTime.now().toIso8601String(),
    });
  }

  Future<void> setProfilePhoto(String url) async {
    final uid = ref.read(authServiceProvider).currentUser?.id;
    if (uid == null) return;

    await updateUser(uid, {'photoUrl': url});
  }
}
