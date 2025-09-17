import 'dart:convert';
import 'package:flutter/material.dart';

// class Res<T> {
//   Res({required this.code, required this.message});
//   int code;
//   String message;
//   T? data;
//   Res.fromJson(Map<String, dynamic> json) : code = json['code'] as int, message = json['message'] as String;
// }

// class Book {
//   Book({required this.name, required this.author});
//   String name;
//   String author;
//   Book.fromJson(Map<String, dynamic> json) : name = json['name'] as String, author = json['author'] as String;
//   Map<String, dynamic> toJson() => {'name': name, 'author': author};
// }

// // '{"code":200,"message":"done","data":{"name":"Little Rock","author":"Kim"}}'
// // '{"code":200,"message":"done","data":[{"name":"Little Rock","author":"Kim"},{"name":"Nowhere","author":"Eric"}]}'

// Res<T> getObj<T>(String str, T Function(Map<String, dynamic>) init) {
//   Map<String, Object?> json = jsonDecode(str);
//   final res = Res<T>.fromJson(json);
//   final data = json['data'];
//   res.data = data is Map ? init(data.map((k, v) => MapEntry(k.toString(), v))) : null;
//   return res;
// }

// Res<List<T>> getLst<T>(String str, T Function(Map<String, dynamic>) init) {
//   Map<String, Object?> json = jsonDecode(str);
//   final res = Res<List<T>>.fromJson(json);
//   final data = json['data'];
//   res.data = data is List
//       ? data.whereType<Map>().map((e) => init(e.map((k, v) => MapEntry(k.toString(), v)))).toList()
//       : null;
//   return res;
// }

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print('111');
          // final str1 = '{"code":200,"message":"done","data":{"name":"Little Rock","author":"Kim"}}';
          // final str2 =
          //     '{"code":200,"message":"done","data":[{"name":"Little Rock","author":"Kim"},{"name":"Nowhere","author":"Eric"}]}';

          // final obj1 = getObj(str1, Book.fromJson);
          // print(obj1);

          // final obj2 = getLst(str2, Book.fromJson);
          // print(obj2);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("body"),
    );
  }
}
