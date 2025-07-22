import 'package:flutter/material.dart';

class RowPage extends StatelessWidget {
  const RowPage({super.key});

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
