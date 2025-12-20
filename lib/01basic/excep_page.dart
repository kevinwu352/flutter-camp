import 'dart:async';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ================================================================================

// 异常分类
// Native 异常，Android/iOS 原生平台产生的异常，按照平台原生的方式捕捉并处理
// Dart 异常，一个非常重要的概念 Zone
//   Zone 是一个代码执行环境，它确保异步调用安全稳定
//   它类似于沙箱，不同的沙箱之间相互隔离，沙箱可以捕获/拦截/修改一些代码行为，比如，捕获日志输出/Timer创建/微任务调度/捕获未处理的异常
//   所有代码都运行在 Zone 里，通过 Zone.current 能获取当前的 Zone，main() 运行在默认的 Zone.root 里
//   代码可以通过 runZone/runZoneGuarded 运行到不同的 Zone
//   runZoneGuarded(onError:) 回调函数，捕捉那些在代码执行中未捕获的异常，能捕捉同步和异步异常
// Framework 异常，框架自己已经捕捉处理了，控制台看到的 Exception caught by xxx 红色文字，就是框架捕捉异常后打印的日志
// Widget.build 异常，也属于框架异常，发生在 build 阶段，框架用 try-catch 处理的时候返回 ErrorWidget，也就是红屏
//
// 直接 runApp 时（不用 Zone 包起来），按钮点击产生同步异步异常，控制台打印了异常，点按钮还会有响应，为何？
// 答：因为框架捕捉了异常，并且向控制台输出日志，Exception caught by xxx，所以不会 crash
// 不过，还是有个疑问，同步异常是被捕捉了，且打印了红色的日志，但是，异步异常打印的不是红色日志，它是由谁捕捉的？
// [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: NoSuchMethodError: Class 'int' has no instance getter 'length'.

// runZone 不能捕捉同步异步异常，它也没有 onError 回调
//   它的内部实现比较简单
//   Zone.current
//     .fork(specification: specification, zoneValues: zoneValues)
//     .run<R>(body);
//   当前 zone 的行为改不了，通常是 fork 一个新的出来，fork 的时候传一些 specification 定制新 zone 的行为
//   然后在新 zone 上运行代码
//
// runZoneGuarded 内部用 try-catch 包裹 _runZone 来捕捉同步异常，异步异常如何捕捉我不知道？
//   onError 回调能捕捉 body 里的同步异常，但是后续点击按钮产生的同步异常捕捉不了（被框架捕捉并处理了，红色日志）
//   onError 回调能捕捉 body 里的异步异常，也能捕捉后续点击按钮产生的异步异常
//
// 它俩的区别：
//   前者主要用于提供新的运行环境，自己确保没有异常抛出
//   后者主要用于提供新的运行环境且处理未捕捉的异常，推荐用这种

// build 异常的处理流程，在 performRebuild 方法里
// 系统调用 build()，用 try-catch 包起来，正常则显示正常内容
// 出现异常则创建一个 FlutterErrorDetails，一方面用 ErrorWidget 显示，一方面打印到控制台
//   截取 ErrorWidget 显示：ErrorWidget.builder 是静态方法，把它取出来，给空赋个新的回调，里面返回一个好看的 widget
//   截取控制台打印操作：FlutterError.onError 是静态方法，把它取出来，给它赋个新的回调，里面调用旧的

// vscode 调试的断点那里，如果勾选 Uncaught Exceptions，那么能捕捉 build 方法内抛出的异常
// 包括：直接从 build 方法内抛出的，或某个 Builder 组件的 builder 函数体内抛出的
// 如果捕捉到了，就断点停在那里。如果不勾选，那么就会直接显示红色的 ErrorWidget
// 但是，这个断点这里无法捕捉到 Row.overflow 异常

// void main() {
//   runApp(const MyApp());
//   // runZoned(() {
//   //   // expSync();
//   //   // expAsync();
//   //   runApp(const MyApp());
//   // });
//   // runZonedGuarded(
//   //   () {
//   //     // expSync();
//   //     // expAsync();
//   //     runApp(const MyApp());
//   //   },
//   //   (error, stack) {
//   //     print('got: $error');
//   //   },
//   // );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: ExcepPage());
//   }
// }

void hookErrorWidgetBuilder(params) {
  // final oldBuilder = ErrorWidget.builder;
  ErrorWidget.builder = (details) {
    // if (kDebugMode) {
    //   return oldBuilder(details);
    // } else {
    //   return Text('error occurred: $details');
    // }
    return Text('error occurred: $details', style: TextStyle(fontSize: 8));
  };
}

void hookFlutterErrorOnError(params) {
  final oldOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    print('i got it');
    oldOnError?.call(details);
  };
}

void expSync() {
  dynamic c = 10;
  print("10.length: ${c.length}");
  // try {
  //   print("10.length: ${c.length}");
  // } catch (e) {
  //   print('exp-sync, 10.length: $e');
  // }
}

void expAsync() {
  dynamic c = 20;
  Future.value(1).then((value) {
    print("20.length: ${c.length}");
  });
  // Future.value(1)
  //     .then((value) {
  //       print("20.length: ${c.length}");
  //     })
  //     .catchError((e) {
  //       print('exp-async, 20.length: $e');
  //     });
}

void expCantHandle() async {
  // 异步异常本来无法被捕捉，加上 await 后可被捕捉
  try {
    print('begin');
    dynamic c = 30;
    await Future.value(1).then((value) {
      print("30.length: ${c.length}");
    });
    print('end');
  } catch (e) {
    print('exp-cant, 30.length: $e');
  }
}

class ExcepPage extends StatefulWidget {
  const ExcepPage({super.key});
  @override
  State<ExcepPage> createState() => _ExcepPageState();
}

class _ExcepPageState extends State<ExcepPage> {
  var throwInBuild = false;
  var throwInBuilder = false;
  var throwOverflow = false;
  @override
  Widget build(BuildContext context) {
    if (throwInBuild) throw Exception('oh no, in build');
    return Scaffold(
      appBar: AppBar(title: Text('Excep')),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(onPressed: () => setState(() => throwInBuild = true), child: Text('throw in build')),
            TextButton(onPressed: () => setState(() => throwInBuilder = true), child: Text('throw in builder')),
            TextButton(onPressed: () => setState(() => throwOverflow = true), child: Text('throw overflow')),
            TextButton(onPressed: () => expSync(), child: Text('exp sync')),
            TextButton(onPressed: () => expAsync(), child: Text('exp async')),

            Row(
              children: [
                Text('aaaabbbbccccddddeeee', style: TextStyle(fontSize: 32)),
                if (throwOverflow) Text('ffff', style: TextStyle(fontSize: 32)),
              ],
            ),

            Builder(
              builder: (BuildContext context) {
                if (throwInBuilder) throw Exception('oh no, in builder');
                return Text('asdf');
              },
            ),
          ],
        ),
      ),
    );
  }
}
