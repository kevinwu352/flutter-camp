import 'package:flutter/material.dart';

// 继承关系
// ShapeBorder -> BoxBorder, InputBorder, OutlinedBorder
//   BoxBorder -> Border
//   OutlinedBorder -> CircleBorder, RoundedRectangleBorder, ... 子类是一堆形状开头的
//   InputBorder -> UnderlineInputBorder, OutlineInputBorder
// Container.decoration = BoxDecoration.border 这里是 BoxBorder
//
// 区别是什么？
// AI 说 BoxBorder 给 BoxDecoration 用的，分别定义四条边的样式，OutlinedBorder 用于给一个 Shape 定义边框

// Border, 有四条边 BorderSide，宽度传 0 会画出 1 个物理像素的线
// strokeAlign 定义边框位置，默认在内
//   控件内，会撑大控件，注意不是占有控件原有的空间，是把控件撑大 border_width*2，因为 左右 上下
//   控件外，控件尺寸不变，下一个控件可能会压在边框上，边框大的话很明显，如下面的例子
//   骑在边线上
// 这个异常：A Border can only draw strokeAlign different than BorderSide.strokeAlignInside on borders with uniform colors.
// 如果 align 不是 inside，不能只给一条边加边框，四条边框都要有，且宽度颜色要相同

class BorderPage extends StatelessWidget {
  const BorderPage({super.key});

  final w = 8.0;
  final pos = BorderSide.strokeAlignCenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Border')),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(width: 4.0, color: Colors.blue),
              // border: Border(
              //   left: BorderSide(width: w, color: Colors.blue, strokeAlign: pos),
              //   top: BorderSide(width: w, color: Colors.blue, strokeAlign: pos),
              //   bottom: BorderSide(width: w, color: Colors.blue, strokeAlign: pos),
              //   right: BorderSide(width: w, color: Colors.blue, strokeAlign: pos),
              // ),
            ),
            child: const Text('Flutter in the sky', textAlign: TextAlign.center),
          ),
          Container(color: Colors.red, width: 100, height: 100),

          // Container(
          //   decoration: BoxDecoration(border: CircleBorder()),
          //   child: const Text('RGB', textAlign: TextAlign.center),
          // ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: CircleBorder(side: BorderSide(color: Colors.red, width: 4)),
            ),
            child: Text('abc'),
          ),
        ],
      ),
    );
  }
}
