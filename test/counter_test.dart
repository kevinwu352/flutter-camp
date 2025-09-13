import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_camp/0test/counter.dart';

// expect(a_value, value_or_matcher)
// 当第二参数是值时，会默认使用 equals 这个 Matcher
//
// equals 对比基本类型的集合时，会比较内容，所以测试这边用 equals 比较它们是真，正常代码那边则不一样
//   final list1 = [1];
//   final list2 = [1];
//   print(list1 == list2); 这里是 false，比较的是地址

// 这好像是看前面这值的 isNotEmpty 属性
// expect(list1, isNotEmpty);

// test('abc', () {
//   final res1 = Res(11);
//   final res2 = Res(11);
//   expect(res1, res2);
// });
// 本来这里要失败的，因为是不同的对象。但如果 Res 有自定义的 == 方法，里面比较值，则能通过
// 另外，写 == 的时候，编译器提示把 hashCode 也自己实现一下
//   int get hashCode => Object.hash(name, age); // 多个值时，用 Object.hash 合并成一个 hash
class Res {
  Res(this.value);
  final int value;
  @override
  String toString() => 'Result:$value';

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) || other is Res && runtimeType == other.runtimeType && value == other.value;
  // @override
  // int get hashCode => value.hashCode;
}

void main() {
  group("Counter Tests", () {
    late Counter counter;

    // 最前面执行
    setUpAll(() {
      print("setup all");
    });
    // 每个 test 前执行
    setUp(() {
      print("setup");
      counter = Counter();
    });
    // 每个 test 后执行
    tearDown(() {
      print("tear");
    });
    // 最后面执行
    tearDownAll(() {
      print("tear all");
    });

    test("increase", () {
      counter.increase();
      expect(counter.value, 1);
    });

    test("decrease", () {
      counter.decrease();
      expect(counter.value, -1);
    });

    test("async 1", () async {
      final val = await counter.getval();
      expect(val, 10);
    });

    test("async 2", () {
      final f = counter.getval();
      // 这几个没完全搞明白
      // expectLater(f, completes);
      expectLater(f, completion(10));
      // expectLater(f, throwsA(isException));
      // expectLater(f, doesNotComplete);
    });
  });
}
