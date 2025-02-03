import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ExtractView extends StatelessWidget {
  final List<TextBlock> extractedText;

  ExtractView({super.key, required this.extractedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracted Text'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var block in extractedText) Text(block.text),
        ],
      )),
    );
  }
}
