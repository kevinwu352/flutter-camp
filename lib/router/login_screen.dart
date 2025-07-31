import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOGIN")),
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
