import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pokecollect/extract.dart';
import 'package:pokecollect/pokecollect.dart';
import 'package:pokecollect/cameraview.dart';

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
              final String extractedText = state.extra as String;
              return ExtractView(extractedText: extractedText);
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      routerConfig: _router,
    );
  }
}
