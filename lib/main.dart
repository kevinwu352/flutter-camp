import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Flutter Camp"),
        ),
        body: Text("abc"),
        // body: Image.asset(
        //   'assets/images/bg.jpg',
        //   height: double.infinity,
        //   fit: BoxFit.cover,
        // ),
        // body: Image.network(
        //   "https://cdn.pixabay.com/photo/2012/11/28/09/32/explosion-67557_1280.jpg",
        //   height: double.infinity,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
