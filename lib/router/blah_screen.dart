import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlahScreen extends StatelessWidget {
  const BlahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BLAH")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("router"),
    );
  }
}
