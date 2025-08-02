import 'package:flutter/material.dart';

// Column 宽随子 高随父，设置 mainAxisSize = .min 后 高随子
// return Center(child:
//   Column(children: [
//     Text("data"),
//   ])
// );
//
// MainAxisAlignment.spaceBetween 前后无空白
// MainAxisAlignment.spaceAround 前后的空白是中间空白的一半
// MainAxisAlignment.spaceEvenly 前后中间空白一致
//
// CrossAxisAlignment.stretch 时，Column 收到的是松约束 0-402，向下传递的是紧约束 402，高度还是松无限。这导致 Column 撑宽到屏幕
// 其它情况传递的是松约束，0-402 0-inf
//
// return Center(
//   child: Column(
//     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     // mainAxisSize: MainAxisSize.min,
//     // crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [Text("111"), Text("2")],
//   ),
// );

class ColumnPage extends StatelessWidget {
  const ColumnPage({super.key});

  // 一个包含 Expanded/Flexible 的 Column 加到另一个 Column/ListView 会崩
  // 一个 ListView 加到 Column 会崩
  // 解决办法是：把内部的东西用 Expanded/Flexible/SizedBox 包起来

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Row")),
      body: Column(
        children: [
          Column(children: [Text("11")]), // 正常
          // Column(children: [Expanded(child: Text("22"))]), // 要崩
        ],
      ),
      // Column(
      //   children: [
      //     ListView(children: [Text("aa"), Text("bb")]), // 要崩
      //   ],
      // ),
      // ListView(
      //   children: [
      //     Column(children: [Text("aa"), Text("bb")]), // 正常
      //     // Column(children: [Expanded(child: Text("11"))]), // 要崩
      //   ],
      // ),
    );
  }
}
