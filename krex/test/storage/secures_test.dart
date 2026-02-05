import 'package:flutter_test/flutter_test.dart';

import 'package:krex/storage/secures.dart';

void main() {
  group('SecuresTests', () {
    test('version number', () {
      expect('3.6.9'.versionNum, 3006009);
      expect('3.6.98'.versionNum, 3006098);
      expect('3.6.987'.versionNum, 3006987);

      expect('3.6.9'.versionNum, 3006009);
      expect('3.65.9'.versionNum, 3065009);
      expect('3.654.9'.versionNum, 3654009);

      expect('3.6.9'.versionNum, 3006009);
      expect('32.6.9'.versionNum, 32006009);
      expect('321.6.9'.versionNum, 321006009);
    });
  });
}
