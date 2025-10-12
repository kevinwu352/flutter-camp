import 'package:flutter/material.dart';

// 收到 紧300
//   有子，尺寸随紧，但子收到 紧 w300 h204。给子的高减了安全区，自己的高 - 安全区的高 = 给子的高约束。关键是，这是个居中的300大小的正方形，离安全区很远
// 收到 松100-200
//   有子，尺寸尽量小，但子收到 松 w100-200 h4-104，也减了安全区
// 收到 无限0-inf
//   有子，尺寸随子，子可能非常大，子收到 0-inf，也减了安全区

// maintainBottomViewPadding 这参数没搞懂？
// ensures the form remains visible above the keyboard when it appears

class SafePage extends StatelessWidget {
  const SafePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return OverflowBox(
    //   // minWidth: 300,
    //   // maxWidth: 300,
    //   // minHeight: 300,
    //   // maxHeight: 300,
    //   // minWidth: 100,
    //   // maxWidth: 200,
    //   // minHeight: 100,
    //   // maxHeight: 200,
    //   minWidth: 0,
    //   maxWidth: double.infinity,
    //   minHeight: 0,
    //   maxHeight: double.infinity,
    //   // child: SafeArea(child: Container(color: Colors.teal)),
    //   child: SafeArea(child: Text('a', style: TextStyle(fontSize: 14))),
    // );

    // return SafeArea(child: Container(color: Colors.teal));
    // return SafeArea(child: Column(children: [Text('aaa'), Spacer(), Text('bbb')]));

    // ================================================================================

    // 不可滚动页面，内容一定不能超过屏幕
    return Scaffold(
      appBar: AppBar(title: Text('Safe')),
      body: SizedBox.expand(
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('aaa'), Spacer(), Text('bbb')]),
        ),
      ),
    );

    // 可以滚动页面，列表
    // return Scaffold(
    //   appBar: AppBar(title: Text('Safe')),
    //   body: ListView.builder(itemCount: 80, itemBuilder: (context, index) => Text('data $index')),
    // );

    // 可以滚动页面，单子
    // 如果 SafeArea-SingleChildScrollView，滑动时内容不会滑进安全区，被安全区上边那条线吞没了
    // return Scaffold(
    //   appBar: AppBar(title: Text('Safe')),
    //   body: SizedBox.expand(
    //     child: SingleChildScrollView(
    //       child: SafeArea(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           children: [
    //             Text('aaa'),
    //             ...List.generate(40, (i) => Text('data $i', style: TextStyle(fontSize: 20))),
    //             Text('bbb'),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // ================================================================================

    // 可以滚动页面，单子，有底部
    // return Scaffold(
    //   appBar: AppBar(title: Text('Safe')),
    //   // body: SizedBox.expand(
    //   //   child: SingleChildScrollView(
    //   //     child: SafeArea(
    //   //       child: Column(
    //   //         crossAxisAlignment: CrossAxisAlignment.end,
    //   //         children: [
    //   //           Text('aaa'),
    //   //           ...List.generate(
    //   //             40,
    //   //             (i) => Text('data $i', style: TextStyle(backgroundColor: ColorsExt.rand(), fontSize: 20)),
    //   //           ),
    //   //           Text('bbb'),
    //   //         ],
    //   //       ),
    //   //     ),
    //   //   ),
    //   // ),
    //   body: SizedBox.expand(
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: SingleChildScrollView(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.end,
    //               children: [...List.generate(40, (i) => Text('data $i', style: TextStyle(fontSize: 20)))],
    //             ),
    //           ),
    //         ),
    //         SafeArea(child: Column(children: [Text('adfasdfas')])),
    //       ],
    //     ),
    //   ),
    // );
  }
}
