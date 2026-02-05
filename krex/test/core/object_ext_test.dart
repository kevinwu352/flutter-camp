import 'package:flutter_test/flutter_test.dart';

import 'package:krex/core/object_ext.dart';

void main() {
  group('ObjectExtTests', () {
    test('object.asOr', () {
      final ia = _getInt(true);
      expect(ia.asOr<int>() ?? 12, 10);
      final ib = _getInt(false);
      expect(ib.asOr<int>() ?? 12, 12);

      final list = _getList();
      expect(list[0].asOr<bool>(), true);
      expect(list[1].asOr<int>(), 10);
      expect(list[2].asOr<List<bool>>(), [true, false]);
      expect(list[3].asOr<List<int>>(), [10, 20]);
      expect(list[4].asOr<List<Object>>(), [true, 10]);
      expect(list[5].asOr<Map<String, bool>>(), {'a': true});
      expect(list[6].asOr<Map<String, int>>(), {'a': 10});
      expect(list[7].asOr<Map<String, Object>>(), {'a': 10, 'b': true});

      final map = _getMap();
      expect(map['b'].asOr<bool>(), true);
      expect(map['i'].asOr<int>(), 10);
      expect(map['lb'].asOr<List<bool>>(), [true, false]);
      expect(map['li'].asOr<List<int>>(), [10, 20]);
      expect(map['lx'].asOr<List<Object>>(), [true, 10]);
      expect(map['mb'].asOr<Map<String, bool>>(), {'a': true});
      expect(map['mi'].asOr<Map<String, int>>(), {'a': 10});
      expect(map['mx'].asOr<Map<String, Object>>(), {'a': 10, 'b': true});
    });
  });
}

int? _getInt(bool v) => v ? 10 : null;

List<Object> _getList() => [
  true,
  10,
  [true, false],
  [10, 20],
  [true, 10],
  {'a': true},
  {'a': 10},
  {'a': 10, 'b': true},
];

Map<String, Object> _getMap() => {
  'b': true,
  'i': 10,
  'lb': [true, false],
  'li': [10, 20],
  'lx': [true, 10],
  'mb': {'a': true},
  'mi': {'a': 10},
  'mx': {'a': 10, 'b': true},
};
