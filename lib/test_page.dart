import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ...
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("body"),
    );
  }
}
