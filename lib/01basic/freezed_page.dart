import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
part 'freezed_page.g.dart';

// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'freezed_page.freezed.dart';

// flutter pub add dev:build_runner
// flutter pub add json_annotation dev:json_serializable
// flutter pub add freezed_annotation dev:freezed

// ================================================================================

// json_serializable 支持的类型
//
// bool
// int double       num BigInt
// String
//
// Enum
// DateTime
//
// Object
//                  Duration
//                  Uri
//
// List Map         Iterable Record Set
// 这些集合也是支持的类型，它能包含集合以及上面所有的类型

// JSON 里原生的类型
// Null
// bool
// int, double, num
// String
// List, Map

// ================================================================================

// @JsonSerializable
//
// List<JsonConverter<dynamic, dynamic>>? converters
//   自定义的转换器，参考下面的 EpochDateTimeConverter
//
// bool? dateTimeUtc
//   如果为真，时间编码时，先转成 utc，再转成字符串，DateTime.toUtc().toIso8601String()
//   只有编码的时候吗？会影响解码吗？
//
// bool? genericArgumentFactories
//   泛型相关，用到再研究吧
//
//
// FieldRename? fieldRename
//   编解码时，属性名称 -> 字典键 转换规则，另外 @JsonKey.name 优先级高一点
// bool? ignoreUnannotated
//   只编解有 @JsonKey 标注的属性，忽略其它一切
//   相当于 includeToJson / includeFromJson 设为 false
//
// bool? disallowUnrecognizedKeys
//   解码时，如果存在没用到的 key，就抛异常，这特性应该不可能开启
// bool? includeIfNull
//   编码时，要不要跳过空字段，另外 @JsonKey.includeIfNull 优先级高一点
//
//
// bool? anyMap
//   收到的字典不一定是 <String, dynamic>，它的 key 可能是其它值
//
// bool? checked
//   网上说是，解析时，用额外的代码来检查类型，如果类型不匹配会抛异常。（我看生成的代码的确变多了）
//
//
// String? constructor
//   生成 _$UseryFromJson 时，用哪个 constructor 来创建实例
// bool? createFactory
//   要不要生成 _$ExampleFromJson
//
// bool? createToJson
//   要不要生成 UserToJson 相关的东西，类里面 toJson 引用的这个东西
// bool? explicitToJson
//   某个嵌套的成员，如果是另外一个类，那么，我在 toJson 时，要不要显式调用这个子成员的 toJson 方法
//   默认是不调用的
//
//
// bool? createJsonSchema
//   JSON Schema 是用于校验 JSON 格式的，比如 "name": {"type":"string"}，即 name 字段必须是字符串
// bool? createJsonKeys
//   生成一个 _$UserJsonKeys 抽象类，它有一堆静态成员，每个静态成员是属性名字，值是字典里的键
//   即 static const String name = "name-in-map"
// bool? createFieldMap
//   生成一个 _$UseryFieldMap 字典，说是给其它 generator 用的
//   {"name":"name-in-map"}
// bool? createPerFieldToJson
//   看不懂，很复杂，不知道意义在哪
//
// bool? nullable
//   废弃了，没任何作用

// ================================================================================

// @JsonKey
//
// String? name
//   默认和属性名相同
// Object? defaultValue
//   默认值字面量，也能是一个全局函数/静态函数/构造器，返回对应的类型，全局函数已试
// Enum? unknownEnumValue
//   解析不出枚举时的默认值
//
// Function? fromJson
// Function? toJson
//   自定义转换函数
// Object? Function(Map<dynamic, dynamic>, String)? readValue
//   自定义读取函数，如果某个属性要用几个字段拼接而成，可以在此函数里读出来准备好，再返回
//
// bool? ignore
//   已废弃，用下面俩
// bool? includeFromJson        <= 这俩是和类相关的，作用于类
//   解码时，要不要包括此属性
//   默认是，就算没有 @JsonKey，就算有默认值，就算构造器里没有此参数，也会从 json 解析出来给此属性赋值
//   我看生成的代码里面，先用构造器创建新对象，再用 .. 给 name 赋值
// bool? includeToJson
//   编码时，要不要包括此属性
//
// bool? required               <= 这仨是和字典相关的，作用于字典
//   解析时，字典里必须有这个字段，就算值为 null 也行，否则就抛异常
// bool? disallowNullValue
//   解析时，不允许 null 值
//   特别注意：不存在这个 key，不会抛异常，存在这个 key 且值为 null 才会抛异常
// bool? includeIfNull
//   编码时，要不要跳过空字段
//   如果为 null，则继承当前这个类的配置 JsonSerializable.includeIfNull
//   为了让 fromJson/toJson 行为兼容，disallowNullValue == true，把此视为 false
//   如果 disallowNullValue 和 includeIfNull 都设为 true，生成时就会抛异常
//
// bool? nullable
//   废弃了，没任何作用

// ================================================================================

// 自定义 JsonConverter 示例
// 数字是 timestamp * 1000，也就是毫秒
//
// 本来原生的日期解析使用的是 DateTime.parse 方法，它接受一堆不同的格式，不同的字符串
// 这里实现一个数字转换成日期的自定义转换器

@JsonSerializable()
class Sample4 {
  Sample4(this.value);
  factory Sample4.fromJson(Map<String, dynamic> json) => _$Sample4FromJson(json);
  @EpochDateTimeConverter()
  final DateTime value;
  Map<String, dynamic> toJson() => _$Sample4ToJson(this);
}

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();
  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);
  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

// ================================================================================

enum Gender { male, female, unknown }

@JsonSerializable(explicitToJson: false, converters: [EpochDateTimeConverter()])
class Usery {
  String name;
  int age;
  DateTime birthday;
  Gender gender;
  Book book;

  Usery({required this.name, required this.age, required this.birthday, required this.gender, required this.book});

  factory Usery.fromJson(Map<String, dynamic> json) => _$UseryFromJson(json);
  Map<String, dynamic> toJson() => _$UseryToJson(this);

  @override
  String toString() => "$name $age $birthday $gender <$book>";
}

@JsonSerializable()
class Book {
  String name;
  Book({required this.name});
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
  @override
  String toString() => name;
}

// ================================================================================

// 前面要加 abstract / sealed
// 第二行貌似依赖于 json_annotation，只用 freezed 貌似不够，编译错误
// @freezed
// abstract class Userx with _$Userx {
//   const factory Userx({required int id, required String name, required String email}) = _Userx;
//   // factory Userx.fromJson(Map<String, dynamic> json) => _$UserxFromJson(json);
// }

class FreezedPage extends StatefulWidget {
  const FreezedPage({super.key});
  @override
  State<FreezedPage> createState() => _FreezedPageState();
}

class _FreezedPageState extends State<FreezedPage> {
  @override
  void initState() {
    super.initState();

    // final str = '{"name":"kevin", "age":18, "birthday":"2012-02-27", "gender":"female", "book":{"name":"gwtw"}}';
    final str = '{"name":"kevin", "age":18, "birthday":1780149163000, "gender":"female", "book":{"name":"gwtw"}}';
    final usr = Usery.fromJson(jsonDecode(str));
    // final usr = Usery(name: "kevin", age: 18);
    print(usr);

    // final sss = '{"value":1780149163000}';
    // final ooo = Sample4.fromJson(jsonDecode(sss));
    // print(ooo.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("freezed")),
      body: Text("data"),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
    );
  }
}
