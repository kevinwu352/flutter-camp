import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOME")),
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
            },
            child: Text('jump'),
          ),
        ],
      ),
    );
  }
}
