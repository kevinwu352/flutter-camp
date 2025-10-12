import 'package:flutter/material.dart';

// 好像是文档里面的一个例子，用 LayoutBuilder 拿到父传过来的约束，再用此约束的 maxHeight 来定义 SCSV 内容的 minHeight
// 这样如果三个元素的固有高度不够高，也能让内容盒子的高度和屏幕一样高
// 另外，如果 minHeight = constraints.maxHeight + 1，那么即使内容高度不够，也能让 SCSV 滚动

// 屏幕高的时候，把元素铺满整屏，元素之间是空白
// 屏幕矮的时候，把元素铺满整屏，元素挤在一起，能滚动
// 如果用到 Spacer/Expanded，要用 IntrinsicHeight 包起来

class ScrollPage extends StatelessWidget {
  const ScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = 280; // 200, 280
    return Scaffold(
      appBar: AppBar(title: Text("Scroll")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight, minWidth: double.infinity),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Colors.red, height: height, child: Text("11111")),
                  Container(color: Colors.green, height: height, child: Text("22222")),
                  Container(color: Colors.blue, height: height, child: Text("33333")),
                ],
              ),
              // child: IntrinsicHeight(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(color: Colors.red, height: height, child: Text("11111")),
              //       Container(color: Colors.green, height: height, child: Text("22222")),
              //       Spacer(),
              //       Expanded(
              //         child: Container(color: Colors.blue, height: height, child: Text("33333")),
              //       ),
              //     ],
              //   ),
              // ),
            ),
          );
        },
      ),
    );
  }
}
