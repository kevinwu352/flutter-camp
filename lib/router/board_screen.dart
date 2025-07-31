import 'package:flutter/material.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BOARD")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.push('/child');
        },
        child: Icon(Icons.run_circle_rounded),
      ),
      body: Text("router"),
    );
  }
}
