import 'package:flutter/material.dart';

// 正常情况下，如果要隐藏一个控件，直接用 if 不让它加到树
// 文档说：如果是无状态控件，用 SizedBox.shrink

// Opacity 也保留空间。能在 Stack 中给下面加蒙板。AnimatedOpacity 还能动画
// 很耗性能，有中间缓冲区
// animate opacity 属性耗性能，用 AnimatedOpacity
// 如果是图片颜色要透明，用这种性能更好
// Image.network(
//   'https://raw.githubusercontent.com/flutter/assets-for-api-docs/main/packages/diagrams/assets/blend_mode_destination.jpeg',
//   color: const Color.fromRGBO(255, 255, 255, 0.5),
//   colorBlendMode: BlendMode.modulate
// )

class OffstagePage extends StatefulWidget {
  const OffstagePage({super.key});

  @override
  State<OffstagePage> createState() => _OffstagePageState();
}

class _OffstagePageState extends State<OffstagePage> {
  final GlobalKey _key = GlobalKey();
  bool _offstage = true;

  Size _getFlutterLogoSize() {
    final RenderBox renderLogo =
        _key.currentContext!.findRenderObject()! as RenderBox;
    return renderLogo.size;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("1"),
        Offstage(
          // 不渲染它，不占空间（但它有尺寸），继续接收键盘，动画也在，就是看不到
          // 它永不保留占位
          offstage: _offstage,
          child: FlutterLogo(key: _key, size: 150.0),
        ),
        Text("2"),
        Visibility(
          visible: !_offstage,
          maintainSize: true, // 可以保留占位，但要设置三个属性
          maintainAnimation: true,
          maintainState: true,
          child: Text("datadata"),
        ),
        Text("3"),
        Opacity(opacity: 0.5, child: Text("hehe")),
        Text("4"),
        Text('hide: $_offstage'),
        ElevatedButton(
          child: const Text('Toggle Offstage Value'),
          onPressed: () {
            setState(() {
              _offstage = !_offstage;
            });
          },
        ),
        if (_offstage)
          ElevatedButton(
            child: const Text('Get Flutter Logo size'),
            onPressed: () {
              print('Flutter Logo size is ${_getFlutterLogoSize()}');
            },
          ),
      ],
    );
  }
}
