import 'package:flutter/material.dart';

// Visibility 的文档说
// 一般要隐藏一个视图，直接用 if 不让它加到树
// 还能用 SizedBox.shrink 来隐藏一个视图

class HiddenPage extends StatefulWidget {
  const HiddenPage({super.key});

  @override
  State<HiddenPage> createState() => _HiddenPageState();
}

class _HiddenPageState extends State<HiddenPage> {
  var hidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hidden')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => hidden = !hidden);
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("offstage"),
          // 不渲染它，不占空间，但它有尺寸，继续接收键盘，动画也在，就是看不到
          // 它永不保留占位
          Offstage(offstage: hidden, child: FlutterLogo(size: 50)),

          Text("visibility"),
          // 可以保留占位，但要设置三个属性，文档说尽量不要动态改这三个属性
          Visibility(
            visible: !hidden,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: FlutterLogo(size: 50),
          ),

          Text("opacity 0.5"),
          Opacity(opacity: 0.5, child: FlutterLogo(size: 50)),
        ],
      ),
    );
  }
}
