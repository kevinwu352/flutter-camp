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

// 读写 Hive
// final box = await Hive.openBox('defaults');
//
// await box.delete('username');
// 返回被删除数量
// final num = await box.clear();
//
// 存 null 不会删除相应的 key
// await box.put('username', 'kevin');
//
// 如果改成 int 来接数据，会崩
// final username_raw = box.get('username');
// final username = username_raw is String ? username_raw : '--';
// print(username);
// final age = username_raw is int ? username_raw : 101;
// print(age);
//
// final bee = Bee(name: 'kim', role: 'worker');
// await box.put('beeobj', bee.toJson());
//
// final beeobj_raw = box.get('beeobj');
// final beeobj_map = beeobj_raw is Map<dynamic, dynamic>
//     ? beeobj_raw.map((k, v) => MapEntry(k.toString(), v))
//     : null;
// final bee = beeobj_map is Map<String, dynamic> ? Bee.fromJson(beeobj_map) : null;
// print(bee);
//
// class Bee {
//   Bee({required this.name, required this.role});
//   final String name;
//   final String role;
//   factory Bee.fromJson(Map<String, dynamic> json) => Bee(name: json['name'] as String, role: json['role'] as String);
//   Map<String, dynamic> toJson() => {'name': name, 'role': role};
//   @override String toString() => '$name $role';
// }

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
