import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ExtractView extends StatelessWidget {
  final String imagePath;

  ExtractView({super.key, required this.imagePath});
  final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
  List<TextBlock>? blocks;


  Future<List<TextBlock>?> getExtractedText(String imagePath) async {
    final response = await http.get(Uri.parse(imagePath));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/image.png');
    file.writeAsBytesSync(response.bodyBytes);

    final inputImage = InputImage.fromFilePath(file.path);
    final RecognizedText recognisedText =
    await textDetector.processImage(inputImage);
    blocks = recognisedText.blocks;
    return blocks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TextBlock>?>(
      future: getExtractedText(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Extracted Text'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Extracted Text'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final blocks = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Extracted Text'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var block in blocks!) Text(block.text),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
