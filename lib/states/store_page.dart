import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
//
// final pref = await SharedPreferences.getInstance();
//
// final key = "app_boarded";
//
// await pref.setBool(key, true);
//
// final val = await pref.getBool(key);
// print(val);
//
// await pref.remove(key);

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("STORE")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("data"),
    );
  }
}
