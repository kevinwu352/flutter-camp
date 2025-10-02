import 'package:flutter/material.dart';

class DialogStatePage extends StatefulWidget {
  const DialogStatePage({super.key});

  @override
  State<DialogStatePage> createState() => _DialogStatePageState();
}

class _DialogStatePageState extends State<DialogStatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dialog State')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Text('--'),
    );
  }
}
