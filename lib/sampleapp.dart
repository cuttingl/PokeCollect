import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokecollect/sample.dart';

import 'cameraview.dart';

class SampleApp extends StatelessWidget {
  SampleApp({super.key});

  // GoRouter configuration
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: '/',
        builder: (context, state) => const Sample(),
      ),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PokeCollect sample test')),
        body: const Center(
          child: Sample(),
        ),
      ),
    );
  }
}