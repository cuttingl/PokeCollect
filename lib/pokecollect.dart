import 'package:camera/camera.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:pokecollect/env.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool isChecked = false;
  PokemonCard? card;
  Image image = Image.network(
      "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msMCg.img");
  String text = "";

  Future<PokemonCard?> getApi() async {
    final api = PokemonTcgApi(apiKey: apikey);
    card = await api.getCard('sv6-6');
    return card;
  }

  @override
  Widget build(BuildContext context) {
    getApi();
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 200),
          color: Color.fromRGBO(238, 189, 0, 1),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color.fromRGBO(238, 189, 0, 1),
          items: [
            CurvedNavigationBarItem(child: Icon(Icons.home), label: 'Home'),
            CurvedNavigationBarItem(child: Icon(Icons.camera), label: 'Camera'),
            CurvedNavigationBarItem(
                child: Icon(Icons.text_snippet), label: 'Extracted Text'),
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
              onPressed: () {
                context.go('/extract', extra: card?.images.large);
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to go to extract view"))),
        ])));
  }

  _indexHandler(int index) {
    print("Index de la bottom navigation bar : " + index.toString());
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }
}
