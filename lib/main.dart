import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PokeCollect with a simple example')),
        body: const Center(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool? isChecked = false;

    return Checkbox(
        tristate: true,
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value;
          });
        });
  }
}
