import 'package:flutter/material.dart';

// IndexedStack 有多个子视图，但任何时刻只显示 一个/零个 子视图，像电视机一样
// 尺寸和最大的子相同，如果 index=null 就不显示任何东西

// ================================================================================

// left/right/width 三者只能设其二
// top/bottom/height 三者只能设其二
// 如果这六个参数都为空，那么这个 Positioned 是未定位的

// 什么是定位？
// 定位分为横轴和纵轴，对横轴而言，只要指定了 left/right/width 其中一个，则表示横轴有定位
// 所以，只定位横轴或纵轴叫半定位
//
// 未定位元素有哪些？
// 1)没用 Positioned 包起来的
// 2)使用 Positioned 包起来但 6 个参数全为空的

// ================================================================================

// 未定位和半定位的元素，用此参数来对齐
// AlignmentGeometry alignment = AlignmentDirectional.topStart

// 将 Stack 收到的约束调整后传递给未定位的元素，这个调整策略
// 只影响未定位子元素，半定位的没影响
//   loose 将约束放松，紧的 x-x 变成 0-x，松的 x-y 变成 0-y
//   expand 将约束变紧，而且是尽量大，收到无限时会崩
//   passthrough 直接传给子，不做任何调整
// StackFit fit = StackFit.loose

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),

      // body: SizedBox.expand(
      //   child: Stack(
      //     alignment: Alignment.center,
      //     fit: StackFit.expand,
      //     children: [
      //       // Container(
      //       //   color: Colors.red,
      //       //   child: Text("Hello world", style: TextStyle(color: Colors.white)),
      //       // ),
      //       // Positioned(left: 18.0, child: Text("I am Jack")),
      //       // Positioned(top: 18.0, child: Text("Your friend")),
      //       // ----------
      //       Positioned(left: 18.0, child: Text("I am Jack")),
      //       Container(
      //         color: Colors.red,
      //         child: Text("Hello world", style: TextStyle(color: Colors.white)),
      //       ),
      //       Positioned(top: 18.0, child: Text("Your friend")),
      //     ],
      //   ),
      // ),

      // 收到 紧300
      //   无子，尺寸随紧
      //   有子，尺寸随紧，但子收到 松0-300，因为 fit=.loose
      // 收到 松100-200
      //   无子，尺寸尽量大 200
      //   有子，尺寸尽量大 200，但子收到 松0-200，因为 fit=.loose
      // 收到 无限0-inf
      //   无子，尺寸尽量小 0
      //   有子，尺寸随子，子可能非常大，子收到 0-inf
      body: OverflowBox(
        // minWidth: 300,
        // maxWidth: 300,
        // minHeight: 300,
        // maxHeight: 300,
        // minWidth: 100,
        // maxWidth: 200,
        // minHeight: 100,
        // maxHeight: 200,
        minWidth: 0,
        maxWidth: double.infinity,
        minHeight: 0,
        maxHeight: double.infinity,
        child: Stack(
          // fit: StackFit.expand,
          children: [Container(color: Colors.teal, width: 2000, height: 2000)],
        ),
      ),
    );
  }
}
