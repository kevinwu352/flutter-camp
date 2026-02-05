import 'package:flutter_test/flutter_test.dart';

import 'package:hive/hive.dart';
import 'package:krex/storage/hive_ext.dart';

void main() {
  late Box box;

  setUpAll(() async {
    final dir =
        '/Users/kevin/Library/Developer/CoreSimulator/Devices/B064EFFA-5833-423F-8DB0-E1083EA4B76C/data/Containers/Data/Application/E17286EE-2007-4CBF-B48E-893CC944DF0C/Documents/hive-ext-tests';
    Hive.init(dir);
    box = await Hive.openBox('defaults');
  });

  setUp(() async {
    await box.clear();

    await box.put('bool_key', true);
    await box.put('int_key', 102);
    await box.put('double_key', 1.234);
    await box.put('string_key', 'xiha');

    await box.put('list_key', [1, 'a']);
    await box.put('map_key', {'a': 1, 'b': 'x'});

    await box.put('obj_key', Person(name: 'kim', age: 10).toJson());

    // print('clear ----------------------------------');
    // print(box.toMap());
  });

  group('HiveExtTests', () {
    test('basic types', () {
      expect(box.getBool('bool_key'), true);
      expect(box.getInt('bool_key'), null);
      expect(box.getDouble('bool_key'), null);
      expect(box.getString('bool_key'), null);

      expect(box.getBool('int_key'), null);
      expect(box.getInt('int_key'), 102);
      expect(box.getDouble('int_key'), null);
      expect(box.getString('int_key'), null);

      expect(box.getBool('double_key'), null);
      expect(box.getInt('double_key'), null);
      expect(box.getDouble('double_key'), 1.234);
      expect(box.getString('double_key'), null);

      expect(box.getBool('string_key'), null);
      expect(box.getInt('string_key'), null);
      expect(box.getDouble('string_key'), null);
      expect(box.getString('string_key'), 'xiha');
    });

    test('collection types', () {
      expect(box.getList('list_key'), [1, 'a']);
      expect(box.getMap('list_key'), null);

      expect(box.getList('map_key'), null);
      expect(box.getMap('map_key'), {'a': 1, 'b': 'x'});
    });

    test('object types', () {
      expect(box.getObject('obj_key', Person.fromJson), Person(name: 'kim', age: 10));
    });
  });
}

class Person {
  Person({required this.name, required this.age});
  final String name;
  final int age;

  Person.fromJson(Map<String, dynamic> json) : name = json['name'] as String, age = json['age'] as int;
  Map<String, dynamic> toJson() => {'name': name, 'age': age};

  @override
  String toString() => '$name $age';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && name == other.name && age == other.age;
  @override
  int get hashCode => Object.hash(name, age);
}
