import 'dart:convert';
import 'package:flutter/material.dart';

class Res {
  Res({required this.code, required this.message});
  int code;
  String message;
  Object? data;
  Res.fromJson(Map<String, dynamic> json) : code = json['code'] as int, message = json['message'] as String;
  T? getObject<T>() => data is T ? data as T : null;
  List<T>? getList<T>() => data is List ? (data as List).whereType<T>().toList() : null;
}

class Book {
  Book({required this.name, required this.author});
  String name;
  String author;
  Book.fromJson(Map<String, dynamic> json) : name = json['name'] as String, author = json['author'] as String;
  Map<String, dynamic> toJson() => {'name': name, 'author': author};
}

// null
// bool/int/double
// string
// object
// array
Res parse<T>(String str, [T Function(Map<String, dynamic>)? init]) {
  Map<String, Object?> json = jsonDecode(str);
  final res = Res.fromJson(json);
  final data = json['data'];
  if (data is List) {
    if (data.isEmpty) {
      res.data = data;
    } else if (data.every((e) => e == null)) {
      res.data = data;
    } else if (data.every((e) => e is bool?)) {
      res.data = data.whereType<bool?>().toList();
    } else if (data.every((e) => e is int?)) {
      res.data = data.whereType<int?>().toList();
    } else if (data.every((e) => e is double?)) {
      res.data = data.whereType<double?>().toList();
    } else if (data.every((e) => e is num?)) {
      res.data = data.whereType<num?>().toList();
    } else if (data.every((e) => e is String?)) {
      res.data = data.whereType<String?>().toList();
    } else if (data.every((e) => e is Map?)) {
      res.data = data.map((e) => e != null ? init?.call(e) : null).whereType<T?>().toList();
    } else {
      res.data = data; // list? should not be here. fxxk
    }
  } else {
    if (data is Map) {
      res.data = init?.call(data.map((k, v) => MapEntry(k.toString(), v)));
    } else {
      // null, bool, int, double, String
      // can't be any other type. there's no other type, right?
      res.data = data;
    }
  }
  return res;
}

class ParsePage extends StatelessWidget {
  const ParsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final str11 = '{"code":200,"message":"done","data":null}';
          // final str12 = '{"code":200,"message":"done","data":true}';
          // final str13 = '{"code":200,"message":"done","data":10}';
          // final str14 = '{"code":200,"message":"done","data":1.23}';
          // final str15 = '{"code":200,"message":"done","data":"god"}';
          // final str16 = '{"code":200,"message":"done","data":{"name":"Little Rock","author":"Kim"}}';
          // final res11 = parse(str11);
          // print(res11.data == null);
          // final res12 = parse(str12);
          // print(res12.data is bool);
          // final res13 = parse(str13);
          // print(res13.data is int);
          // final res14 = parse(str14);
          // print(res14.data is double);
          // final res15 = parse(str15);
          // print(res15.data is String);
          // final res16 = parse(str16, Book.fromJson);
          // print(res16.data is Book);

          // final str21 = '{"code":200,"message":"done","data":[]}';
          // final str22 = '{"code":200,"message":"done","data":[null, null]}';
          // final str23 = '{"code":200,"message":"done","data":[true, null, false]}';
          // final str24 = '{"code":200,"message":"done","data":[10,null,11]}';
          // final str25 = '{"code":200,"message":"done","data":[1.23,null,2.23]}';
          // final str26 = '{"code":200,"message":"done","data":[1,null,2.23]}';
          // final str27 = '{"code":200,"message":"done","data":["god",null,"yep"]}';
          // final str28 =
          //     '{"code":200,"message":"done","data":[{"name":"Little Rock","author":"Kim"},null,{"name":"Nowhere","author":"Eric"}]}';

          // final res21 = parse(str21);
          // print(res21.getList<bool?>() is List<bool?>);
          // print(res21.getList<bool?>() is List<bool>);
          // print(res21.getList<bool>() is List<bool?>);
          // print(res21.getList<bool>() is List<bool>);
          // print(res21.getList<int?>() is List<int?>);
          // print(res21.getList<int?>() is List<int>);
          // print(res21.getList<int>() is List<int?>);
          // print(res21.getList<int>() is List<int>);
          // print(res21.getList<double?>() is List<double?>);
          // print(res21.getList<double?>() is List<double>);
          // print(res21.getList<double>() is List<double?>);
          // print(res21.getList<double>() is List<double>);
          // print(res21.getList<String?>() is List<String?>);
          // print(res21.getList<String?>() is List<String>);
          // print(res21.getList<String>() is List<String?>);
          // print(res21.getList<String>() is List<String>);

          // final res22 = parse(str22);
          // print(res22.getList<bool?>() is List<bool?>);
          // print(res22.getList<bool?>() is List<bool>);
          // print(res22.getList<bool>() is List<bool?>);
          // print(res22.getList<bool>() is List<bool>);
          // print(res22.getList<int?>() is List<int?>);
          // print(res22.getList<int?>() is List<int>);
          // print(res22.getList<int>() is List<int?>);
          // print(res22.getList<int>() is List<int>);
          // print(res22.getList<double?>() is List<double?>);
          // print(res22.getList<double?>() is List<double>);
          // print(res22.getList<double>() is List<double?>);
          // print(res22.getList<double>() is List<double>);
          // print(res22.getList<String?>() is List<String?>);
          // print(res22.getList<String?>() is List<String>);
          // print(res22.getList<String>() is List<String?>);
          // print(res22.getList<String>() is List<String>);

          // final res23 = parse(str23);
          // print(res23.data is List<bool?>);
          // print(res23.data is List<bool>);
          // print(res23.getList<bool?>() is List<bool?>);
          // print(res23.getList<bool?>() is List<bool>);
          // print(res23.getList<bool>() is List<bool?>);
          // print(res23.getList<bool>() is List<bool>);

          // final res24 = parse(str24);
          // print(res24.data is List<int?>);
          // print(res24.data is List<int>);
          // print(res24.getList<int?>() is List<int?>);
          // print(res24.getList<int?>() is List<int>);
          // print(res24.getList<int>() is List<int?>);
          // print(res24.getList<int>() is List<int>);

          // final res25 = parse(str25);
          // print(res25.data is List<double?>);
          // print(res25.data is List<double>);
          // print(res25.getList<double?>() is List<double?>);
          // print(res25.getList<double?>() is List<double>);
          // print(res25.getList<double>() is List<double?>);
          // print(res25.getList<double>() is List<double>);

          // final res26 = parse(str26);
          // print(res26.data is List<num?>);
          // print(res26.data is List<num>);
          // print(res26.getList<num?>() is List<num?>);
          // print(res26.getList<num?>() is List<num>);
          // print(res26.getList<num>() is List<num?>);
          // print(res26.getList<num>() is List<num>);

          // final res27 = parse(str27);
          // print(res27.data is List<String?>);
          // print(res27.data is List<String>);
          // print(res27.getList<String?>() is List<String?>);
          // print(res27.getList<String?>() is List<String>);
          // print(res27.getList<String>() is List<String?>);
          // print(res27.getList<String>() is List<String>);

          // final res28 = parse(str28, Book.fromJson);
          // print(res28.data is List<Book?>);
          // print(res28.data is List<Book>);
          // print(res28.getList<Book?>() is List<Book?>);
          // print(res28.getList<Book?>() is List<Book>);
          // print(res28.getList<Book>() is List<Book?>);
          // print(res28.getList<Book>() is List<Book>);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("body"),
    );
  }
}

// '{"code":200,"message":"done","data":{"name":"Little Rock","author":"Kim"}}'
// '{"code":200,"message":"done","data":[{"name":"Little Rock","author":"Kim"},{"name":"Nowhere","author":"Eric"}]}'

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
