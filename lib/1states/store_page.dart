import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:hive/hive.dart';
import 'hive_ext.dart';

// ================================================================================

// 读写普通键值对，它存磁盘的时机不确定，会丢数据。不要用这
// import 'package:shared_preferences/shared_preferences.dart';
//
// final pref = await SharedPreferences.getInstance();
// final key = "app_boarded";
// await pref.setBool(key, true);
// final val = await pref.getBool(key);
// await pref.remove(key);

// ================================================================================

// 读写安全键值对
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// final storage = FlutterSecureStorage();
//
// await storage.write(key: "acc_key", value: "11112222");
// await storage.write(key: "acc_key", value: null);
//
// var val = await storage.read(key: "acc_key");
//
// await storage.delete(key: "acc_key");

// ================================================================================

// 读写文件
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
//
// final dir = await getApplicationDocumentsDirectory();
// final file = File('${dir.path}/counter.txt');
//
// await file.writeAsString('101');
//
// final contents = await file.readAsString();
// final val = int.parse(contents);
// print(val);

// ================================================================================

// 读写 Hive
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:hive/hive.dart';
//
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
// await box.put('bee_key', bee.toJson());
//
// final beeobj = box.get('bee_key');
// print(beeobj is Map); // true
// print(beeobj is Map<dynamic, dynamic>); // true
// print(beeobj is Map<String, dynamic>); // false
// 1)final beemap = beeobj is Map ? beeobj.map((k, v) => MapEntry(k.toString(), v)) : null;
// 1)final bee = beemap is Map<String, dynamic> ? Bee.fromJson(beemap) : null; // 这里不能用 is Map，要用 is Map<String, dynamic>
// 2)final bee = beeobj is Map ? Bee.fromJson(beeobj.map((k, v) => MapEntry(k.toString(), v))) : null; // 一步到位的解析方式
// print(bee);

class Bee {
  Bee({required this.name, required this.role});
  final String name;
  final int role;
  Bee.fromJson(Map<String, dynamic> json) : name = json['name'] as String, role = json['role'] as int;
  Map<String, dynamic> toJson() => {'name': name, 'role': role};
  @override
  String toString() => '$name $role';
}

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
          Hive.init(join(dir.path, 'hive'));
          final box = await Hive.openBox('defaults');

          await box.put('bool_key', true);
          await box.put('int_key', 102);
          await box.put('double_key', 1.23456789);
          await box.put('string_key', 'xixihaha');
          await box.put('list_key', [1, 'a']);
          await box.put('map_key', {'a': 1, 'b': 'x'});

          final key = 'bool_key';
          print(box.getBool(key));
          print(box.getInt(key));
          print(box.getDouble(key));
          print(box.getString(key));
          print(box.getList(key));
          print(box.getMap(key));

          final bee = Bee(name: 'kim', role: 10);
          await box.put('bee_key', bee.toJson());

          final map = box.getMap('bee_key');
          final bee1 = map is Map<String, dynamic> ? Bee.fromJson(map) : null;
          print(bee1);

          final bee2 = box.getObject('bee_key', Bee.fromJson);
          print(bee2);

          print("end");
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("data"),
    );
  }
}
