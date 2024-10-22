import 'package:flutter/material.dart';

class ExtractView extends StatefulWidget {
  ExtractView({super.key, required this.extractedText });

  String? extractedText;
  @override
  State<ExtractView>createState() => _ExtractViewState();
}

class _ExtractViewState extends State<ExtractView> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.extractedText!);
  }


}