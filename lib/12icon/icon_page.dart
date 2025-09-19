import 'package:flutter/material.dart';

// IconData? icon
// double? size 默认 24
// Color? color 默认颜色根据主题变化，深色主题下是白的

// FontWeight? fontWeight 尺寸还是 24，但图标的确会变化一点点

// double? fill 需要字体支持 FILL 特性，不知道是什么效果？
// double? weight 需要字体支持 wght 特性，不知道是什么效果？
// double? grade
// double? opticalSize

// List<Shadow>? shadows

// TextDirection? textDirection
// bool? applyTextScaling
// BlendMode? blendMode

// String? semanticLabel

class IconPage extends StatelessWidget {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Icon')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ...
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        children: [
          Icon(Icons.star),
          Icon(Icons.star, fill: 0.4),
          Icon(Icons.star, fontWeight: FontWeight.w100),
          Icon(Icons.star, fontWeight: FontWeight.w900),
        ],
      ),
    );
  }
}
