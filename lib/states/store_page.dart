import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

// 读写普通键值对，不要用这
// import 'package:shared_preferences/shared_preferences.dart';
// final pref = await SharedPreferences.getInstance();
// final key = "app_boarded";
// await pref.setBool(key, true);
// final val = await pref.getBool(key);
// await pref.remove(key);

// 读写安全键值对
// final storage = FlutterSecureStorage();
//
// await storage.write(key: "acc_key", value: "11112222");
// await storage.write(key: "acc_key", value: null);
//
// var val = await storage.read(key: "acc_key");
//
// await storage.delete(key: "acc_key");

// 读写文件
// final dir = await getApplicationDocumentsDirectory();
// final file = File('${dir.path}/counter.txt');
//
// await file.writeAsString('101');
//
// final contents = await file.readAsString();
// final val = int.parse(contents);
// print(val);

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("STORE")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("begin");

          final dir = await getApplicationDocumentsDirectory();
          final file = File('${dir.path}/counter.txt');

          // await file.writeAsString('101');

          final contents = await file.readAsString();
          final val = int.parse(contents);
          print(val);

          print("end");
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("data"),
    );
  }
}
