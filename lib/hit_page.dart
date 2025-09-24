import 'package:flutter/material.dart';

// 当俩控件有颜色时，效果是正常的，点哪个就打印哪个

// 当俩控件无颜色时
//   deferToChild，点俩控件都无输出
//   opaque，点哪个打印哪个
//   translucent，点大的输出大的，点小的输出两个

// 后面再研究吧

class HitPage extends StatelessWidget {
  const HitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('--')),
      body: Stack(
        children: [
          Align(alignment: Alignment.center, child: getView(1)),
          Align(alignment: Alignment.center, child: getView(2)),
        ],
      ),
    );
  }

  Widget getView(int i) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) => print('i:$i'),
      child: Container(
        width: i == 1 ? 400 : 200,
        height: i == 1 ? 400 : 200,
        // color: i == 1 ? Colors.red : Colors.green,
      ),
    );
  }
}
