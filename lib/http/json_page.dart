import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

// 解析一个数组是这样的
// final parsed = (jsonDecode(responseBody) as List)
//       .cast<Map<String, dynamic>>();
// return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();

// list => model
//   reviewsData.map((reviewData) => Review.fromJson(reviewData)).toList()
// model => list
//   reviews.map((review) => review.toJson()).toList()

class User {
  final String name;
  final int age;
  @override
  String toString() {
    return "$name $age";
  }

  const User({required this.name, required this.age});

  // 1) 类型不同时，会异常，就算 age 是可选，模式匹配也用可选，也会异常
  // 2) 缺少字段时，会异常，可选也不行
  factory User.fromJson1(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'age': int age} => User(name: name, age: age),
      _ => throw FormatException('failed to load customer'),
    };
  }
  // 1) 类型不同时，as 直接异常，as int? 也不行
  // 2) 缺少字段时， as 直接异常，as int? 能成功
  factory User.fromJson2(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final age = data['age'] as int;
    return User(name: name, age: age);
  }
}

class JsonPage extends StatelessWidget {
  const JsonPage({super.key});

  void parse() {
    try {
      // final str = '{"name":"kevin","age":18}';
      final str = '{"name":"kevin","age":"19"}';
      final json = jsonDecode(str) as Map<String, dynamic>;
      print(json);
      final cs = User.fromJson1(json);
      print(cs);
    } catch (e) {
      print("got $e");
    } finally {
      print("clean up");
    }
  }

  User work(String str) {
    print("111");
    // final str = '{"name":"kevin","age":"19"}';
    final json = jsonDecode(str) as Map<String, dynamic>;
    print(json);
    final cs = User.fromJson1(json);
    print(cs);
    print("222");
    return cs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // compute 里面的异常也能在外面被抓住
          try {
            print("begin");
            final str = '{"name":"kevin","age":"19"}';
            final cs = await compute(work, str);
            print(cs);
          } catch (e) {
            print("got $e");
          } finally {
            print("clean up");
          }
        },
        child: Icon(Icons.play_circle),
      ),
      body: Text("body"),
    );
  }
}
