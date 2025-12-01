// services/auth_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_user.dart';

// AuthService provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Watch authentication state (null or AppUser)
final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.read(authServiceProvider).authStateChanges;
});

class AuthService {
  AuthService();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // -------- CURRENT USER -------- //

  AppUser? get currentUser {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      photoUrl: firebaseUser.photoURL ?? '',
      lastSeen: DateTime.now(),
      isOnline: true,
    );
  }

  // A stream of AppUser? for UI auto-updates
  Stream<AppUser?> get authStateChanges async* {
    await for (final firebaseUser in _auth.authStateChanges()) {
      if (firebaseUser == null) {
        yield null;
        continue;
      }

      final doc = await _db.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists) {
        yield AppUser.fromJson(doc.data()!);
      } else {
        yield null;
      }
    }
  }

  // -------- SIGN UP -------- //

  Future<AppUser> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    final user = AppUser(
      id: uid,
      email: email,
      name: name,
      photoUrl: '',
      isOnline: true,
      lastSeen: DateTime.now(),
    );

    // Save to Firestore
    await _db.collection('users').doc(uid).set(user.toJson());

    return user;
  }

  // -------- SIGN IN -------- //

  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) {
      throw Exception("User document missing.");
    }

    final user = AppUser.fromJson(doc.data()!);

    // Update online status
    await _db.collection('users').doc(uid).update({
      'isOnline': true,
      'lastSeen': DateTime.now().toIso8601String(),
    });

    return user;
  }

  // -------- SIGN OUT -------- //

  Future<void> logout() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _db.collection('users').doc(uid).update({
        'isOnline': false,
        'lastSeen': DateTime.now().toIso8601String(),
      });
    }
    await _auth.signOut();
  }
}
 
