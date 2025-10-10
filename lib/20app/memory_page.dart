// import 'dart:async';
import 'package:flutter/material.dart';

class Child {
  Child() {
    print('init child');
  }
}

class Parent {
  Parent() {
    print('init parent');
  }
  Child? child;
}

Parent parent1 = Parent();

final List<Function> globalClosures = [];

// ================================================================================

class MemoryPage extends StatefulWidget {
  const MemoryPage({super.key});

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // parent1.child = Child();

    // ================================================================================

    // 这里 Timer 未引用 this，所以页面释放不受其影响，页面退出后 Timer 会触发，相当于它俩互不相关
    // Timer(Duration(seconds: 20), () {
    //   print('time is up');
    // });

    // 这里 Timer 引用了 this，页面退出后不会被释放，等 Timer 触发后才能释放
    // Timer(Duration(seconds: 20), () {
    //   print('time is up, $this');
    // });

    // 从现象猜测：
    // 引用成员变量，退出页面后，页面和状态都无法被释放
    // Timer(Duration(seconds: 30), () {
    //   print('time is up, $cld');
    // });

    // 这也会导致页面和状态无法释放，它会抛出异常
    // 难道有文档说，在异步操作完成后，要检查 mounted
    // This widget has been unmounted, so the State no longer has a context (and should be considered defunct).
    // Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.
    // Timer(Duration(seconds: 20), () {
    //   if (mounted) {
    //     print('time is up, $context');
    //   } else {
    //     print('time is up, unmounted');
    //   }
    // });

    // ================================================================================

    // 加到全局数组里面，页面和状态也释放不了，在 dispose() 里面移除一下才行
    // 那个猜测像是真的，只访问 _counter，不要打印那行，也会导致释放不了
    // void test() {
    //   _counter++;
    //   // print(context.widget);
    // }
    // globalClosures.add(test);

    // ================================================================================

    // ac = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    // ac.addListener(() {
    //   print('hehe');
    // });
    // ac.repeat();
  }

  @override
  void dispose() {
    // parent1.child = null;
    super.dispose();
    // globalClosures.removeAt(0);
  }

  var cld = Child();

  // late AnimationController ac;

  // int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Memory')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Text('data'),
    );
  }
}
