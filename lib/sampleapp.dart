import 'package:flutter/material.dart';
import 'package:pokecollect/sample.dart';

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

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