import 'dart:math';
import 'package:flutter/material.dart';

class TypePage extends StatelessWidget {
  TypePage({super.key}) {
    // test();

    // testObjectDynamic();
    // testListLiteral();
    // testMapLiteral();

    // testBasicTypes1();
    // testBasicTypes2();

    // testListTypes1();
    // testListTypes2();

    // testMapTypes1();
    // testMapTypes2();

    testListRetrive();
    testMapRetrive();
  }

  // 一个很怪的行为，<int> 既是 <int> 也是 <int?>
  void test() {
    var list1 = [1, 2, 3, null];
    var list2 = [1, 2, 3];
    List<int?> list3 = [1, 2, 3];
    print(list1 is List<int>); // 真 <int?> 不是 <int>
    print(list2 is List<int>); // 真 <int> 是 <int>
    print(list3 is List<int>); // 假 <int?> 不是 <int>
    print(list1 is List<int?>); // 真 <int?> 是 <int?>
    print(list2 is List<int?>); // 真 <int> 是 <int?>  <= 这个很怪
    print(list3 is List<int?>); // 假 <int?> 是 <int?>
  }

  // ================================================================================
  // 1) Object 变量，编译时检查类型，只能调用 Object 拥有的方法。虽然底层可能真的是 String，但也不能调 String 的方法
  // dynamic 变量，运行时检查类型，调任何方法都能编译通过，但最终没有这方法会崩
  //
  // 2) Object 无法接受 null 值，请用 Object?。dynamic 接受 null 值，使用 dynamic? 是多余的
  //
  // 少用 dynamic，它没有类型检查，因为它容易导致意外问题，我们不需要这种惊喜
  //
  // 以下函数参数是 dynamic，你能传 int?/int/String?/String，编译能通过。但运行传非字符串会崩
  // int assume(dynamic object) {
  //   String string = object;
  //   return string.length;
  // }
  void testObjectDynamic() {
    // 1)
    final str = 'abcd';
    print(str.substring(1));

    // Object aa = str;
    // print(aa.substring(1)); // 编译出错

    dynamic bb = str;
    print(bb.substring(1)); // 编译通过

    // final i = 10;
    // dynamic cc = i;
    // print(cc.substring(1)); // 编译通过，但运行时会崩

    // 2)
    // String? s = null;
    // Object a = s;
    // dynamic b = s;

    // other)
    // Null 这个类有 toString() 和 hashCode，Object 上面也有，所以 Object? 上面调这俩方法不用加问号，调其它方法要加
    final v = Random().nextBool();
    print(v);
    final s = getString(v);
    print(s.toString()); // 不用加问号
    print(s.hashCode); // 不用加问号
    print(s?.substring(1));
  }

  // ================================================================================
  // 结论：
  // 1) [true, false] 这种单一类型的字面量，都能推断出正确的类型
  // 2) [1, 1.1] 推断出 <num>，其它两两三三混的都推断出 <Object>
  // 3) 基本类型混上 数组/字典，推断出的类型也是 <Object>
  void testListLiteral() {
    // final b = [true, false];
    // final i = [1, 2];
    // final d = [1.1, 2.1];
    // final s = ['aa', 'bb'];

    // final a = [true, 1, 1.1, 'aa'];

    // final a = [true, 1, 1.1, 'aa', ['asdf'], {'a': 1}];
  }
  // 结论：
  // 1) 单一类型字面量，推断出 <String, int> 这类，这是正常的
  // 2) {'a': 11, 'b': 1.2} 推断出 <String, num>，其它推断出 <String, Object>
  // 3) 基本类型混上 数组/字典，推断出的类型也是 <String, Object>
  void testMapLiteral() {
    // final b = {'a': true};
    // final i = {'a': 1};
    // final d = {'a': 1.1};
    // final s = {'a': 'aa'};

    // final a = {'a': 1.2, 'b': [1, false]};

    // final a = [true, 1, 1.1, 'aa'];
  }

  // ================================================================================
  // 结论：
  // 1) 如果函数返回可选值，value is int? 一直是真，当值非空时 value is int 才是真
  // 2) final i = 10; i is int; i is int?，它既是 int 也是 int?。很怪的特性
  void testBasicTypes1() {
    final v = Random().nextBool();
    print(v);

    final b = getBool(v);
    print('b is bool: ${b is bool}');
    print('b is bool?: ${b is bool?}');

    final i = getInt(v);
    print('i is int: ${i is int}');
    print('i is int?: ${i is int?}');

    final d = getDouble(v);
    print('d is double: ${d is double}');
    print('d is double?: ${d is double?}');

    final s = getString(v);
    print('s is String: ${s is String}');
    print('s is String?: ${s is String?}');
  }

  void testBasicTypes2() {
    final b = true;
    print('b is bool: ${b is bool}');
    print('b is bool?: ${b is bool?}');

    final i = 10;
    print('i is int: ${i is int}');
    print('i is int?: ${i is int?}');

    final d = 1.2;
    print('d is double: ${d is double}');
    print('d is double?: ${d is double?}');

    final s = 'abc';
    print('s is String: ${s is String}');
    print('s is String?: ${s is String?}');
  }

  bool? getBool(bool v) => v ? true : null;
  int? getInt(bool v) => v ? 10 : null;
  double? getDouble(bool v) => v ? 1.2 : null;
  String? getString(bool v) => v ? 'abc' : null;

  // ================================================================================
  // 结论：同上
  void testListTypes1() {
    final v = Random().nextBool();
    print(v);

    final b = getBoolList(v);
    print('b is List<bool>: ${b is List<bool>}');
    print('b is List<bool>?: ${b is List<bool>?}');

    final i = getIntList(v);
    print('i is List<int>: ${i is List<int>}');
    print('i is List<int>?: ${i is List<int>?}');

    final d = getDoubleList(v);
    print('d is List<double>: ${d is List<double>}');
    print('d is List<double>?: ${d is List<double>?}');

    final n = getNumList(v);
    print('n is List<num>: ${n is List<num>}');
    print('n is List<num>?: ${n is List<num>?}');

    final s = getStringList(v);
    print('s is List<String>: ${s is List<String>}');
    print('s is List<String>?: ${s is List<String>?}');
  }

  void testListTypes2() {
    final b = [true];
    print('b is List<bool>: ${b is List<bool>}');
    print('b is List<bool>?: ${b is List<bool>?}');

    final i = [10];
    print('i is List<int>: ${i is List<int>}');
    print('i is List<int>?: ${i is List<int>?}');
  }

  List<bool>? getBoolList(bool v) => v ? [true] : null;
  List<int>? getIntList(bool v) => v ? [10] : null;
  List<double>? getDoubleList(bool v) => v ? [1.2] : null;
  List<num>? getNumList(bool v) => v ? [1, 1.2] : null;
  List<String>? getStringList(bool v) => v ? ['abc'] : null;

  // ================================================================================
  // 结论：同上
  void testMapTypes1() {
    final v = Random().nextBool();
    print(v);

    final b = getBoolMap(v);
    print('b is Map<String, bool>: ${b is Map<String, bool>}');
    print('b is Map<String, bool>?: ${b is Map<String, bool>?}');

    final i = getIntMap(v);
    print('i is Map<String, int>: ${i is Map<String, int>}');
    print('i is Map<String, int>?: ${i is Map<String, int>?}');

    final d = getDoubleMap(v);
    print('d is Map<String, double>: ${d is Map<String, double>}');
    print('d is Map<String, double>?: ${d is Map<String, double>?}');

    final n = getNumMap(v);
    print('n is Map<String, num>: ${n is Map<String, num>}');
    print('n is Map<String, num>?: ${n is Map<String, num>?}');

    final s = getStringMap(v);
    print('s is Map<String, String>: ${s is Map<String, String>}');
    print('s is Map<String, String>?: ${s is Map<String, String>?}');
  }

  void testMapTypes2() {
    final b = {'a': true};
    print('b is Map<String, bool>: ${b is Map<String, bool>}');
    print('b is Map<String, bool>?: ${b is Map<String, bool>?}');

    final i = {'a': 1};
    print('i is Map<String, int>: ${i is Map<String, int>}');
    print('i is Map<String, int>?: ${i is Map<String, int>?}');
  }

  Map<String, bool>? getBoolMap(bool v) => v ? {'a': true} : null;
  Map<String, int>? getIntMap(bool v) => v ? {'a': 1} : null;
  Map<String, double>? getDoubleMap(bool v) => v ? {'a': 1.2} : null;
  Map<String, num>? getNumMap(bool v) => v ? {'a': 1, 'b': 1.2} : null;
  Map<String, String>? getStringMap(bool v) => v ? {'a': 'xxx'} : null;

  // ================================================================================
  void testListRetrive() {
    final list = getList();
    final b = list[0];
    print(b is bool);
    final i = list[1];
    print(i is int);
    final lb = list[2];
    print(lb is List<bool>);
    final li = list[3];
    print(li is List<int>);
    final lx = list[4];
    print(lx is List<Object>);
    final mb = list[5];
    print(mb is Map<String, bool>);
    final mi = list[6];
    print(mi is Map<String, int>);
    final mx = list[7];
    print(mx is Map<String, Object>);
  }

  void testMapRetrive() {
    final map = getMap();
    final b = map['b'];
    print(b is bool);
    final i = map['i'];
    print(i is int);
    final lb = map['lb'];
    print(lb is List<bool>);
    final li = map['li'];
    print(li is List<int>);
    final lx = map['lx'];
    print(lx is List<Object>);
    final mb = map['mb'];
    print(mb is Map<String, bool>);
    final mi = map['mi'];
    print(mi is Map<String, int>);
    final mx = map['mx'];
    print(mx is Map<String, Object>);
  }

  List<Object> getList() => [
    true,
    10,
    [true, false],
    [10, 20],
    [true, 10],
    {'a': true},
    {'a': 10},
    {'a': 10, 'b': true},
  ];

  Map<String, Object> getMap() => {
    'b': true,
    'i': 10,
    'lb': [true, false],
    'li': [10, 20],
    'lx': [true, 10],
    'mb': {'a': true},
    'mi': {'a': 10},
    'mx': {'a': 10, 'b': true},
  };

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
