import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/message.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_icons.dart';
import '../widgets/full_image_viewer.dart';

class MessageBubble extends ConsumerWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(authServiceProvider).currentUser;
    final isMe = currentUser?.id == message.senderId;

    final bgColor = isMe
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.secondaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // ---------------- IMAGE PREVIEW ----------------
            if (message.fileData != null && _isImage(message.fileName))
              _buildImagePreview(message, context),

            // ---------------- FILE PREVIEW ----------------
            if (message.fileData != null && !_isImage(message.fileName))
              _buildFilePreview(message),

            // ---------------- TEXT MESSAGE ----------------
            if (message.text.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  message.text,
                  style: const TextStyle(fontSize: 15),
                ),
              ),

            const SizedBox(height: 4),

            // ---------------- TIMESTAMP ----------------
            if (message.createdAt != null)
              Text(
                _formatTime(message.createdAt!),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  bool _isImage(String? fileName) {
    if (fileName == null) return false;
    final ext = fileName.toLowerCase();
    return ext.endsWith(".png") ||
        ext.endsWith(".jpg") ||
        ext.endsWith(".jpeg") ||
        ext.endsWith(".gif") ||
        ext.endsWith(".bmp");
  }

  // ---------------- UPDATED: IMAGE WITH ZOOM VIEWER ----------------
  Widget _buildImagePreview(Message msg, BuildContext context) {
    final bytes = base64Decode(msg.fileData!);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullImageViewer(imageBytes: bytes),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          bytes,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFilePreview(Message msg) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppIcons.file,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 8),
          Text(
            msg.fileName!,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? "PM" : "AM";
    return "$h:$m $ampm";
  }
}
