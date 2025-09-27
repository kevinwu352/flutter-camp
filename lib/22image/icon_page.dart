import 'package:flutter/material.dart';

// 适配平台的图标
//   Icon(Icons.arrow_back)
//   Icon(Icons.adaptive.arrow_back)
// 但好像数量不多，arrow* flip* more* share*

// ================================================================================

// IconData? icon
// double? size 默认 24
// Color? color 默认颜色根据主题变化，深色主题下是白的

// List<Shadow>? shadows
// Shadow(color: Colors.yellow,
//        offset: Offset(2, 2), 正值往右下移动
//        blurRadius: 5 值越大，阴影散得越远。如果是 0，offset 也是 .zero，阴影就完全被挡住了
// )
// 这数组里如果添加两个阴影，两个阴影的位置可以不同，但颜色都会用第一个阴影的颜色，为什么？

// --------------------------------------------------------------------------------

// FontWeight? fontWeight 尺寸还是 24，但图标的确会变化一点点

// TextDirection? textDirection 有些图标会根据语言环境决定方向，比如 Icons.arrow_back，ltr / rtl 会是相反方向

// 当你文字和图标一起显示时，如果文字根据系统设置缩放了，最好把图标也跟着缩放，否则会突兀
// bool? applyTextScaling

// 有一堆预设模式，有机会再研究
// BlendMode? blendMode

// --------------------------------------------------------------------------------

// double? fill 需要字体支持 FILL 特性，不知道是什么效果？
// double? weight 需要字体支持 wght 特性，不知道是什么效果？
// double? grade 需要字体支持 GRAD 特性，不知道是什么效果？
// double? opticalSize 需要字体支持 opsz 特性，不知道是什么效果？

// String? semanticLabel

class IconPage extends StatelessWidget {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Icon')),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ...
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        children: [
          Icon(Icons.star),
          Icon(
            Icons.star,
            color: Colors.green,
            shadows: [
              Shadow(color: Colors.blue, offset: Offset(5, 5), blurRadius: 5),
              Shadow(color: Colors.purple, offset: Offset(-5, -5), blurRadius: 5), // 为什么这个阴影的颜色不起作用？
            ],
          ),
        ],
      ),
    );
  }
}
