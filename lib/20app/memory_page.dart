// import 'dart:async';
import 'package:flutter/material.dart';

// 性能优化/内存优化
// 先说，性能优化的目标是解决卡顿，卡顿的原理？什么是 1/60 秒？
// 再说，性能优化的总体原则：空间换时间 时间换空间，在空间和时间之间达到一个平衡
//
//   减少布局重绘
//     使用 const 构造视图，final 变量也会有优化的
//     使用子 widget 而不是调用函数返回一个 widget
//     尽量使用 stateless 视图
//     使用 key，重排/添加/删除时，精确匹配自己对应的 Element，避免重绘，否则会使用位置来匹配
//     避免使用 MediaQuery.of(context).size，用 MediaQuery.sizeOf(context)
//   避免过多动画，要用就用内置的动画库，如 AnimationController/Tween，它们已经优化过
//     动画中的计算尽可能简单，避免在每一帧进行复杂操作
//   懒加载和按需加载，ListView.builder / late / 加载分页
//     固定行高时用 itemExtent / prototypeItem
//   给主线程减负，用 compute 放到其它线程去执行，或使用 isolate
//   使用 DevTools 查看性能和内存情况
//
//   压缩图片大小，按需加载，使用缓存技术，超大图片用 cacheWidth/cacheHeight 减少内存
//   及时释放资源，文件/数据库/网络
//   取消订阅监听器，视图 dispose 时，移除监听器 / dispose controller / cancel stream
// ??对于非必须强引用的对象，可以使用 WeakReference 来避免循环引用
//   关注永久存活的对象，单例/全局对象/静态变量，自己做好清理工作
//   使用合理的数据结构，使用合理的缓存
//
//   视图 dispose 里，某行抛异常，导致后续清理工作被跳过，要保证清理工作的健壮性。单独把抛异常那行用 try 包起来？
//   延时操作的闭包导致的释放延迟，要特别关注，如 Timer/Future.delayed
//   三方库质量评估，like 数/star 数/社区接受度，并自己做些性能测试和内存测试，即使是官方库也会有坑
//
//
// 内存管理是由 Dart 虚拟机负责的，虚拟机使用垃圾回收器来管理内存，这意味着开发者不需要手动分配和释放内存
// 垃圾回收触发条件：1)系统内存达到某个阈值；2)年轻代空间不足时；3)显式调用 GC() 方法（不常用）
//
// Dart 以 Isolate 划分独立的线程、堆和栈内存，不同 Isolate 是隔离的，并且是各自独立 GC 的。堆内存划分成新生代内存和老生代内存
//
// 新生代，内存空间较小，划分为等分的两部分，采用复制-清除法管理内存，效率高，执行频率比老生代高一些
// 经过一轮复制清除后，存活下来的对象会被转移到老生代空间 <= 有说一轮几轮的，到底几轮？
//
// 老生代，内存空间较大，内存管理要经历 标记-清除-整理 三个步骤。回收频率低，但每次回收花费时间较长
//
// 标记算法采用对象可达性算法，GC root 维护了一个根对象列表，从这些跟对象出发，遍历所有可达对象，标记活动对象
// 内存清理之后会出现零散的内存碎片，进行清除和整理的时，会使引擎所有线程都停止处理 - 'stop the world'。整理就是把有用的内存往前移，消除碎片，对象的地址会变，所以还要更新地址
// 从标记到清除和整理，GC 是一个耗时的执行过程，引擎自身做了一些优化，开发者无法操纵这些过程

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

    // ================================================================================

    // 从现象得出：
    // state 保留 MyManager 实例，mm 的参数闭包使用了 state，且 mm 保留了闭包
    // 这本是个循环引用，却没出现释放不掉的情况
    mm = MyManager(() {
      print('in action, $this');
      return 101;
    });
  }

  @override
  void dispose() {
    // parent1.child = null;
    super.dispose();
    // globalClosures.removeAt(0);
  }

  // var cld = Child();

  // late AnimationController ac;

  // int _counter = 0;

  late MyManager mm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Memory')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Text('data'),
    );
  }
}

class MyManager {
  MyManager(int Function() action) {
    final val = action();
    print('val: $val');
    act = action;
    // ----------
    // Timer(Duration(seconds: 20), () {
    //   act?.call();
    // });
  }
  int Function()? act;
}
