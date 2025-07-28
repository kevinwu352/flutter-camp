import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Customer {
  final String name;
  final int age;
  @override
  String toString() {
    return "$name $age";
  }

  const Customer({required this.name, required this.age});

  // 1) 类型不同时，会异常，就算 age 是可选，模式匹配也用可选，也会异常
  // 2) 缺少字段时，会异常，可选也不行
  factory Customer.fromJson1(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'age': int age} => Customer(name: name, age: age),
      _ => throw FormatException('failed to load customer'),
    };
  }
  // 1) 类型不同时，as 直接异常，as int? 也不行
  // 2) 缺少字段时， as 直接异常，as int? 能成功
  factory Customer.fromJson2(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final age = data['age'] as int;
    return Customer(name: name, age: age);
  }
}

class HttpPage extends StatelessWidget {
  const HttpPage({super.key});

  void parse() {
    // try {
    // final str = '{"name":"kevin","age":18}';
    final str = '{"name":"kevin","age":"19"}';
    final json = jsonDecode(str) as Map<String, dynamic>;
    print(json);
    final cs = Customer.fromJson1(json);
    print(cs);
    // } catch (e) {
    //   print("got $e");
    // } finally {
    //   print("clean up");
    // }
  }

  Customer work(String str) {
    print("111");
    // final str = '{"name":"kevin","age":"19"}';
    final json = jsonDecode(str) as Map<String, dynamic>;
    print(json);
    final cs = Customer.fromJson1(json);
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
          // print("begin");
          // final response = await http.get(
          //   Uri.parse('https://dummyjson.com/c/660c-9047-47c3-b9db'),
          // );
          // if (response.statusCode == 200) {
          //   // If the server did return a 200 OK response,
          //   // then parse the JSON.
          //   final c = Customer.fromJson(
          //     jsonDecode(response.body) as Map<String, dynamic>,
          //   );
          //   print(c);
          // }

          // var url = 'https://pae.ipportalegre.pt/testes2/wsjson/api/app/ws-authenticate';
          // var url = 'https://dummyjson.com/c/660c-9047-47c3-b9db';

          // Map data = {'apikey': '12345678901234567890'};

          // var body = json.encode(data);

          // var response = await http.post(
          //   Uri.parse(url),
          //   headers: {"Content-Type": "application/json"},
          //   body: body,
          // );
          // print(response.body);

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
