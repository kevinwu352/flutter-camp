import 'package:flutter/material.dart';

// REVIEW

// Transform.translate 单位是 pt，0-400
// FractionalTranslation 单位是子尺寸百分比，0-1，和 Transform.translate 一样，也不会挤后面的空间
// AnimatedSlide 单位是子尺寸百分比，0-1，也不挤空间
// SlideTransition 单位是子尺寸百分比，0-1，也不挤空间

class TransformPage extends StatefulWidget {
  const TransformPage({super.key});

  @override
  State<TransformPage> createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage> with SingleTickerProviderStateMixin {
  late final animation = AnimationController(vsync: this, duration: Duration(milliseconds: 300))..forward();
  late final anim = animation.drive(Tween(begin: Offset(0, 0), end: Offset(0, 0.5)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transform')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        children: [
          // Transform.rotate 在画之前施加旋转，所以宽视图旋转90度后，它占用的位置还是宽的
          // Transform.flip / Transform.scale / Transform.translate
          // 适合做动画；自由调节旋转角度
          Text('aaaaaaaaaa', style: TextStyle(backgroundColor: Colors.green.withValues(alpha: 0.5), fontSize: 24)),
          // Transform.rotate(angle: pi / 4, child: Image.asset('assets/images/bg.jpg', width: 134, height: 89)),
          // Transform.translate(
          //   offset: Offset(0, 20),
          //   child: Text('data', style: TextStyle(backgroundColor: Colors.red, fontSize: 48)),
          // ),
          // FractionalTranslation(
          //   translation: Offset(0, 0.5),
          //   child: Text('data', style: TextStyle(backgroundColor: Colors.red, fontSize: 48)),
          // ),
          // AnimatedSlide(
          //   offset: Offset(0, 0.25),
          //   duration: Duration(milliseconds: 300),
          //   child: Text('data', style: TextStyle(backgroundColor: Colors.red, fontSize: 48)),
          // ),
          SlideTransition(
            position: anim,
            child: Text('data', style: TextStyle(backgroundColor: Colors.red, fontSize: 48)),
          ),
          Text('bbbbbbbbbb', style: TextStyle(backgroundColor: Colors.green.withValues(alpha: 0.5), fontSize: 24)),

          // RotatedBox 在布局前施加旋转，所以宽视图旋转90度后，会变成高视图
          // 适合永久旋转；参数 1 个单位表示90度，且只能是整数
          // Text('cccccccccc', style: TextStyle(backgroundColor: Colors.green)),
          // RotatedBox(quarterTurns: 1, child: Image.asset('assets/images/bg.jpg', width: 134, height: 89)),
          // Text('dddddddddd', style: TextStyle(backgroundColor: Colors.green)),
        ],
      ),
    );
  }
}
