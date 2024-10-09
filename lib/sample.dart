import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:pokecollect/env.dart';


late List<CameraDescription> cameras;

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
  late CameraController controller;

  @override
  void initState() async {
    cameras = await availableCameras();
    super.initState();
    requestStoragePermission();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }


  void requestStoragePermission() async {
    // Check if the platform is not web, as web has no permissions
    if (!kIsWeb) {
      // Request storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      // Request camera permission
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }
    }
  }

  Future<PokemonCard?> getApi() async {
    final api = PokemonTcgApi(apiKey: APIKEY);
    card = await api.getCard('sv6-3');
    return card;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              onPressed: () {
                CameraPreview(controller);
              },
              child: const SelectionContainer.disabled(
                  child: Text("Tap to Open camera")))
        ]));
  }
}