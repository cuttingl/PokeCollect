import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pokecollect/env.dart';
import 'package:http/http.dart' as http;

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  bool isChecked = false;
  PokemonCard? card;
  List<TextBlock>? blocks;
  Image image = Image.network(
      "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msMCg.img");
  String text = "";
  String extractedText = "";
  final textDetector = TextRecognizer(script: TextRecognitionScript.latin);

  Future<PokemonCard?> getApi() async {
    final api = PokemonTcgApi(apiKey: apikey);
    card = await api.getCard('sv6-5');
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

  @override
  Widget build(BuildContext context) {
    getApi();
    getExtractedText();
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Pokecollect"),
        ),
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: CupertinoCheckbox(
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
          CupertinoButton(
              onPressed: () async {
                await availableCameras().then((value) => context.go('/camera'));
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to Open camera"))),
          CupertinoButton(
              onPressed: () async {
                context.go('/extract', extra: blocks);
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to go to extract view"))),
        ])));
  }
}
