import 'package:flutter/foundation.dart';
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

// ValueNotifier 用法。能用 ListenableBuilder / ValueListenableBuilder
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

class ListenPage extends StatelessWidget {
  const ListenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
