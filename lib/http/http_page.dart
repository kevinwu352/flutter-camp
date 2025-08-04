import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String name;
  final int age;
  @override
  String toString() {
    return "$name $age";
  }

  const User({required this.name, required this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'age': int age} => User(name: name, age: age),
      _ => throw FormatException('failed to load customer'),
    };
  }
}

class HttpPage extends StatelessWidget {
  const HttpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("begin");
          final response = await http.get(Uri.parse('https://dummyjson.com/c/660c-9047-47c3-b9db'));
          if (response.statusCode == 200) {
            // If the server did return a 200 OK response,
            // then parse the JSON.
            final c = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
            print(c);
          }

          // POST 时
          // 参数传 String，头里面是 text/plain
          // 参数传 [97, 98, 99]，内容是 abc
          // 参数传 {'kk':'vv'}，头里面是 application/x-www-form-urlencoded
          // 参数传 {'kk':123}，会崩

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
        },
        child: Icon(Icons.play_circle),
      ),
      body: Text("body"),
    );
  }
}
