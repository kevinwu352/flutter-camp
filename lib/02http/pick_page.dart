import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:deep_pick/deep_pick.dart';

// 注意：这些 as* 方法并不一定是安全的，有些可能会抛出异常
//   bool/int/double/string/dateTime 内部 try 了
//   但 map 内部没有 try，且用的是 cast
//   list/let 内部也没有 try

// ================================================================================

// bool: 字符串 "true"/"false" 也行
// int: 整型/浮点型/字符串。浮点数会解析异常，因为会丢失精度，传 round/truncate 就行了
// double: 整型/浮点型/字符串
// string: 看实现里面，不会失败，任何类型都会转化为字符串
// datetime

// 字典相关
// asMapOrEmpty/asMapOrNull/asMapOrThrow
//   能指定 K/V 类型 .asMapOrEmpty<String, Object?>()，否则，类型是 Map<dynamic, dynamic>
//
// String:double '{"a":1.1,"b":2.1}'
// final aa = pick(json).asMapOrEmpty<String, double>(); // 成功
// print(aa);
// final bb = json as Map<String, double>; // 异常
// print(bb);
//
// String:int/double '{"a":1.1,"b":2}'
// final aa = pick(json).asMapOrEmpty<String, double>(); // 异常，换成 <String, Object> 能成功
// print(aa);
// final bb = json as Map<String, double>; // 异常，换成 <String, Object> 也失败，换成 <String, Object?> 能成功
// print(bb);

// 数组相关
// 当真的是浮点数组时，json as List<double/double?/Object> 都异常，List<Object?> 能成功
//
// 数组里原本的 null 会被抛弃，但转换失败产生的 null 会被保留，要保留原本的 null 传递 whenNull 参数
// final aa = pick(json).asListOrEmpty((v) => v.asDoubleOrNull(), whenNull: (pick) => pick.value);
// print(aa);
// 取原始数组，类型是 List<Object?>
// final bb = pick(json).asListOrEmpty((v) => v.value, whenNull: (pick) => pick.value);
// print(bb);

// 获取原本的值，类型是 Object?
//   pick(json, 'x').letOrNull((pick) => pick.value);

class PickPage extends StatelessWidget {
  const PickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () => parse(), child: Icon(Icons.run_circle)),
      body: Text('--'),
    );
  }

  void parse() {
    // final str = '{"a":1.1,"b":"2","c":[1,2,"a","b",3,4,"c","d"],"d":{"x":11,"y":"22"}}';
    // final str = '{"a":1.1,"b":2,"c":null}';
    // final str = '{"a":1.1,"b":2.1}';
    final str = '[1.1,null,2.1,"abc"]';
    final json = jsonDecode(str);

    // 数组里原本的 null 会被抛弃，但转换失败产生的 null 会被保留，要保留原本的 null 传递 whenNull 参数
    final aa = pick(json).asListOrEmpty((v) => v.asDoubleOrNull(), whenNull: (pick) => pick.value);
    print(aa);
    // 取原始数组，类型是 List<Object?>
    final bb = pick(json).asListOrEmpty((v) => v.value, whenNull: (pick) => pick.value);
    print(bb);

    // final bb = json as List<Object?>; // 异常
    // print(bb);

    // final aa = pick(json, 'a').asIntOrNull(roundDouble: true);
    // print(aa);

    // final aa = pick(json, 'd').asMapOrEmpty<String, Object>();
    // print(aa);
    // final bb = json['d'] as Map<String, Object>;
    // print(bb);

    // final aa = pick(json, 'xxxx').letOrNull((pick) => pick.value);
    // print(aa);

    // final aa = pick(json, 'd').asMapOrEmpty();
    // print(aa);
    // final bb = pick(json, 'd').asMapOrNull();
    // print(bb);
    // final cc = pick(json, 'b').asMapOrThrow();
    // print(cc);

    // final cc1 = pick(json, 'c').asListOrNull((v) => v.asIntOrNull());
    // print(cc1);
    // final cc2 = pick(json, 'c').asListOrNull((v) => v.asStringOrThrow());
    // print(cc2);
  }
}
