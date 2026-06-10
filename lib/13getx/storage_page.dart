import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/core/core.dart';

extension GetStorageExt on GetStorage {
  bool? getBool(String key) => withValue(read(key), (v) => v is bool ? v : null);
  int? getInt(String key) => withValue(read(key), (v) => v is int ? v : null);
  double? getDouble(String key) => withValue(read(key), (v) => v is double ? v : null);
  String? getString(String key) => withValue(read(key), (v) => v is String ? v : null);
  Map? getMap(String key) => withValue(read(key), (v) => v is Map ? v : null);
  List? getList(String key) => withValue(read(key), (v) => v is List ? v : null);

  T? getObj<T>(String key, [T Function(Map<String, dynamic>)? init]) =>
      withValue(read(key), (v) => v is T? ? v : init?.call(v));

  // T? getObj<T>(String key, [T Function(Map<String, dynamic>)? init]) => withValue(read(key), (v) {
  //   print(v is T? ? true : false);
  //   return v is T? ? v : init?.call(v);
  // });
}
// 总结：
// 你存的 Obj，磁盘上肯定是 Map，重启回来内存里也是 Map，但本次读的时候是 Obj，所以要避免这种情况
// 那么，你存的 Obj 就用 Obj 来读，一定不会错
// 你存的 Map，可以用 Obj/Map 来读，都不会错

// 注意仓库实例是有缓存的，是用工厂函数实现的，不会每次都创建实例，所以放心大胆地用下面的构造器吧
//   GetStorage box = GetStorage();
//   GetStorage box = GetStorage("asdf");
//
// 默认的
//   await GetStorage.init()
// 自己建另外一个仓库
//   await GetStorage.init("asdf")

//   box.read("aa")
//   box.read<int>("aa") 如果类型不符会崩
//
// 能存 null 进去，也能读出 null 来，但 hasData 是 false
//   box.write("aa", null)
//   writeIfNull 原数据为 null 才能存进去
//   writeInMemory 存到内存，后续可以用 save() 同步到磁盘
// 存 Obj 进去，会转化成 json 存到磁盘，必须实现 toJson 否则会异常
// 如果马上读取，读出来的是 Obj 类型
// 如果重启 App 再读取，读出来的是 Map
//   所以，为了保证一致性，存的时候要不要存 obj.toJson()？
//
// 内部是取出值 和 null 对比
//   box.hasData("aa")
//
// 同步到磁盘
//   box.save()

// box.getKeys()
// box.getValues()

// 清除单个
//   box.remove("bb")
// 清除所有的
//   box.erase()

// 观察仓库变化，新建key / 给某key存相同值 也会触发
//   final cancel = box.listen(() {})
// 观察仓库内单个值变化，新建key / 给某key存相同值 也会触发
//   final cancel = box.listenKey("aa", (value) {})
// 取消订阅
//   cancel()

class AppDefaults extends GetxService {
  Future<AppDefaults> init() async {
    await GetStorage("defaults-app").initStorage;
    return this;
  }

  GetStorage get storage => GetStorage("defaults-app");

  int? get theme => storage.getInt("key");
  set theme(int? value) => storage.write("key", value);
}

// 替换时用
// await Get.find<UserDefaults>().init("god");
class UserDefaults extends GetxService {
  Future<UserDefaults> init([String uid = ""]) async {
    _name = "defaults-${uid.isNotEmpty ? uid : "shared"}";
    await GetStorage(_name).initStorage;
    return this;
  }

  var _name = "";
  GetStorage get storage => GetStorage(_name);

  int? get theme => storage.getInt("key");
  set theme(int? value) => storage.write("key", value);
}

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("storage")),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                GetStorage box = GetStorage();
                box.listen(() {
                  print("box changed");
                });
                box.listenKey("bb", (value) {
                  print("box changed, $value");
                });
              },
              child: Text("listen"),
            ),
            TextButton(
              onPressed: () {
                GetStorage box = GetStorage();
                // box.write("aa", null);
                // box.write("bb", 22);
                // box.write("bol", true);
                // box.write("int", 101);
                // box.write("dbl", 1.23);
                // box.write("str", "xixi");
                // box.write("lst", [1, 2, 3]);
                box.write("obj", Usr(name: "kkk", age: 111));
              },
              child: Text("write"),
            ),
            TextButton(
              onPressed: () {
                GetStorage box = GetStorage();
                // box.remove("bb");
                // box.erase();
                // print(box.hasData("aa"));
                box.remove("obj");
              },
              child: Text("remove"),
            ),
            TextButton(
              onPressed: () {
                GetStorage box = GetStorage();
                // print("aa: ${box.read("aa")}");
                // print("bb: ${box.read("bb")}");
                // print("bol: ${box.read("bol") as bool}");
                // print("int: ${box.read("int") as int}");
                // print("dbl: ${box.read("dbl") as double}");
                // print("str: ${box.read("str") as String}");
                // print("lst: ${box.read("lst")}");
                // print("obj: ${box.read("obj")}");
                // final val = box.getList("lst");
                // print(val);

                print(box.getMap("obj"));

                final val = box.getObj<Usr>("obj", Usr.fromJson);
                print(val);
              },
              child: Text("read"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
    );
  }
}

class Usr {
  String name;
  int age;
  Usr({required this.name, required this.age});
  @override
  String toString() => '$name, $age years old';

  Usr.fromJson(Map<String, dynamic> json) : name = json['name'] as String, age = json['age'] as int {
    print("init");
  }
  Map<String, dynamic> toJson() => {'name': name, 'age': age};
}
