import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_icons.dart';

class MessageInput extends StatefulWidget {
  final Future<void> Function(String text)? onSendText;
  final Future<void> Function(String fileName, String base64Data)? onSendFile;

  const MessageInput({
    super.key,
    this.onSendText,
    this.onSendFile,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSendText() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending || widget.onSendText == null) return;

    setState(() => _sending = true);
    await widget.onSendText!(text);

    _controller.clear();
    setState(() => _sending = false);
  }

  Future<void> _handlePickFile() async {
    if (widget.onSendFile == null) return;

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true,
      withReadStream: true,
    );

    if (result == null || result.files.isEmpty) return;

    final picked = result.files.single;
    Uint8List? bytes = picked.bytes;

    if (bytes == null && picked.path != null) {
      bytes = await File(picked.path!).readAsBytes();
    }

    if (bytes == null) return;

    final base64Data = base64Encode(bytes);
    final fileName = picked.name;

    await widget.onSendFile!(fileName, base64Data);
  }

  bool get _canSend => _controller.text.trim().isNotEmpty && !_sending;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: colorScheme.surface,
      child: Shortcuts(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): _SendMessageIntent(),
          SingleActivator(LogicalKeyboardKey.numpadEnter): _SendMessageIntent(),
        },
        child: Actions(
          actions: {
            _SendMessageIntent: CallbackAction<_SendMessageIntent>(
              onInvoke: (_) {
                if (_focusNode.hasFocus) {
                  _handleSendText();
                }
                return null;
              },
            ),
          },
          child: Row(
            children: [
              IconButton(
                icon: Image.asset(
                  AppIcons.attach,
                  height: 22,
                  width: 22,
                  color: colorScheme.primary,
                  colorBlendMode: BlendMode.srcIn,
                ),
                tooltip: "Add file",
                onPressed: _handlePickFile,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  minLines: 1,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _canSend ? _handleSendText : null,
                icon: Image.asset(
                  AppIcons.send,
                  height: 22,
                  width: 22,
                  color: _canSend ? colorScheme.primary : colorScheme.outline,
                  colorBlendMode: BlendMode.srcIn,
                ),
                tooltip: "Send",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendMessageIntent extends Intent {
  const _SendMessageIntent();
}
 
