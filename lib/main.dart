import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'env.dart';

/// Flutter code sample for [Checkbox].

void main() => runApp(const CheckboxExampleApp());

class CheckboxExampleApp extends StatelessWidget {
  const CheckboxExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Checkbox Sample')),
        body: const Center(
          child: CheckboxExample(),
        ),
      ),
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;
  PokemonCard? card;
  Image image = Image.network(
      "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msMCg.img");
  String text = "";

  Future<PokemonCard?> getApi() async {
    final api = PokemonTcgApi(apiKey: APIKEY);
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
            setState(() async {
              if (!isChecked) {
                image = Image.network(card!.images.small);
                text = StringBuffer([card!.name, card!.artist, card!.attacks.first.name ]).toString();
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
    ]));
  }
}
