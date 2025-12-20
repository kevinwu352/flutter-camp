import 'package:flutter/material.dart';

// Listenable

// mixin class ChangeNotifier implements Listenable
// abstract class ValueListenable<T> extends Listenable

// class ValueNotifier<T> extends ChangeNotifier implements ValueListenable<T>
// ValueNotifier<List<int>>，当 List 内容变化时，不会通知外面

// abstract class Animation<T> extends Listenable implements ValueListenable<T>

// ChangeNotifier => ListenableBuilder
//   class ListenableBuilder extends AnimatedWidget
// ValueNotifier => ValueListenableBuilder
//   class ValueListenableBuilder<T> extends StatefulWidget

// ================================================================================

// ChangeNotifier
// 调用 notifyListeners 会通知界面更新一次
// 给它的属性赋相同的值，或不赋值直接调用，界面都会刷新一次
// 连续修改多个属性，且每个属性都调用 notifyListeners，界面只会更新一次
//
// notifyListeners 说的是只能内部调用，但外部也能调，只是有警告
//
// 多个 ListenableBuilder 观察它的变化时，只要调用 notifyListeners，所有的 Builder 都会更新
// 不管这些 Builder 使用了哪些值

// ValueNotifier
// 能用 ListenableBuilder / ValueListenableBuilder
// 赋相同的值不会更新界面
// 比较值用的是 ==，自定义类最好实现 == 方法来判断相等性
//
// List<int> 内容变化不会更新界面

// Listenable.merge([hosts, nums]) 后，连续修改里面两个的值，界面只会更新一次

// ================================================================================

// ChangeNotifier 用法
// class CounterNotifier extends ChangeNotifier {
//   int _count = 0;
//   int get count => _count;
//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }
// Column(
//   children: [
//     ListenableBuilder(
//       listenable: counterNotifier,
//       builder: (context, child) {
//         return Text('counter: ${counterNotifier.count}');
//       },
//     ),
//     TextButton(
//       child: Text('Increment'),
//       onPressed: () {
//         counterNotifier.increment();
//       },
//     ),
//   ],
// )

// ValueNotifier 用法
// ValueNotifier<int> counterNotifier = ValueNotifier(0);
// Column(
//   children: [
//     ValueListenableBuilder(
//       valueListenable: counterNotifier,
//       builder: (context, value, child) {
//         return Text('counter: $value');
//       },
//     ),
//     TextButton(
//       child: Text('Increment'),
//       onPressed: () {
//         counterNotifier.value++;
//       },
//     ),
//   ],
// )

class ListenPage extends StatefulWidget {
  const ListenPage({super.key});

  @override
  State<ListenPage> createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  final vm = ListenVm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listen')),
      body: SizedBox.expand(
        // child: ListenableBuilder(
        //   listenable: vm,
        //   builder: (context, child) {
        //     print('rebuild');
        //     return Column(
        //       children: [
        //         Text('name: ${vm.name}'),
        //         Text('age: ${vm.age}'),
        //         TextButton(
        //           onPressed: () {
        //             vm.name = 'kevin';
        //             vm.age = 10;
        //           },
        //           child: Text('update'),
        //         ),
        //       ],
        //     );
        //   },
        // ),
        child: Column(
          children: [
            ListenableBuilder(
              listenable: vm,
              builder: (context, child) {
                print('rebuild1');
                return Text('value1: ${vm.name}');
                // return Column(children: [Text('name: ${vm.name}'), Text('age: ${vm.age}')]);
              },
            ),

            ListenableBuilder(
              listenable: vm,
              builder: (context, child) {
                print('rebuild2');
                return Text('value2: ${vm.age}');
                // return Column(children: [Text('name: ${vm.name}'), Text('age: ${vm.age}')]);
              },
            ),

            // ListenableBuilder(
            //   listenable: hosts,
            //   builder: (context, child) {
            //     print('rebuild3');
            //     return Text('value3: ${hosts.value.val}');
            //   },
            // ),

            // ValueListenableBuilder(
            //   valueListenable: hosts,
            //   builder: (context, value, child) {
            //     print('rebuild4');
            //     return Text('value4: $value');
            //   },
            // ),
            // ListenableBuilder(
            //   listenable: Listenable.merge([hosts, nums]),
            //   builder: (context, child) {
            //     print('rebuild5');
            //     return Text('value5: ${hosts.value.val} ${nums.value}');
            //   },
            // ),
            ListenableBuilder(
              listenable: nums,
              builder: (context, child) {
                print('rebuild6');
                return Text('value6: ${nums.value}');
              },
            ),

            TextButton(
              onPressed: () {
                // vm.name = 'kevin';
                // vm.age = 10;
                // vm.update();
                // hosts.value = Obj('hehess');
                // nums.value = [101, 1022];
                list.add(44123);
                // final obj1 = Obj('aa');
                // final obj2 = Obj('aa');
                // print(obj1 == obj2);
              },
              child: Text('update'),
            ),
          ],
        ),
      ),
    );
  }
}

class Obj {
  Obj(this.val);
  final String val;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Obj && runtimeType == other.runtimeType && val == other.val;
  @override
  int get hashCode => val.hashCode;
}

final hosts = ValueNotifier(Obj('hehe'));

final list = [10, 11];
final nums = ValueNotifier(list);

class ListenVm extends ChangeNotifier {
  var _name = '--';
  get name => _name;
  set name(value) {
    _name = value;
    notifyListeners();
  }

  var _age = 0;
  get age => _age;
  set age(value) {
    _age = value;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
