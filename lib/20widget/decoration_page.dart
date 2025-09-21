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
              boxShadow: [BoxShadow(color: Colors.red, offset: Offset(5, 5), blurRadius: 5)],
            ),
            child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Text('abc')),
          ),

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
