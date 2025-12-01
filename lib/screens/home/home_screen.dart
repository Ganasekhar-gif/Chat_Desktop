import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import 'panels/left_pane.dart';
import 'panels/right_pane.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRoom = ref.watch(selectedRoomProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF070B16),
                Color(0xFF101A2F),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              LeftPane(
                onRoomSelected: (roomId, user) {
                  ref.read(selectedRoomProvider.notifier).state = roomId;
                  ref.read(selectedUserProvider.notifier).state = user;
                },
              ),
              Container(
                width: 1,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              Expanded(
                child: RightPane(
                  roomId: selectedRoom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
