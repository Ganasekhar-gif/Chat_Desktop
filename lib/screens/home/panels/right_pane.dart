import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/message.dart';
import '../../../models/app_user.dart';
import '../../../providers.dart';
import '../../../utils/app_icons.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class RightPane extends ConsumerStatefulWidget {
  final String? roomId;

  const RightPane({super.key, required this.roomId});

  @override
  ConsumerState<RightPane> createState() => _RightPaneState();
}

class _RightPaneState extends ConsumerState<RightPane> {
  final ScrollController _scroll = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomId = widget.roomId;
    final selectedPeer = ref.watch(selectedUserProvider);

    if (roomId == null || selectedPeer == null) {
      return const _EmptyState(
        title: "Start a conversation",
        subtitle: "Select a contact to begin chatting.",
      );
    }

    final messageStream =
        ref.watch(chatServiceProvider).messagesFor(roomId);

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF6F8FC),
            Color(0xFFEFF2FA),
          ],
        ),
      ),
      child: Column(
        children: [
          _Header(user: selectedPeer),
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: messageStream,
              builder: (context, snap) {
                if (snap.hasError) {
                  return const _EmptyState(
                    title: "Unable to load messages",
                    subtitle: "Please try again in a moment.",
                  );
                }

                if (snap.connectionState == ConnectionState.waiting &&
                    !snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snap.data ?? [];

                if (messages.isEmpty) {
                  return const _EmptyState(
                    title: "No messages yet",
                    subtitle: "Say hi to kick things off.",
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scroll,
                  reverse: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return MessageBubble(message: msg);
                  },
                );
              },
            ),
          ),
          MessageInput(
            key: ValueKey(roomId),
            onSendText: (text) async {
              await ref.read(chatServiceProvider).sendMessage(
                    roomId: roomId,
                    text: text,
                  );
            },
            onSendFile: (fileName, base64) async {
              await ref.read(chatServiceProvider).sendFileMessage(
                    roomId: roomId,
                    fileName: fileName,
                    fileData: base64,
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 30,
            spreadRadius: -10,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primaryContainer,
            backgroundImage:
                user.photoUrl.isNotEmpty ? NetworkImage(user.photoUrl) : null,
            child: user.photoUrl.isEmpty
                ? Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset(
                      user.isOnline
                          ? AppIcons.statusOnline
                          : AppIcons.statusOffline,
                      height: 12,
                      width: 12,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      user.isOnline ? "Online" : "Offline",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        width: 360,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 36),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow,
              blurRadius: 34,
              spreadRadius: -16,
              offset: const Offset(0, 18),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF6857F3), Color(0xFF8F74FF)],
                ),
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 34,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0FF),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                "Select someone from the list on the left",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF5243D2),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
