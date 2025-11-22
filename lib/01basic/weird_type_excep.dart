import 'dart:convert';

// 很诡异的类型异常

extension ObjectAsExt on Object? {
  T? ssOr<T>() {
    var self = this;
    return self is T ? self : null;
  }
}

extension MapExt<K, V> on Map<K, V> {
  int? getI(K key) => this[key].ssOr<int>();
}

void weirdTypeExcep() {
  final str = '{"a":1,"b":"2","c":[1,2,"a","b",3,4,"c","d"]}';
  final json = jsonDecode(str) as Map;
  // final json = (jsonDecode(str) as Map).map((key, value) => MapEntry(key, value as Object));
  print(json);

  final map = {
    "a": 1,
    "b": "2",
    "c": [1, 2, "a", "b", 3, 4, "c", "d"],
  };

  final aa = json.getI('a');
  print(aa);
  final bb = json['a'];
  print(bb);

  final cc = map['a'].ssOr<int>();
  print(cc);
  final ee = json['a'].isEven; // 这能成功，因为 isEven 是原生方法
  print(ee);
  final dd = json['a'].ssOr<int>(); // 这个失败，因为 asOr 是扩展方法，Extensions don't apply to dynamic types
  print(dd);

  int? xx = 1;
  final xxx = xx.ssOr<int>();
  print(xxx);

  int yy = 1;
  final yyy = yy.ssOr<int>();
  print(yyy);
}
