import 'package:flutter/material.dart';

class RiverApp1 extends StatelessWidget {
  const RiverApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RiverPage1());
  }
}

class RiverPage1 extends StatelessWidget {
  const RiverPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("river-1")),
      body: Center(child: Text("hehe")),
    );
  }
}
