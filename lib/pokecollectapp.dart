import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokecollect/extract.dart';
import 'package:pokecollect/pokecollect.dart';
import 'package:pokecollect/cameraview.dart';

class SampleApp extends StatelessWidget {
  SampleApp({super.key});

  // GoRouter configuration
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const Sample(),
      ),
      GoRoute(
          name: 'extract',
          path: '/extract',
          builder: (context, state) {
            final String extractedText = state.extra as String;
            return ExtractView(extractedText: extractedText);
          }),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('PokeCollect sample test')),
            body: const Center(child: Sample())));
  }
}
