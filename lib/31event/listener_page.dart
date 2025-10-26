import 'package:flutter/material.dart';

// 它俩都是吞掉子的事件
//
// AbsorbPointer 书上说它的 hitTestSelf 返回 true
//   prevents its children from receiving pointer events but is itself visible to hit testing
// IgnorePointer 书上说它的 hitTestSelf 返回 false
//   prevents its children from receiving pointer events but is itself invisible to hit testing

class ListenerPage extends StatelessWidget {
  const ListenerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listener')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),

      // 例子一，连续嵌套两个 Listener，内外都能收到点击事件
      // body: Listener(
      //   onPointerDown: (event) => print("out"),
      //   child: Listener(
      //     onPointerDown: (event) => print("in"),
      //     child: Container(color: Colors.red, width: 200, height: 200),
      //   ),
      // ),

      // 例子二，在多个 Listener 中间添加不同的 Pointer，看看事件如何传递
      // AbsorbPointer => out top most
      // IgnorePointer =>
      // 因为 Listener 用的是 deferToChild，所以外层多个 Listener 的行为完全由内部的 Pointer 决定，是个完整的链
      // body: Listener(
      //   onPointerDown: (event) => print('most'),
      //   child: Listener(
      //     // 当下面是 IgnorePointer 时，本来整条链都不会响应事件
      //     // 如果这里 behavior 设置成 opaque，输出 top most
      //     // 如果这里 behavior 设置成 translucent，输出 top
      //     behavior: HitTestBehavior.translucent,
      //     onPointerDown: (event) => print('top'),
      //     child: Listener(
      //       onPointerDown: (event) => print("out"),
      //       // IgnorePointer 忽略事件，它的子肯定收不到事件，它外面包的三层也收不到事件
      //       //   外面三层收不到是因为，Listener 用的是 deferToChild，完全由子决定
      //       // AbsorbPointer 接收事件，它的子肯定收不到事件，它外面包的三层能收到事件
      //       child: IgnorePointer(
      //         child: Listener(
      //           // child: Container(color: Colors.red, width: 200.0, height: 200.0),
      //           child: IconButton(onPressed: () => print('in'), icon: Icon(Icons.run_circle)),
      //           onPointerDown: (event) => print("in"),
      //         ),
      //       ),
      //       // ----------
      //     ),
      //   ),
      // ),

      // 例子三，在多个 Listener 中间添加 widget/Pointer
      // AbsorbPointer => out top
      // IgnorePointer => top
      //   例子二，多个 Listener 是连续的，完全由子决定，也就是完全由内层的 Pointer 决定
      //   但这里插入了 Container，Container 不是由子决定的，所以，断了由子决定这条链，只有 out 这个 Listener 由 Pointer 决定
      // body: Listener(
      //   // 由子决定，它的子是 Container
      //   onPointerDown: (event) => print('top'),
      //   child: Container(
      //     width: 400,
      //     height: 400,
      //     color: Colors.teal,
      //     child: Listener(
      //       // 由子决定，它的子是 Pointer
      //       onPointerDown: (event) => print("out"),
      //       // ----------
      //       child: IgnorePointer(
      //         child: Listener(
      //           child: Container(color: Colors.red, width: 200.0, height: 200.0),
      //           onPointerDown: (event) => print("in"),
      //         ),
      //       ),
      //       // ----------
      //     ),
      //   ),
      // ),

      // 例子四，同级有重叠时事件的传递
      // body: Listener(
      //   onPointerDown: (event) => print('out'),
      //   child: Container(
      //     width: 400,
      //     height: 400,
      //     color: Colors.blue,
      //     child: Stack(
      //       children: [
      //         Listener(
      //           onPointerDown: (event) => print("red down"),
      //           child: Container(color: Colors.red),
      //         ),
      //         Listener(
      //           onPointerDown: (event) => print("green down"),
      //           // IgnorePointer 它的子肯定收不到事件。它自己和它的子不响应事件，虽然点击到它身上，但就像它不存在一起，事件是它背后的红色同级处理的
      //           child: IgnorePointer(child: Container(color: Colors.green, width: 200, height: 200)),
      //           // AbsorbPointer，它的子肯定收不到事件。它就是一个正常的控件，只是子收不到事件。又因为它在前面，所以，它背后的红色同级收不到事件
      //           // child: AbsorbPointer(child: Container(color: Colors.green, width: 200, height: 200)),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      // 例子五：测试 HitTestBehavior 在父子关系中的效果
      // deferToChild
      //   AbsorbPointer => out top most
      //   IgnorePointer =>
      // opaque 自己肯定要响应事件，并且 hitTest 也返回 true，所以，当前控件像是不透明的一样，也就是这个 Listener 不管子如何如何
      //   AbsorbPointer => out top most
      //   IgnorePointer => out top most
      // translucent 自己肯定要响应事件，但 hitTest 返回的是子的，外面的 Listener 又是 deferToChild，所以，当前控件像是透明的一样，把子的透传出去
      //   AbsorbPointer => out top most
      //   IgnorePointer => out
      // body: Listener(
      //   onPointerDown: (event) => print('most'),
      //   child: Listener(
      //     onPointerDown: (event) => print('top'),
      //     child: Listener(
      //       behavior: HitTestBehavior.translucent,
      //       onPointerDown: (event) => print('out'),
      //       // child: Container(width: 400, height: 400, color: Colors.teal),
      //       child: AbsorbPointer(child: Container(width: 400, height: 400, color: Colors.teal)),
      //       // child: IgnorePointer(child: Container(width: 400, height: 400, color: Colors.teal)),
      //     ),
      //   ),
      // ),

      // 例子六：测试 HitTestBehavior 在兄弟关系中的效果。点绿色块，看事件要不要传给背后同级的大红色块
      // deferToChild
      //   AbsorbPointer => green out
      //   IgnorePointer => red out
      // opaque 自己肯定要响应事件，但我是不透明的，我不管我的子怎么样，反正就是点我身上了，导致命中测试中断，我背后的红色块就轮不到了
      //   AbsorbPointer => green out
      //   IgnorePointer => green out
      // translucent 自己肯定要响应事件，但我是透明的，我根据我的子来决定
      //   子如果要响应事件，我的 hitTest 就返回 true，导致命中测试中断，红色块就收不到事件
      //   子如果不响应事件，我的 hitTest 就返回 fals, 命中测试继续测试下一个背后的兄弟，然后，红色块就收到事件了
      //   AbsorbPointer => green out
      //   IgnorePointer => green red out
      body: Listener(
        onPointerDown: (event) => print('out'),
        child: Container(
          width: 400,
          height: 400,
          color: Colors.blue,
          child: Stack(
            children: [
              Listener(
                onPointerDown: (event) => print("red down"),
                child: Container(color: Colors.red),
              ),
              Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (event) => print("green down"),
                // child: IgnorePointer(child: Container(color: Colors.green, width: 200, height: 200)),
                child: AbsorbPointer(child: Container(color: Colors.green, width: 200, height: 200)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
