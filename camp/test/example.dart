// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   late Box box;
//   setUpAll(() async {
//     final dir = '/Users/kevin/Library/Developer/CoreSimulator/Devices/B064EFFA-5833-423F-8DB0-E1083EA4B76C/data/Containers/Data/Application/E17286EE-2007-4CBF-B48E-893CC944DF0C/Documents/hive-ext-tests';
//     Hive.init(dir);
//     box = await Hive.openBox('defaults');
//   });
// }

// import 'package:krex/storage/secures.dart';
// void main() {
//   group('SecuresTests', () {
//     test('version number', () {
//       expect('3.6.9'.versionNum, 3006009);
//       expect('3.6.98'.versionNum, 3006098);
//       expect('3.6.987'.versionNum, 3006987);
// 
//       expect('3.6.9'.versionNum, 3006009);
//       expect('3.65.9'.versionNum, 3065009);
//       expect('3.654.9'.versionNum, 3654009);
// 
//       expect('3.6.9'.versionNum, 3006009);
//       expect('32.6.9'.versionNum, 32006009);
//       expect('321.6.9'.versionNum, 321006009);
//     });
//   });
// }

// import 'package:krex/core/collection_ext.dart';
// void main() {
//   group('MapExtTests', () {
//     test('map.setValue', () {
//       final map = {'a': 1, 'b': 2};
// 
//       map.setValue('c', 3);
//       expect(map, {'a': 1, 'b': 2, 'c': 3});
// 
//       map.setValue('c', null);
//       expect(map, {'a': 1, 'b': 2});
//     });
// 
//     test('map.where', () {
//       final map = {'a': 1, 'b': null, 'c': 3, 'd': null};
//       final map1 = map.where((k, v) => v is int);
//       expect(map1, {'a': 1, 'c': 3});
//       expect(map1, isA<Map<String, int?>>());
//       // expect(map1, isA<Map<String, int>>());
//     });
// 
//     test('map.whereType', () {
//       final map = {'a': 1, 'b': 'xxx', 'c': 3, 'd': 'yyy'};
//       final map1 = map.whereType<int>();
//       expect(map1, {'a': 1, 'c': 3});
//       expect(map1, isA<Map<String, int>>());
//     });
// 
//     test('map.compactMap', () {
//       final map = {'a': 1, 'b': 2, 'c': 3, 'd': 4};
//       final map1 = map.compactMap((k, v) => v.isOdd ? v * v : null);
//       expect(map1, {'a': 1, 'c': 9});
//       expect(map1, isA<Map<String, int>>());
//     });
//   });
// 
//   group('IterableExtTests', () {
//     test('iterable.compactMap', () {
//       final list1 = [1, 2, 3, 4];
//       final list11 = list1.compactMap((e) => e.isEven ? '$e$e' : null).toList();
//       expect(list11, ['22', '44']);
//       expect(list11, isA<List<String>>());
// 
//       final list2 = [1, 2, 3, null, 4];
//       final list21 = list2.compactMap((e) => e != null && e.isEven ? '$e$e' : null).toList();
//       expect(list21, ['22', '44']);
//       expect(list21, isA<List<String>>());
// 
//       final list22 = list2.compactMap((e) => e).toList();
//       expect(list22, [1, 2, 3, 4]);
//       expect(list22, isA<List<int>>());
//     });
//   });
// }
