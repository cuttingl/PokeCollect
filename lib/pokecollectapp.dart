import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pokecollect/extract.dart';
import 'package:pokecollect/pokecollect.dart';

class SampleApp extends StatelessWidget {
  SampleApp({super.key});

  // GoRouter configuration
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Sample(),
        routes: [
          GoRoute(
            path: 'extract',
            builder: (context, state) {
              final List<TextBlock> extractedText = state.extra as List<TextBlock>;
              return ExtractView(extractedText: extractedText);
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
