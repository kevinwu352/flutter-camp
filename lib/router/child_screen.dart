import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChildScreen extends StatelessWidget {
  const ChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CHILD")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go("/"),
        child: Icon(Icons.run_circle_rounded),
      ),
      body: Text("data"),
    );
  }
}
