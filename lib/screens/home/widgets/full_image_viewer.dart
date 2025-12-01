import 'dart:typed_data';
import 'package:flutter/material.dart';

class FullImageViewer extends StatelessWidget {
  final Uint8List imageBytes;

  const FullImageViewer({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.memory(imageBytes),
        ),
      ),
    );
  }
}
 
