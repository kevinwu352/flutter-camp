import 'package:flutter/material.dart';

// https://juejin.cn/post/7168985274716782629
// 非文字控件的基线在底部
// Baseline 控件会指定一个基线位置，然后 child 有根基线，它俩的基线重合在一起

class BaselinePage extends StatelessWidget {
  const BaselinePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text')),
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Baseline(
            baseline: 100, // 红框高 100，红框刚好包住蓝块
            // baseline: 50, // 红框高 50，红框包住蓝块下半
            // baseline: 150, // 红框高 150，蓝块靠下
            // baseline: -50, // 红框高 0，蓝块在上边 50 距离处
            baselineType: TextBaseline.ideographic,
            child: Container(width: 100, height: 100, color: Colors.blue),
            // 文字方面，设置基线没看出啥效果，以后再说吧？
            // child: Text('jKf', style: TextStyle(fontSize: 60, textBaseline: TextBaseline.alphabetic)),
          ),
        ),
      ),
    );
  }
}
