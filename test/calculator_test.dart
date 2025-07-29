import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_camp/qa/calculator.dart';

void main() {
  group("Calculator Tests", () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('add', () {
      expect(calculator.add(2, 3), equals(5));
      expect(calculator.add(-2, 3), equals(1));
    });

    test('subtract', () {
      expect(calculator.subtract(5, 3), equals(2));
      expect(calculator.subtract(3, 5), equals(-2));
    });
  });
}
