import 'package:flutter/material.dart';

// BoxDecoration, ShapeDecoration, FlutterLogoDecoration, UnderlineTabIndicator

// ================================================================================

// Color? color 填充色
// DecorationImage? image

// BoxBorder? border
// BorderRadiusGeometry? borderRadius
//   Radius.circular   表示这个角的 x y 相同，这个角是圆形的 1/4
//   Radius.elliptical 表示这个角的 x y 不同，这个角是椭圆的 1/4

// BoxShape shape = BoxShape.rectangle
// 默认是矩形，能变成圆形 BoxShape.circle

// 阴影能显示到自己盒子外面
//   BlurStyle.normal 内外都有毛绒绒的阴影，内部阴影充满了，但和 solid 的实心颜色明显不同
//   BlurStyle.solid 内部是实心的颜色，外部有毛绒绒的阴影
//   BlurStyle.inner 边界内部有毛绒绒的阴影，外部没有，内部也是充满的毛绒绒的
//   BlurStyle.outer 边界外部有毛绒绒的阴影，内部没有
// spreadRadius 是先加到边界上（用 solid 模式能看到明显边界）再做阴影
// 即，如果控件高度 40，本来边界高度 40，spreadRadius=5 会让边界变成 50 高。offset=zero 时，也能明显看到背后的阴影变大了
// List<BoxShadow>? boxShadow

// Gradient? gradient

// BlendMode? backgroundBlendMode

class DecorationPage extends StatelessWidget {
  const DecorationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Decoration')),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              // border: Border.all(color: Colors.green, width: 1),
              // borderRadius: BorderRadius.circular(10),
              // borderRadius: BorderRadius.all(Radius.elliptical(10, 20)),
              // shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red,
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  spreadRadius: 5,
                  blurStyle: BlurStyle.normal,
                ),
              ],
            ),
            child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Text('abc')),
          ),

          SizedBox(height: 20),
          Container(color: Colors.green, width: 100, height: 10),

          // ShapeDecoration 的一个例子
          Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape:
                  Border.all(color: Colors.red, width: 8.0) +
                  Border.all(color: Colors.green, width: 8.0) +
                  Border.all(color: Colors.blue, width: 8.0),
            ),
            child: const Text('RGB', textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
