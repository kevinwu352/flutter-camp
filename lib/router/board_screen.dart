import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BOARD")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print('object');
              // context.push("/board");
              // context.go("/blah");
              // context.replace("/blah");
              context.pushReplacement("/blah");
            },
            child: Text('jump'),
          ),
        ],
      ),
    );
  }
}
