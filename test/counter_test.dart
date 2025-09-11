import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_camp/0test/counter.dart';

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
