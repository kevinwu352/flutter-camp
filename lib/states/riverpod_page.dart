import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// runApp(const ProviderScope(child: MyApp()));

// 这是 StateProvider，据说官方在 2.0 增加了 NotifierProvider 并推荐使用
// final clickCountProvider = StateProvider((ref) => 0);

// 用这种
final clickCountProvider = NotifierProvider(() => ClickCount());

class ClickCount extends Notifier<int> {
  // 重写此方法返回 Notifier 的初始状态
  @override
  int build() => 0;
  void increase() {
    state++;
  }
}

// 但感觉 NotifierProvider 只能提供一个状态？还是用下面这个？但文档说这是过时的
final counterProvider = ChangeNotifierProvider((_) => Counter());

class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increase() {
    _count++;
    notifyListeners();
  }
}

class PodHomePage extends ConsumerWidget {
  const PodHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 读的时候 StateProvider 和 NotifierProvider 一样
    // final int count = ref.watch(clickCountProvider);
    // 用 ChangeNotifierProvider
    final count = ref.watch(counterProvider).count;
    return Column(
      children: [
        Text("---"),
        Text("value: $count"),
        ElevatedButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => PodCountPage()));
          },
          child: Text("go"),
        ),
      ],
    );
  }
}

class PodCountPage extends ConsumerWidget {
  const PodCountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final int count = ref.watch(clickCountProvider);
    return Column(
      children: [
        Text("---"),
        // Text("value: $count"),
        ElevatedButton(
          onPressed: () {
            // 修改的时候 StateProvider 和 NotifierProvider 不一样
            // ref.read(clickCountProvider.notifier).state++;
            // ref.read(clickCountProvider.notifier).increase();
            // 用 ChangeNotifierProvider
            ref.read(counterProvider).increase();
          },
          child: Text("increase"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("back"),
        ),
      ],
    );
  }
}
