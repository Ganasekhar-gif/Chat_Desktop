// providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'services/chat_service.dart';
import 'models/app_user.dart';

// ---------- AUTH SERVICE ----------
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Auth state stream
final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges; // FIXED (removed ())
});

// ---------- USER SERVICE ----------
final userServiceProvider = Provider<UserService>((ref) {
  return UserService(ref);
});

// ---------- CHAT SERVICE ----------
final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService(ref);
});

// ---------- UI STATE PROVIDERS ----------
final selectedRoomProvider = StateProvider<String?>((ref) => null);
final selectedUserProvider = StateProvider<AppUser?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => "");
