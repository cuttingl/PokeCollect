import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pokecollect/extract.dart';
import 'package:pokecollect/cameraview.dart';
import 'package:pokecollect/pokecollect.dart';
import 'package:pokecollect/collection.dart';

class SampleApp extends StatelessWidget {
  SampleApp({super.key});

  // GoRouter configuration
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: "home",
        path: '/',
        builder: (context, state) => const MainScreen(),
        routes: [
          GoRoute(
              name: "extractionView",
              path: 'extract',
              builder: (context, state) {
                final String imagePath = state.extra as String;
                return ExtractView(imagePath: imagePath);
              }),
        ],
      ),
      GoRoute(
        name: "cameraView",
        path: '/camera',
        builder: (context, state) => Cameraview(),
      ),
      GoRoute(
        name: "collectionView",
        path: '/collection',
        builder: (context, state) => const CollectionView(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
