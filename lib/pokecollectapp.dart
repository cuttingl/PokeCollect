import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokecollect/extract.dart';
import 'package:pokecollect/pokecollect.dart';

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
          builder: (context, state) => ExtractView(),
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