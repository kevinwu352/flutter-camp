import 'dart:async';
import 'dart:isolate';

// Dart 在单线程中是以消息循环机制来运行的，包含两个任务队列 微任务队列 事件队列
// main() 执行完后，消息循环机制便启动了
//
// 事件队列，mouse event/tap event/timer/IO operation
// Future(() => print('This is a new Future'));
//
// 微任务优先级高，每个事件处理完都会检查是否有微任务，有就执行所有的微任务，再执行下一个事件
// 微任务适合 需要尽快完成 但不是马上 的任务

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
