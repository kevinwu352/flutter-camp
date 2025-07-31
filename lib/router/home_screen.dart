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
          // context.push('/child');

          // context.push('/para/kim/18');
          context.push('/para?name=kkk&age=19');
        },
        child: Icon(Icons.run_circle_rounded),
      ),
      body: Text("data"),
    );
  }
}
