import 'package:flutter/material.dart';

// Listener 是底层类，有 down/move/cancel/up 之类的事件
// RawGestureDetector 是底层类，用于创建自定义手势识别器
// 平时，一般用 GestureDetector，它的尺寸：有子随子 无子随父
// GestureDetector 内部使用一个或多个 GestureRecognizer 来识别各种手势
// GestureRecognizer 使用 Listener 将原始指针事件转换为语义手势，它是抽象类，不同手势对应不同的子类。一定要 dispose()

// ================================================================================

// GestureDetector
// 同时处理 onTap 和 onDoubleTap 时，如果只点一下，onTap 会有 200ms 的延迟
// 因为系统不确定这是单击还是双击，此时用户可能会再点一下变成双击，但 200ms 以后没有再点就能确定是单击了
// 如果只处理 onTap 则不会有延迟

class GesturePage extends StatefulWidget {
  const GesturePage({super.key});

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  var info = '--';
  var posx = 10.0;
  var posy = 10.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gesture')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),

      // 例子一，因为 onDoubleTap 导致 onTap 延迟
      // body: GestureDetector(
      //   onTap: () => setState(() => info = 'tap'),
      //   onDoubleTap: () => setState(() => info = 'double'),
      //   child: Container(color: Colors.red, width: 200, height: 200, child: Text(info)),
      // ),

      // 例子二，实现拖动某控件的操作，没写完，以后再来
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            color: Colors.teal,
            width: 400,
            height: 400,
            child: Stack(
              children: [
                Positioned(
                  left: posx,
                  top: posy,
                  child: GestureDetector(
                    child: CircleAvatar(child: Text('K')),
                    onPanDown: (details) {
                      print('down ${details.localPosition}');
                      final RenderBox renderBox = context.findRenderObject() as RenderBox;
                      final pos = renderBox.localToGlobal(details.localPosition);
                      print(pos);
                      setState(() {
                        posx = details.localPosition.dx - 20;
                        posy = details.localPosition.dy - 20;
                      });
                    },
                    onPanUpdate: (details) {
                      print('update ${details.localPosition}');
                      setState(() {
                        posx = details.localPosition.dx - 20;
                        posy = details.localPosition.dy - 20;
                      });
                    },
                    onPanEnd: (details) {
                      print('end ${details.localPosition}');
                      // setState(() {
                      //   posx = 0;
                      //   posy = 0;
                      // });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
