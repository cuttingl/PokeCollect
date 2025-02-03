import 'dart:io';

import 'package:camera/camera.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pokecollect/env.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String extractedText = "";

  bool isChecked = false;
  PokemonCard? card;
  List<TextBlock>? blocks;
  Image image = Image.network(
      "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msMCg.img");
  String text = "";
  final textDetector = TextRecognizer(script: TextRecognitionScript.latin);

  Future<PokemonCard?> getApi() async {
    final api = PokemonTcgApi(apiKey: apikey);
    card = await api.getCard('sv6-6');
    return card;
  }

  Future<List<TextBlock>?> getExtractedText() async {
    final response = await http.get(Uri.parse(card!.images.large));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/image.png');
    file.writeAsBytesSync(response.bodyBytes);

    final inputImage = InputImage.fromFilePath(file.path);
    final RecognizedText recognisedText =
        await textDetector.processImage(inputImage);
    blocks = recognisedText.blocks;
    return blocks;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getApi();
    getExtractedText();
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 200),
            color: Color.fromRGBO(238, 189, 0, 1),
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Color.fromRGBO(238, 189, 0, 1),
            items: [
              CurvedNavigationBarItem(child: Icon(Icons.home), label: 'Home'),
              CurvedNavigationBarItem(child: Icon(Icons.camera), label: 'Camera'),
              CurvedNavigationBarItem(child: Icon(Icons.text_snippet), label: 'Extracted Text'),
            ],
            onTap: _indexHandler,
        ),
        body: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                image = Image.network(card!.images.large);
                text = StringBuffer(
                        [card!.name, card!.artist, card!.attacks.first.name])
                    .toString();
                extractedText = text;
                setState(() {
                  if (!isChecked) {
                    isChecked = value!;
                  } else if (isChecked) {
                    image = Image.network(
                        "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msMCg.img");
                    isChecked = value!;
                  }
                });
              },
            ),
          ),
          Text(text),
          Image(
            image: image.image,
          ),
          OutlinedButton(
              onPressed: () async {
                await availableCameras().then((value) => context.go('/camera'));
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to Open camera"))),
          OutlinedButton(
              onPressed: () async {
                context.go('/extract', extra: blocks);
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to go to extract view"))),
        ])));
  }

  _indexHandler(int index) {
    print("Index de la bottom navigation bar : " + index.toString());
    switch (index){
      case 0:
        break;
      case 1:
        break;
      case 2:
        context.go('/extract', extra: blocks);
        break;
    }
  }
}
