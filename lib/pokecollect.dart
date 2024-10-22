import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';

import 'package:pokemon_tcg/pokemon_tcg.dart';

import 'package:pokecollect/cameraview.dart';
import 'package:pokecollect/env.dart';
import 'package:pokecollect/extract.dart';

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

  Future<PokemonCard?> getApi() async {
    final api = PokemonTcgApi(apiKey: apikey);
    card = await api.getCard('sv6-3');
    return card;
  }

  @override
  Widget build(BuildContext context) {
    getApi();
    return SelectionArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                image = Image.network(card!.images.large);
                text = StringBuffer(
                    [card!.name, card!.artist, card!.attacks.first.name])
                    .toString();

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
          Image(image: image.image),
          OutlinedButton(
              onPressed: () async {
                await availableCameras().then((value) =>
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => Cameraview(cameras: value)
                        )));
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to Open camera"))),

          OutlinedButton(
              onPressed: () async {
                extractedText = await FlutterTesseractOcr.extractText(card!.images.large);

                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => ExtractView(extractedText: extractedText)
                ));
              }, child: const SelectionContainer.disabled(
              child: Text("Tap to extract text")))
        ]));
  }
}