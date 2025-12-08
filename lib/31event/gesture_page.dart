import 'package:flutter/material.dart';

// REVIEW

// Listener 是底层类，有 down/move/cancel/up 之类的事件
//
// GestureRecognizer 将原始指针事件转换为语义手势，它是抽象类，有一堆不同手势的子类
//
// 一般用 GestureDetector 就行了，它的尺寸：有子随子 无子随父
// GestureDetector 内部使用一个或多个 GestureRecognizer 来识别各种手势
//   如果传了 onTap 之类的参数，build 方法内部就创建 TapGestureRecognizer
//   如果传了 onLongPress 之类的参数，build 方法内部就创建 LongPressGestureRecognizer
//   这些创建好的 GestureRecognizer 传递给 RawGestureDetector
//
// RawGestureDetector 内部使用 Listener，这是底层类，不太懂

// ================================================================================

// 手势的识别和处理都是在事件分发阶段，而不是命中测试阶段，它有一套单独的处理手势冲突的机制
// 我的理解：
//   点击事件是独立的，按下/移动/抬起，按下事件发生时能按照规则找出一堆响应者，后续事件发生时也不会因为什么原因导致响应者增加或减少
//   而手势不同，按下事件发生时，鬼知道这是一个 tap/long-press/pan 手势？都需要后续事件来补充，才能决定到底是哪个手势，所以不能在按下事件发生时确定响应者

// 1) 每个手势识别器都是一个竞争者，当发生指针事件时，他们要在竞技场去竞争本次事件的处理权，默认情况最终只有一个会胜出
// 2) 竞争者的 handleEvent 会识别手势，然后可以宣布自己胜出，如果有竞争者胜出，管理者就通知其它的竞争者失败
// 3) 胜出者的 acceptGesture 会被调用，其余的 rejectGesture 将会被调用

// ================================================================================

// 手势冲突
// 手势是对原始指针事件的语义化识别，也就是原始事件经过组装成为某种手势。冲突是手势之间的，原始事件和手势没冲突

// 解决办法：
// 1) 用 Listener，这算是跳出三界外了，Listener 不是手势，自然也就不会和其它手势冲突了
// 2) 自定义 Recognizer，手势竞争胜利或失败时分别调用 acceptGesture/rejectGesture，那么，如果在失败的方法内部调用 acceptGesture 就能强行让自己变成胜利者
// 由此看出，胜利者可以有多个

class GesturePage extends StatefulWidget {
  const GesturePage({super.key});

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  var info = '--';
  var _left = 0.0;
  // var _top = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gesture')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),

      // 例子一，因为 onDoubleTap 导致 onTap 延迟
      // 同时处理 onTap 和 onDoubleTap 时，如果只点一下，onTap 会有 200ms 的延迟
      // 因为系统不确定这是单击还是双击，此时用户可能会再点一下变成双击，但 200ms 以后没有再点就能确定是单击了
      // 如果只处理 onTap 则不会有延迟
      // body: GestureDetector(
      //   onTap: () => setState(() => info = 'tap'),
      //   onDoubleTap: () => setState(() => info = 'double'),
      //   child: Container(color: Colors.red, width: 200, height: 200, child: Text(info)),
      // ),

      // 例子二，父子关系中的手势冲突
      // 两个手势只能有一个胜出者，很简单，点到谁身上谁就胜出
      // body: GestureDetector(
      //   onTapUp: (x) => print("2"),
      //   child: Container(
      //     width: 200,
      //     height: 200,
      //     color: Colors.red,
      //     alignment: Alignment.center,
      //     child: GestureDetector(
      //       onTapUp: (x) => print("1"),
      //       child: Container(width: 50, height: 50, color: Colors.grey),
      //     ),
      //   ),
      // ),
      // 如果把 GestureDetector 换成 Listener
      // 点灰色块时，灰色自己的手势响应了，父亲的 Listener 也响应了
      // body: Listener(
      //   onPointerUp: (event) => print('up'),
      //   child: Container(
      //     width: 200,
      //     height: 200,
      //     color: Colors.red,
      //     alignment: Alignment.center,
      //     child: GestureDetector(
      //       onTapUp: (x) => print("1"),
      //       child: Container(width: 50, height: 50, color: Colors.grey),
      //     ),
      //   ),
      // ),

      // 例子三，兄弟关系中的手势冲突
      // 水平和垂直两个手势竞争，只要哪个手势识别成功了，后面再朝另外一个方向移动也于事无补
      // body: Stack(
      //   children: [
      //     Positioned(
      //       top: _top,
      //       left: _left,
      //       child: GestureDetector(
      //         child: CircleAvatar(child: Text("A")),
      //         onVerticalDragUpdate: (DragUpdateDetails details) {
      //           setState(() {
      //             _top += details.delta.dy;
      //           });
      //         },
      //         onHorizontalDragUpdate: (DragUpdateDetails details) {
      //           setState(() {
      //             _left += details.delta.dx;
      //           });
      //         },
      //       ),
      //     ),
      //   ],
      // ),

      // 例子四，后续事件导致识别成另外的手势
      // 按下然后拖动时，down 发生了，然后是 drag-end，但并未发生 up，说明手势变了
      // 书上说，按下时 down 胜，拖动时 drag 胜，抬起时 drag-end 和 tap-up 冲突，但在拖动语义中，所以 drag-end 胜
      // 那么，可以得出结论，down/move/up 周期内胜者是可以变化的
      //
      // 另外，并不是按下就发生了 tap，而是要短时间 down up，才会发生 tap
      // down 以后，移动一点点，再 up，还是能被识别成 tap
      //
      // 这里的 down/up 没配对，如果严格依赖配对，请用 Listener
      body: Stack(
        children: [
          Positioned(
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) => print("drag-end"),
              onTapDown: (details) => print("down"),
              onTapUp: (details) => print("up"),
              onTap: () => print('tap'),
            ),
          ),
        ],
      ),

      // 例子，实现拖动某控件的操作，没写完，以后再来
      // body: Column(
      //   children: [
      //     SizedBox(height: 50),
      //     Container(
      //       color: Colors.teal,
      //       width: 400,
      //       height: 400,
      //       child: Stack(
      //         children: [
      //           Positioned(
      //             left: _left,
      //             top: _top,
      //             child: GestureDetector(
      //               child: CircleAvatar(child: Text('K')),
      //               onPanDown: (details) {
      //                 print('down ${details.localPosition}');
      //                 final RenderBox renderBox = context.findRenderObject() as RenderBox;
      //                 final pos = renderBox.localToGlobal(details.localPosition);
      //                 print(pos);
      //                 setState(() {
      //                   _left = details.localPosition.dx - 20;
      //                   _top = details.localPosition.dy - 20;
      //                 });
      //               },
      //               onPanUpdate: (details) {
      //                 print('update ${details.localPosition}');
      //                 setState(() {
      //                   _left = details.localPosition.dx - 20;
      //                   _top = details.localPosition.dy - 20;
      //                 });
      //               },
      //               onPanEnd: (details) {
      //                 print('end ${details.localPosition}');
      //                 // setState(() {
      //                 //   _left = 0;
      //                 //   _top = 0;
      //                 // });
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
