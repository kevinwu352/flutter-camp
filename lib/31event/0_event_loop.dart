import 'dart:async';
import 'dart:isolate';

// REVIEW

// Dart 在单线程中是以消息循环机制来运行的，包含两个任务队列 微任务队列 事件队列
// main() 执行完后，消息循环机制便启动了
//
// 事件队列，处理I/O事件、绘制事件、手势事件、接收其他 isolate 消息等外部事件，还有 timer
// Future(() => print('This is a new Future'));
// Future 内部有些是用 Timer 实现的，比如 .delayed，有些不是，比如 .microtask
//
// 微任务则通常来源于Dart内部，并且非常少，因为优先级高，太多的话会卡UI，所以微任务必须得少
// 微任务优先级高，每个事件处理完都会检查是否有微任务，有就执行所有的微任务，再执行下一个事件
// 微任务适合 需要尽快完成 但不是马上 的任务
// 微任务要尽量快，否则会长时间阻塞主线程

// async、await 本质是 Dart 对异步操作的一个语法糖，可以减少异步调用的嵌套调用

// 每个 isolate 包含一个事件循环以及两个事件队列，事件队列和微任务队列
// 代码默认运行在 主Isolate 中
// 和 Thread 不同的是，isolate 拥有独立内存，isolate 由线程和独立内存构成
// 正是由于 isolate 之间的内存不共享，所以 isolate 之间并不存在资源抢夺的问题，所以也不需要锁
// isolate 之间的通信 >只能< 通过 port 来进行，文档说，ReceivePort 可以有很多 SendPort
//
// spawnUri 接受一个文件作为参数，那文件里要有 main 函数

// Flutter Engine 自己不创建和管理线程，Flutter Engine 线程的创建和管理是 Embeder 负责的
// Embeder 提供四个 Task Runner，分别是 Platform Task Runner、UI Task Runner Thread、IO Task Runner、GPU Task Runner

// compute() 很简单，它是由 Flutter 提供的，并不在 dart 库中，内部还是用 isolate

// flutter: begin
// flutter: end
// flutter: micro-1
// flutter: micro-2
// flutter: micro-3
// flutter: micro-4
// flutter: event-1
// flutter: event-2

void task_seq() {
  print('begin');
  ReceivePort receivePort = ReceivePort();
  receivePort.listen(print);

  Future.microtask(() => print("micro-1"));
  receivePort.sendPort.send("event-1");

  Future.microtask(() => print("micro-2"));
  receivePort.sendPort.send("event-2");

  Future.microtask(() => print("micro-3"));
  Future.microtask(() => print("micro-4"));
  print('end');

  scheduleMicrotask(() => print('micro'));
}

var globalValue = 200;

// ================================================================================

// 先创建一个 ReceivePort，它其实是一对 recv/send，把它的 sendPort 传递给 isolate
// isolate 内部产生一堆数据，用自己拿到的 sendPort 把数据传递出来
// 用 ReceivePort 接收数据，并进行累加
void isolate1() async {
  // ReceivePort 继承自 Stream<dynamic> 你可以通过它获取其他 isolate 发来的消息
  var rp = ReceivePort();

  var localValue = 100;

  // 这里 await spawn 并不会阻塞线程，相当于只是等 spawn 这个函数执行完成
  // 它参数里的函数体在另外的 isolate 里执行，且这里等的不是那个
  await Isolate.spawn((port) async {
    print('isolate begin');

    localValue = 110;
    globalValue = 210;

    await Future.delayed(Duration(seconds: 1));
    print('isolate send 10');
    // 向消息通道发送消息（因为 isolate 之间不会共享内存，所以这里的消息会先复制然后再发送副本，所以可能会比较慢）
    port.send(10);

    await Future.delayed(Duration(seconds: 1));
    print('isolate send 20');
    port.send(20);

    print('isolate end');
    print('local: inner $localValue');
    print('global: inner $globalValue');

    // 终止当前 isolate 并关闭指定的消息通道，并且在关闭消息通道之前发送指定的消息（这个最后的消息不会复制，而是直接发送，所以会很快）
    Isolate.exit(port, -1);
  }, rp.sendPort);

  var sum = 0;
  await for (var value in rp) {
    var v = value as int;
    print('recv: $v');
    // 通过约定的值 -1 来结束 await for
    if (v == -1) break;
    sum += v;
  }
  print('sum: $sum');

  // spawn 里面虽然能修改 local/global 的变量，但是并未真正改外面的
  // 在 spawn 里面打印 local/global 的值，是修改以后的
  // Isolate.run 里的效果也是一样的
  // 所以，isolate 内外访问 局部/全部 变量也是分开的，修改一边不影响另外一边
  print('local: $localValue');
  print('global: $globalValue');
}

// ================================================================================

// isolate 内外如何通信？
// 内外分别创建 ReceivePort，并把 ReceivePort.sendPort 传递给对面
// 相当于自己有条电话线，把自己的电话线另一头扔给对方，实现通信
void isolate2() async {
  var rp1 = ReceivePort();

  // 把这里提取到方法的原因是：怕闭包内部不小心使用了周围的 rp1/sp1
  // await Isolate.spawn((sp2) async {
  //   var rp2 = ReceivePort();
  //   sp2.send(rp2.sendPort);
  //   await for (var val in rp2) {
  //     var value = val as int;
  //     print('222 recv: $value');
  //     var vvv = value + 10;
  //     print('222 send: $vvv');
  //     sp2.send(vvv);
  //   }
  // }, rp1.sendPort);
  await Isolate.spawn(iso_body, rp1.sendPort);

  // 把这里提取到方法的原因是：await rp1.first 和下面的 await for 监听了两次，不支持
  // SendPort sp1 = await rp1.first;
  // Future.delayed(Duration(seconds: 2), () async {
  //   await Future.delayed(Duration(seconds: 1));
  //   print('111 send: 1');
  //   sp1.send(1);
  //   await Future.delayed(Duration(seconds: 1));
  //   print('111 send: 2');
  //   sp1.send(2);
  // });

  await for (var val in rp1) {
    if (val is int) {
      print('111 recv: $val');
    } else {
      iso_send(val);
    }
    // var value = val as int;
    // print('111 recv: $value');
  }
}

void iso_body(SendPort sp2) async {
  var rp2 = ReceivePort();
  sp2.send(rp2.sendPort);

  await for (var val in rp2) {
    var value = val as int;
    print('222 recv: $value');
    var vvv = value + 10;
    print('222 send: $vvv');
    sp2.send(vvv);
  }
}

void iso_send(SendPort sp1) async {
  await Future.delayed(Duration(seconds: 1));
  print('111 send: 1');
  sp1.send(1);
  await Future.delayed(Duration(seconds: 1));
  print('111 send: 2');
  sp1.send(2);
}

// ================================================================================

void isolate3() async {
  var rp = ReceivePort();
  // 这里无法捕捉 isolate 内部的异常
  // isolate 内部可以用 try-catch 捕捉到异常
  // try {
  //   await Isolate.spawn(iso_throw, rp.sendPort);
  // } catch (e) {
  //   print('out got excep: $e');
  // }

  // 创建个 ReceivePort，并把 sendport 传递给 onError，里面会传递未捕捉的异常出来
  // 如果里面捕捉了异常，外面就收不到了
  var ep = ReceivePort();
  await Isolate.spawn(iso_throw, rp.sendPort, onError: ep.sendPort);
  ep.listen((message) => print('OnError: $message'));

  var sum = 0;
  await for (var value in rp) {
    var v = value as int;
    print('recv: $v');
    if (v == -1) break;
    sum += v;
  }
  print('sum: $sum');
}

// 抛出的异常不会导致程序崩溃
void iso_throw(SendPort port) async {
  try {
    print('isolate begin');

    await Future.delayed(Duration(seconds: 1));
    print('isolate send 10');
    port.send(10);

    throw Exception('asdf');

    // await Future.delayed(Duration(seconds: 1));
    // print('isolate send 20');
    // port.send(20);
    // print('isolate end');
    // Isolate.exit(port, -1);
  } catch (e) {
    print('iso got excep: $e');
  }
}

// ================================================================================

// await Isolate.run 里面抛出的异常能被捕捉

void isolate4() async {
  var localValue = 100;

  try {
    await Isolate.run(() async {
      print('111');
      await Future.delayed(Duration(seconds: 1));
      localValue = 110;
      globalValue = 210;
      await Future.delayed(Duration(seconds: 1));
      print('local: inner $localValue');
      print('global: inner $globalValue');
      throw Exception('asdf');
      // print('222');
    });
  } catch (e) {
    print('got $e');
  }

  print('local: $localValue');
  print('global: $globalValue');
}

// ================================================================================

// 诚如 isolate1 所言，发送前会创建副本，所以，传递给 SendPort 的实例 和 外面的实例不是同一个，内外对实例的修改互不影响
// 而且是深拷贝，实例的属性如果是另外一个类实例，也会对属性进行复制。数组里的实例也会深拷贝

void isolate5() async {
  var rp = ReceivePort();

  // var list = [1, 2, 3];
  // print('111: $list, ${identityHashCode(list)}');
  var obj = Obj();
  var list = [1, 2, 3, obj];
  print('111: $list, ${identityHashCode(list)} ${identityHashCode(obj)}');
  // var obj = Obj();
  // print('111: $obj, ${identityHashCode(obj)}');
  // var sub = Sub();
  // print('111: $sub, ${identityHashCode(sub)} ${identityHashCode(sub.obj)}');

  await Isolate.spawn((port) async {
    print('isolate begin');

    var rp2 = ReceivePort();
    port.send(rp2.sendPort);
    var value = await rp2.first;

    var v = value as List;
    var o = v.last as Obj;
    v.add(4);
    o.age = 20;
    print('333: $v, ${identityHashCode(v)} ${identityHashCode(o)}');

    // var v = value as Sub;
    // v.height = 200;
    // v.obj.age = 20;
    // print('333: $v, ${identityHashCode(v)} ${identityHashCode(v.obj)}');
    // var v = value as List;
    // print('333: $v, ${identityHashCode(v)}');
    // v.add(4);
    // print('444: $v, ${identityHashCode(v)}');

    await Future.delayed(Duration(seconds: 1));
    print('isolate end');

    Isolate.exit(port, -1);
  }, rp.sendPort);

  await for (var value in rp) {
    if (value is SendPort) {
      print('send value');
      value.send(list);
    } else {
      var v = value as int;
      print('recv: $v');
      if (v == -1) break;
    }
  }

  // print('222: $list, ${identityHashCode(list)}');
  print('222: $list, ${identityHashCode(list)} ${identityHashCode(obj)}');
  // print('222: $obj, ${identityHashCode(obj)}');
  // print('222: $sub, ${identityHashCode(sub)} ${identityHashCode(sub.obj)}');
}

class Obj {
  int age = 10;
  @override
  String toString() => 'obj,age=$age';
}

class Sub {
  int height = 100;
  Obj obj = Obj();
  @override
  String toString() => 'obj,height=$height,age=${obj.age}';
}
