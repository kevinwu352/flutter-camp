// REVIEW

// xcrun simctl list
// open -a Simulator --args -CurrentDeviceUDID B064EFFA-5833-423F-8DB0-E1083EA4B76C

// dart pub get
// dart pub upgrade [transmogrify]
// dart pub outdated // 列出过时的包
// dart create -t package <PACKAGE_NAME>

// ================================================================================

// 系统定义的回调 ValueChanged 类型
// final ValueChanged<bool> onChanged;

// 带默认实现的接口，实现它的类只需要实现一个方法即可
// abstract interface class Comparable<T> {
//   int compareTo(T other);
//   static int compare(Comparable a, Comparable b) => a.compareTo(b);
// }

// 只在 debug 版打印日志的技巧
// assert(() {
//   print('${tag ?? key ?? child}: $constraints');
//   return true;
// }());

// 加载 bundle 的文件。DefaultAssetBundle 能修改它子节点的默认 bundle
//   推荐用这种方式，单元测试的时候能替换
//     final str = await DefaultAssetBundle.of(context).loadString("assets/jsons/user.json");
//   如果在 widget 外面，没有 context，用下面这种方式
//     import 'package:flutter/services.dart' show rootBundle;
//     final str = await rootBundle.loadString("assets/jsons/user.json");

// 针对不同平台调用不同函数
// import 'dart:io' show Platform;
// if (Platform.isIOS) {
//   doSomethingforIOS();
// }
// if (Platform.isAndroid) {
//   doSomethingforAndroid();
// }

// 在页面渲染完成后，获取某个控件的尺寸
// 注册的回调只会执行一次，以后用 setState 刷新页面并产生新帧，不会再次调用这个回调
// WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   getMetrics();
// });
// getMetrics() {
//   RenderBox logoBox = textKey.currentContext!.findRenderObject() as RenderBox;
//   size = logoBox.size;
//   offset = logoBox.localToGlobal(Offset.zero);
//   setState(() {});
// }

// ================================================================================

// typedef IntList = List<int>;
//
// typedef ListMapper<X> = Map<X, List<X>>;
// Map<String, List<String>> m1 = {}; // bad
// ListMapper<String> m2 = {};
//
// typedef Compare<T> = int Function(T a, T b);
// int sort(int a, int b) => a - b;
// assert(sort is Compare<int>);

// ================================================================================

// Swift 给可选添加扩展
//   extension Optional where Wrapped == Bool {
//       func orFalse() -> Bool {
//           return self ?? false
//       }
//   }
//   let x: Bool? = nil
//   print(x.orFalse())
//
// Dart 给可选添加扩展
//   extension UnwrapOrFalse on bool? {
//       bool orFalse() {
//           return this ?? false;
//       }
//   }
//   bool? x;
//   print(x.orFalse());

// ================================================================================

// class Obj {
//   Obj({required this.name, required this.age});
//   final String name;
//   final int age;
//     @override
//     bool operator ==(Object other) =>
//         identical(this, other) || other is Res && runtimeType == other.runtimeType && value == other.value;
//     @override
//     int get hashCode => value.hashCode;
//     int get hashCode => Object.hash(name, age); 多个值时，合并生成 hash
// }
// 这个普通类，新建实例时虽然参数相同，但是是不同的对象。所以，从数组里删的时候，删不掉
// final list = [Obj(name: 'kim', age: 18), Obj(name: 'bob', age: 20)];
// final obj = Obj(name: 'kim', age: 18);
// list.remove(obj);
// print(list); // 还是 2 个
// 结论：从数组中删除是用 == 来判断的，默认的 == 是 identical 逻辑
// 如果两个对象 == 为假，但 hashCode 相等，也删不了
//
// 1)把构造器定义为 const 的，且 list = [const Obj( 和 obj = const Obj(，会删成功，数组里面和 obj 都必须是 const
// 2)添加自定义的 == 实现，判断 name/age 的值，也能删成功
//
// bool/int/double/string 值相同时，是 identical 的，字面量和变量都是，不用加 const
// list/map/set 文字量并非 identical，除非用 const 创建
//   identical([1], [1])              false
//   identical(const [1], const [1])  true
//   list a1 = [1,2,3];
//   list a2 = [1,2,3]; 用文字量创建的两个变量也不是 identical

// ================================================================================

// Theme.of(context) 这种方法怎么实现？抽象类的静态方法里返回不同的子类实例
// abstract class ThemeManager {
//   static ThemeManager of(BuildContext context) {
//     final brightness = Theme.of(context).brightness;
//     return brightness == Brightness.light ? LightModeTheme() : DarkModeTheme();
//   }
//   Color get primary1;
// }
// class LightModeTheme extends ThemeManager {
//   @override
//   Color primary1 = AppColors.primary1;
// }
// class DarkModeTheme extends ThemeManager {
//   @override
//   Color primary1 = AppColors.secondary1;
// }
