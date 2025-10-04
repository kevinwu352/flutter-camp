import 'package:flutter/material.dart';

class ConstraintPage extends StatelessWidget {
  const ConstraintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Constraint')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Container(constraints: BoxConstraints.expand(), child: Text('data')),
    );
  }
}
