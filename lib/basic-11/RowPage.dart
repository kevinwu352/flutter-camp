import 'package:flutter/material.dart';

class RowPage extends StatelessWidget {
  const RowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Row")),
      body: Row(
        children: [
          // Text("abc", style: TextStyle(fontSize: 10)),
          // Text("hello", style: TextStyle(fontSize: 20)),
          FlutterLogo(),
          Expanded(
            child: Text(
              "Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android.",
              maxLines: 1,
            ),
          ),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}
