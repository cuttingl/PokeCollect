import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pokecollect/env.dart';

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  bool isChecked = false;
  PokemonCard? card;
  Image image = Image.network(
      "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msMCg.img");
  String text = "";
  String extractedText = "";
  final textDetector = TextRecognizer(script: TextRecognitionScript.latin);

  Future<PokemonCard?> getApi() async {
    final api = PokemonTcgApi(apiKey: apikey);
    card = await api.getCard('sv6-3');
    return card;
  }

  Future<String> getExtractedText() async {
    final inputImage = InputImage.fromFilePath('path/to/image');
    final RecognizedText recognisedText =
        await textDetector.processImage(inputImage);
    return recognisedText.text;
  }

  @override
  Widget build(BuildContext context) {
    getApi();
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
                context.go('/extract', extra: extractedText);
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to go to extract view"))),
        ])));
  }
}
