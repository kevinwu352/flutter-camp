import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import '/core/core.dart';
// import 'hive_ext.dart';

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
// final box = await Hive.openBox<Object>('defaults');
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
// 存纯的基本数组 [bool|int|double|String] 取出来的时候 val is List<int> 能成功，我只试了 int
// 存其它混的数组 [1,1,2],[1,true],[1,'a',null] 取出来的时候 val is List 和 val is List<Object?> 能成功，注意是 List<Object?> 有问号的
// 所以，取出 List<Object?> 自己转吧 box.getList('ln')?.whereType<num>();
//
// 存字典，不管什么类型的，取出来都是 Map<dynamic, dynamic>，is Map<String, dynamic> 为 false
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

// ================================================================================
// JSON 解析的类型转换问题
//
// final str = '{"a":1,"b":"x"}';
// 此处 obj 类型还是 dynamic，asOr<int> 也不行
// final obj1 = jsonDecode(str).asOr<Map>();
//
// str 可能是 'null'，所以最好用 Object? 来接收解析结果
//
// Object? obj2 = jsonDecode(str);
// 此处 obj 类型是 Map<dynamic, dynamic>
// final obj21 = obj2?.asOr<Map>();
// 此处 obj 类型是 Map<String, dynamic>
// final obj22 = obj2?.asOr<Map>()?.map((k, v) => MapEntry(k.toString(), v));
// 此处 obj 类型是 Map<String, Object?>。用这种吧
// Map<String, Object?>? obj23 = obj2?.asOr<Map>()?.map((k, v) => MapEntry(k.toString(), v));
//
// 最好的解析方式，如下：
//
// Object? obj = jsonDecode(str);
//
// Map<String, Object?>? map = obj?.asOr<Map>()?.map((k, v) => MapEntry(k.toString(), v));
// print(map);
//
// List<Object?>? list = obj?.asOr<List>();
// print(list);

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

          // Hive.init(pathmk('hive'));
          // final box = await Hive.openBox<Object>('defaults');
          // await box.setValue('asdf', 'god');
          // final val1 = box.getValue('asdf');
          // print(val1);
          // await box.setValue('asdf', null);
          // final val2 = box.getValue('asdf');
          // print(val2);

          // ========================================

          // final mi = {'a': 1};
          // final mn = {'a': 1, 'b': 2.1};
          // final mx = {'a': 1, 'b': true};
          // final my = {'a': 1, 'b': true, 'c': null};
          // await box.put('mi', mi);
          // await box.put('mn', mn);
          // await box.put('mx', mx);
          // await box.put('my', my);

          // final mi11 = box.getMap('mi');
          // print(mi11);
          // final mn11 = box.getMap('mn');
          // print(mn11);
          // final mx11 = box.getMap('mx');
          // print(mx11);
          // final my11 = box.getMap('my');
          // print(my11);

          // final mi1 = box.get('mi');
          // final mn1 = box.get('mn');
          // final mx1 = box.get('mx');
          // final my1 = box.get('my');
          // print('----------');
          // print(mi1 is Map);
          // print(mi1 is Map<String, int>);
          // print(mi1 is Map<String, num>);
          // print(mi1 is Map<String, Object>);
          // print(mi1 is Map<String, Object?>);
          // print(mi1 is Map<dynamic, dynamic>);
          // print('----------');
          // print(mn1 is Map);
          // print(mn1 is Map<String, int>);
          // print(mn1 is Map<String, num>);
          // print(mn1 is Map<String, Object>);
          // print(mn1 is Map<String, Object?>);
          // print(mn1 is Map<dynamic, dynamic>);
          // print('----------');
          // print(mx1 is Map);
          // print(mx1 is Map<String, int>);
          // print(mx1 is Map<String, num>);
          // print(mx1 is Map<String, Object>);
          // print(mx1 is Map<String, Object?>);
          // print(mx1 is Map<dynamic, dynamic>);
          // print('----------');
          // print(my1 is Map);
          // print(my1 is Map<String, int>);
          // print(my1 is Map<String, num>);
          // print(my1 is Map<String, Object>);
          // print(my1 is Map<String, Object?>);
          // print(my1 is Map<dynamic, dynamic>);

          // ========================================

          // final li = [1, 2];
          // final ln = [1, 2.1];
          // final lx = [1, true];
          // final ly = [1, true, null];
          // await box.put('li', li);
          // await box.put('ln', ln);
          // await box.put('lx', lx);
          // await box.put('ly', ly);

          // final li11 = box.getList('li')?.whereType<int>();
          // print(li11);
          // final ln11 = box.getList('ln')?.whereType<num>();
          // print(ln11);
          // final lx11 = box.getList('lx');
          // print(lx11);
          // final ly11 = box.getList('ly');
          // print(ly11);

          // final li1 = box.get('li');
          // final ln1 = box.get('ln');
          // final lx1 = box.get('lx');
          // final ly1 = box.get('ly');
          // print('----------');
          // print(li1 is List);
          // print(li1 is List<int>);
          // print(li1 is List<num>);
          // print(li1 is List<Object>);
          // print(li1 is List<Object?>);
          // print('----------');
          // print(ln1 is List);
          // print(ln1 is List<int>);
          // print(ln1 is List<num>);
          // print(ln1 is List<Object>);
          // print(ln1 is List<Object?>);
          // print('----------');
          // print(lx1 is List);
          // print(lx1 is List<int>);
          // print(lx1 is List<num>);
          // print(lx1 is List<Object>);
          // print(lx1 is List<Object?>);
          // print('----------');
          // print(ly1 is List);
          // print(ly1 is List<int>);
          // print(ly1 is List<num>);
          // print(ly1 is List<Object>);
          // print(ly1 is List<Object?>);

          // ========================================

          // final list = [
          //   {'a': 1, 'b': true, 'c': null},
          //   null,
          //   {'a': 1, 'b': true, 'c': null},
          // ];
          // await box.put('list_obj_key', list);

          // final list1 = box.get('list_obj_key');
          // print(list1);

          // final list2 = box.getMapList('list_obj_key');
          // print(list2);

          // ========================================

          // final bee = Bee(name: 'kim', role: 10);
          // final json = bee.toJson();
          // await box.setValue('bee_key', json);

          // final beemap = box.getMap('bee_key') ?? {};
          // print(beemap);
          // final bee1 = Bee.fromJson(beemap);
          // print(bee1);

          // final bee2 = box.getObject('bee_key', Bee.fromJson);
          // print(bee2);

          // ========================================

          // final list = [Bee(name: 'kim', role: 10).toJson(), null, Bee(name: 'kim', role: 11).toJson(), 'asdf'];
          // await box.setValue('bee_list_key', list);

          // final list1 = box.get('bee_list_key');
          // print(list1);

          // final list2 = box.getObjectList('bee_list_key', Bee.fromJson);
          // print(list2);

          print("end");
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("data"),
    );
  }
}
