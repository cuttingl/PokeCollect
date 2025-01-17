import 'package:flutter/material.dart';

class ExtractView extends StatefulWidget {
  ExtractView({super.key /* required this.extractedText */
      });

  @override
  State<ExtractView> createState() => _ExtractViewState();
}

class _ExtractViewState extends State<ExtractView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Voici la vue de texte extrait"),
      ),
    );
  }
}
