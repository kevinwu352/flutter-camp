import 'dart:math';
import 'package:flutter/material.dart';

class TransformPage extends StatelessWidget {
  const TransformPage({super.key});

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
          Text('aaaaaaaaaa', style: TextStyle(backgroundColor: Colors.green)),
          Transform.rotate(angle: pi / 4, child: Image.asset('assets/images/bg.jpg', width: 134, height: 89)),
          Text('bbbbbbbbbb', style: TextStyle(backgroundColor: Colors.green)),

          // RotatedBox 在布局前施加旋转，所以宽视图旋转90度后，会变成高视图
          // 适合永久旋转；参数 1 个单位表示90度，且只能是整数
          Text('cccccccccc', style: TextStyle(backgroundColor: Colors.green)),
          RotatedBox(quarterTurns: 1, child: Image.asset('assets/images/bg.jpg', width: 134, height: 89)),
          Text('dddddddddd', style: TextStyle(backgroundColor: Colors.green)),
        ],
      ),
    );
  }
}
