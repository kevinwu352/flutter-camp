import 'package:flutter/material.dart';

// 继承关系
// ShapeBorder -> BoxBorder, InputBorder, OutlinedBorder
//
//   BoxBorder -> Border
//   OutlinedBorder
//     CircleBorder 第二个参数决定圆形为了适配父的尺寸的变形程度，1 是完全变形，会变成一个椭圆
//     RoundedRectangleBorder
//     BeveledRectangleBorder 的角是直线不是圆角，RoundedRectangleBorder 是两点用弧线连接，它是用直线
//     ContinuousRectangleBorder 比 RoundedRectangleBorder 要大一点点，没看出有什么特别的
//     LinearBorder 能分别决定显示四个边线，但不能决定各自的样式，上面的 Border 四条边的样式能分别指定
//     StadiumBorder 胶囊形状，这单词是体育馆，体育馆也像胶囊，是吧？
//     StarBorder 几角星或几边形，参数非常丰富，具体看文档
//   InputBorder
//     OutlineInputBorder 圆角边框
//     UnderlineInputBorder 只有下边框
// Container.decoration = BoxDecoration.border 这里是 BoxBorder
//
// 区别是什么？
// BoxBorder 能分别定义四条边的样式
//   无法单独做出圆角，这俩配合可以做出圆角 BoxDecoration(border: borderRadius:)
// OutlinedBorder 有各种形状的子类，子类一般接受一个边样式和圆角样式
//   可以单独做出圆角
//   ButtonStyle 里面的 shape 是 OutlinedBorder
// InputBorder 专门给 InputDecoration 用的，用来修饰输入框
//   只接受一个边样式，圆角能分别指定

// ================================================================================

// Border, 有四条边 BorderSide，宽度传 0 会画出 1 个物理像素的线
// strokeAlign 定义边框位置，默认在内
//   控件内，会撑大控件，注意不是占有控件原有的空间，是把控件撑大 border_width*2，因为 左右 上下
//   控件外，控件尺寸不变，下一个控件可能会压在边框上，边框大的话很明显，如下面的例子
//   骑在边线上
// 这个异常：A Border can only draw strokeAlign different than BorderSide.strokeAlignInside on borders with uniform colors.
// 如果 align 不是 inside，不能只给一条边加边框，四条边框都要有，且宽度颜色要相同

// ================================================================================

// BorderRadius 能分别定义四个角的样式，每个样式都是一个 Radius

// ================================================================================

// Radius 定义单个角的样式，圆形/椭圆

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
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              // shape: CircleBorder(side: BorderSide(color: Colors.red, width: 2), eccentricity: 0.6),
              // shape: RoundedRectangleBorder(
              //   side: BorderSide(color: Colors.red, width: 2),
              //   borderRadius: BorderRadius.circular(8),
              // ),
              // shape: LinearBorder(
              //   side: BorderSide(color: Colors.red, width: 4),
              //   bottom: LinearBorderEdge(),
              // ),
              // shape: StadiumBorder(side: BorderSide(color: Colors.red, width: 4)),
              shape: StarBorder(side: BorderSide(color: Colors.red, width: 2), points: 6),
              // shape: StarBorder.polygon(side: BorderSide(color: Colors.red, width: 2), sides: 6),
            ),
            child: Text('abc'),
          ),

          TextField(
            decoration: InputDecoration(
              // border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 4)),
              border: UnderlineInputBorder(),
            ),
          ),

          SizedBox(height: 20),

          Container(
            // decoration: BoxDecoration(
            //   color: Colors.teal,
            //   // border: Border.all(color: Colors.red),
            //   // shape: BoxShape.circle,
            //   // borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            // ),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green, width: 2),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              ),
              // shape: Border.all(color: Colors.purple, width: 2),
            ),
            width: 160,
            height: 120,
          ),
        ],
      ),
    );
  }
}
