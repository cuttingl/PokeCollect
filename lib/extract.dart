import 'package:flutter/material.dart';

class ExtractView extends StatefulWidget {
  final String extractedText;

  ExtractView({super.key, required this.extractedText});

  @override
  State<ExtractView> createState() => _ExtractViewState();
}

class _ExtractViewState extends State<ExtractView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extract data view"),
      ),
      body: Center(
        child: Text(widget.extractedText),
      ),
    );
  }
}
