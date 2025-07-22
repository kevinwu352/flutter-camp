import 'package:flutter/material.dart';

// FittedBox 缩放内容，只缩放有限，否则会崩
// LimitedBox 只约束无限，这应该叫有限盒子

// OverflowBox 溢出不警告，手动设置要传给子的约束

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

    // SizedBox 固定尺寸，如果传无限则占满可用空间expand，无子时用来撑开间距
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

    // SizedOverflowBox 同 SizedBox，但向下传的约束是原始的自己收到的。可能会溢出，但没溢出警告
    // 盒子是 200*200，超出的内容也不切掉
    // 向下传松约束 0-402 0-874
    // return Center(
    //   child: SizedOverflowBox(
    //     size: Size(200, 200),
    //     alignment: Alignment.centerRight,
    //     child: Text("god is a girl"),
    //   ),
    // );
    // 这个例子抄的，更直观
    // return Center(
    //   child: Container(
    //     color: Colors.orange,
    //     child: SizedOverflowBox(
    //       size: Size(200, 200),
    //       alignment: Alignment.centerRight,
    //       child: Text("god is a girl"),
    //     ),
    //   ),
    // );

    // FractionallySizedBox 用父的百分比宽高
    // 向下传紧约束 201 437
    // 无子时也当成百分比间隔来用，像 SizedBox 一样
    // return Center(
    //   child: FractionallySizedBox(
    //     widthFactor: 0.5,
    //     heightFactor: 0.5,
    //     child: ElevatedButton(onPressed: () {}, child: Text("doit")),
    //     // child: DecoratedBox(
    //     //   decoration: BoxDecoration(
    //     //     border: Border.all(color: Colors.blue, width: 1),
    //     //   ),
    //     // ),
    //   ),
    // );
    // 直接用在 Column/Row 里面会崩
    // 但用 Expanded 包起来也不是我想要的，我想要的是0.2屏幕高的空白，结果把文字顶到头尾了，咋办？
    // return Column(
    //   children: [
    //     Text("aaaaa"),
    //     Expanded(child: FractionallySizedBox(heightFactor: 0.2)),
    //     Text("bbbbb"),
    //   ],
    // );

    return Text("data");
  }
}
