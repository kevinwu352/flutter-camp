import 'package:flutter/material.dart';

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
      //   child: Listener(
      //     child: Container(color: Colors.red, width: 200, height: 200),
      //     onPointerDown: (event) => print("in"),
      //   ),
      //   onPointerDown: (event) => print("out"),
      // ),

      // 例子二，在两个 Listener 中间添加不同的 Pointer
      // IgnorePointer，一定要注意包含它的上级上上级不回调但同级会回调
      // AbsorbPointer，一定要注意回调的位置
      // body: Listener(
      //   child: Listener(
      //     // IgnorePointer 忽略事件，自己内部不回调，包含它的上级上上级也不回调。但下面的例子背后的同级会回调
      //     // AbsorbPointer 接收事件，但千万注意接收事件的是外层及以后的 Listener，而不是内部。相当于它收到事件后，吞掉，不给 child，而是给上
      //     child: IgnorePointer(
      //       child: Listener(
      //         child: Container(color: Colors.red, width: 200.0, height: 200.0),
      //         onPointerDown: (event) => print("in"),
      //       ),
      //     ),
      //     onPointerDown: (event) => print("out"),
      //   ),
      //   onPointerDown: (event) => print('top'),
      // ),

      // 例子三，看看背后的同级能不能收到事件
      body: Listener(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: Stack(
            children: [
              Listener(
                onPointerDown: (event) => print("red down"),
                child: Container(color: Colors.red),
              ),
              Listener(
                onPointerDown: (event) => print("green down"),
                // IgnorePointer 忽略事件，事件被传递到背后的视图了，简单来说，点击事件系统不处理它，相当于没这视图
                // child: IgnorePointer(child: Container(color: Colors.green, width: 100, height: 100)),
                // AbsorbPointer 接收事件，并且自己把事件吃掉了，背后的同级收不到事件
                child: AbsorbPointer(child: Container(color: Colors.green, width: 100, height: 100)),
              ),
            ],
          ),
        ),
        onPointerDown: (event) => print('out'),
      ),
    );
  }
}
