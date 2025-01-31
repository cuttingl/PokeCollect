import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ExtractView extends StatefulWidget {
  final List<TextBlock> extractedText;

  ExtractView({super.key, required this.extractedText});

  @override
  State<ExtractView> createState() => _ExtractViewState();
}

class _ExtractViewState extends State<ExtractView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var block in widget.extractedText) Text(block.text),
        ],
      )),
    );
  }
}
