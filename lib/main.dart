import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown, brightness: Brightness.light),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Flutter Camp"),
        ),
        body: Text("hello"),
      ),
    );
  }
}
