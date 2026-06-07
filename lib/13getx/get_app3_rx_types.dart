// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Rx 类型的用法

// 三种声明 Rx 类型的方式
final aaa = RxString('');
final bbb = Rx<String>('');
final ccc = ''.obs;

class GetApp3 extends StatelessWidget {
  const GetApp3({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

final name = 'abc'.obs;
var count = 0.obs;
final flag = false.obs;
final list = [0, 1, 2].obs;
final usr = Usr(name: "kevin", age: 18).obs;

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
            Obx(() {
              print('obx updated');
              return Text("$usr");
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // .obs 的变量，你直接用它的时候，能展示出它内部真实的值，但它的类型是 Rx 的
          var message = 'Hello world'.obs;
          print('Message "$message" has Type ${message.runtimeType}');
          // 对于 Rx 类型，你不能 message.substring(0, 4)，你要把 value 取出来用
          print(message.value.substring(0, 4));

          // 文档说这能把内部值改为 null，但这里居然编译错误，说没这方法
          // flag.nil();

          // ================================================================================
          // String

          // 赋相同值 Obx 不会重建
          // name.value = "xxx";
          //
          // 所有的 Rx 类型都是可被调用的，且返回新值，相当于 Swift 的 callAsFunction
          // 这种方式传 null 不会起作用
          // 赋相同值 Obx 不会重建
          // final value = name(null);
          // print("new-value:$value");
          //
          // 获取当前最新值
          // final value = name();
          // print("new-value:$value");

          // ================================================================================
          // int

          // 返回的类型是 Rx 的
          // 特别注意，非常不合理，这里的 count 内部的值居然被修改了，界面也更新了
          // final value = count + 1;
          // print(value.value);
          //
          // 但是这居然会编译错误，要把变量改成 var 才行
          // count += 1;
          // 能比较大小，返回的是 bool
          // final value = count > 2;
          // print(value);

          // ================================================================================
          // bool

          // flag.toggle();

          // ================================================================================
          // Collection

          // 文档说 Rx 支持 json，但感觉没必要，还是把 .value 取出来用比较好
          // print('json: ${jsonEncode(list)}, type: ${list.runtimeType}');
          // 文档还说 RxMap RxList RxSet 能当普通类型用
          //
          // 能更新界面
          // list.add(10);
          // 能取值
          // final value = list[2];
          // print("value:$value");

          // ================================================================================
          // 自定义类型

          // 必须调用 refresh 才能刷新界面
          // usr.value.name = "god";
          // usr.refresh();
          // 或者用 update
          usr.update((val) => val?.name = "kkk");
          // refresh / update 调一次就会刷新 Obx 一次
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class Usr {
  String name;
  int age;
  Usr({required this.name, required this.age});
  @override
  String toString() => '$name, $age years old';
}
