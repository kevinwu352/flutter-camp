import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// final pref = await SharedPreferences.getInstance();
// final key = "app_boarded";
// await pref.setBool(key, true);
// final val = await pref.getBool(key);
// await pref.remove(key);

// final storage = FlutterSecureStorage();
// await storage.write(key: "acc_key", value: "11112222");
// await storage.write(key: "acc_key", value: null);
// var val = await storage.read(key: "acc_key");
// await storage.delete(key: "acc_key");

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("STORE")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("begin");
          final storage = FlutterSecureStorage();
          await storage.write(key: "acc_key", value: "11112222");
          // await storage.write(key: "acc_key", value: null);
          print("done");
          var val = await storage.read(key: "acc_key");
          print(val);
          await storage.delete(key: "acc_key");
          val = await storage.read(key: "acc_key");
          print(val);
          print("end");
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("data"),
    );
  }
}
