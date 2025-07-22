import 'package:flutter/material.dart';

// ConstrainedBox
// UnconstrainedBox

// FittedBox 缩放内容，只缩放有限，否则会崩
// LimitedBox 只约束无限，这应该叫有限盒子

// OverflowBox 溢出不警告，手动设置要传给子的约束
// SizedBox 固定尺寸，如果传无限则占满可用空间expand，无子时用来撑开间距

// SizedOverflowBox
// FractionallySizedBox

class BoxPage extends StatelessWidget {
  const BoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: const BoxConstraints(
    //       maxWidth: 200,
    //     ), // 让文字换行，如果文字只有 150 宽，实际也会是 150
    //     child: Text("god is a girl"),
    //   ),
    // );
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: const BoxConstraints(minHeight: 100), // 增加按钮高度
    //     child: Container(color: Colors.green, child: Text("god is a girl")),
    //   ),
    // );
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints.expand(), // 占满全屏
    //     child: Card(child: Text('Hello World!')),
    //   ),
    // );

    // return Center(
    //   // 固定尺寸
    //   // child: SizedBox( // 往下传紧约束 300*60
    //   //   width: 300, height: 60,
    //   //   child: ElevatedButton(onPressed: () {}, child: Text("doit")),
    //   // ),
    //   // 占满全屏
    //   // child: SizedBox.expand( // 收到的是松约束，向下传紧的 402*874
    //   //   child: ElevatedButton(onPressed: () {}, child: Text("doit")),
    //   // ),
    //   // 看不见东西了
    //   // child: SizedBox.shrink( // 收到的是松约束，向下传紧的 0*0
    //   //   child: ElevatedButton(onPressed: () {}, child: Text("doit")),
    //   // ),
    // );

    return Text("data");
  }
}
