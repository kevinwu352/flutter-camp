import 'package:flutter/material.dart';

// 注意这里有个动画的实现

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> with TickerProviderStateMixin {
  late AnimationController controller;

  // late AnimationController c;
  // late Animation<Color> tween;

  @override
  void initState() {
    // 一个 valueColor 的动画用法，没运行起来
    // c = AnimationController(vsync: this, duration: Duration(seconds: 2));
    // tween = c.drive(ColorTween(begin: Colors.red, end: Colors.green));
    // c.repeat();
    // valueColor: tween
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress')),
      body: Column(
        children: [
          // 默认尺寸 36*36
          CircularProgressIndicator(
            value: controller.value,

            color: Colors.amber, // 进度条的颜色
            backgroundColor: Colors.green, // 圆环的颜色
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red), // 应该是非限定进度条转圈的时候颜色动画

            strokeWidth: 10, // 不会改变尺寸
            strokeAlign: -1, // 不会改变尺寸，[-1,1] 之间，-1 是在边界内
            // strokeCap: StrokeCap.round,

            // padding: EdgeInsets.all(10),

            // trackGap: 4, // 文档说，进度和背景之间的一段空白，没实验出来
          ),

          LinearProgressIndicator(
            value: 0.3,
            minHeight: 20,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(4)), // 条条两端的圆角样式
            // stopIndicatorColor: Colors.red, // 条条最后结尾处有个非常小的圆泡泡
            // stopIndicatorRadius: 5,
            trackGap: 10, // 新风格中，条条是分成两段的，进度这段有填充颜色，后边那段是背景色，中间有个间隔
            year2023: false,
          ),
        ],
      ),
    );
  }
}
