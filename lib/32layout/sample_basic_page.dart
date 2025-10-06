import 'package:flutter/material.dart';

class SampleBasicPage extends StatelessWidget {
  const SampleBasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ================================================================================
    // Center 能将收到的紧约束变成松约束，再传给子
    //
    // Align 是 Center 的父类
    //
    // ================================================================================
    // 1) 屏幕强制它占满
    // return Container(color: Colors.red);
    // 2) 虽然自己要求 100*100 的尺寸，但屏幕强制它占满
    // return Container(width: 100, height: 100, color: Colors.red);

    // 4) Align 是 Center 的父类，子类也能自由决定自己的尺寸
    // return Align(
    //   alignment: Alignment.centerRight,
    //   child: Container(width: 100, height: 100, color: Colors.red),
    // );

    // 3) Center 占满屏幕，它要求子尺寸不超过屏幕即可
    // 子想要有限
    // return Center(child: Container(width: 100, height: 100, color: Colors.red));
    // 5)
    // 子想要无限，占满了允许的空间
    // return Center(
    //   child: Container(width: double.infinity, height: double.infinity, color: Colors.red),
    // );

    // 6)
    // Container 无子无尺寸时，父给有限就尽量大，父给无限就尽量小
    // return Center(child: Container(color: Colors.red));
    //*7) Center 占满屏幕，红色有子，跟随子的尺寸
    // 不加宽高，看见小绿块；加上宽高，看见大绿块
    // 因为：无宽高时绿块收到 0-402 0-807 松约束，有宽高时绿块收到 100 100 紧约束
    // return Center(
    //   child: Container(
    //     color: Colors.red,
    //     // width: 100,
    //     // height: 100,
    //     child: Container(color: Colors.green, width: 30, height: 30),
    //   ),
    // );
    // 8) 看见回形
    // return Center(
    //   child: Container(
    //     padding: EdgeInsets.all(30),
    //     color: Colors.red,
    //     child: Container(color: Colors.green, width: 30, height: 30),
    //   ),
    // );

    // ================================================================================
    // Row/Column 传递给正常子的主轴方向的约束是无限，但如果最终子的尺寸太大也会显示溢出警告
    //
    // 正常子先自由占用空间，然后把剩余的空间分配给 Expanded/Flexible，多个 Expanded/Flexible 根据 flex 参数按比例分配空间
    //
    // 正常子收到的是无限约束，所以才能自由地占用空间
    // Expanded 收到的是紧约束，这约束继续传递给子
    // Flexible 收到的是松约束，这约束继续传递给子
    // ================================================================================
    // 23) Row 限高不限宽。Container 收到 0-inf 0-874，Text 也是
    // return Row(
    //   children: [
    //     Container(
    //       color: Colors.blue,
    //       child: Text('Hello!', style: TextStyle(fontSize: 20)),
    //     ),
    //     Container(
    //       color: Colors.green,
    //       child: Text('Goodbye!', style: TextStyle(fontSize: 20)),
    //     ),
    //   ],
    // );
    // 24) 内容太长会显示溢出警告
    // ...
    // 25) 用 Expanded 包起来以后，这个子真正的尺寸就不重要了，其它子先布局，剩下的空间全是它的
    // Expanded 收到 紧300.4 松0-874，子 Container 也是，Text 也是
    // Container 收到 0-inf 0-874
    // 例子中 Container 被 Center 包起来，感觉要不要效果一样
    // return Row(
    //   children: [
    //     Expanded(
    //       // child: Container(
    //       //   color: Colors.blue,
    //       //   child: Text('This is a very long text that won\'t fit the line.', style: TextStyle(fontSize: 20)),
    //       //   // child: Text('this is', style: TextStyle(fontSize: 20)),
    //       // ),
    //       child: Text('This is a very long text that won\'t fit the line.', style: TextStyle(fontSize: 20)),
    //       // child: Text('this is', style: TextStyle(fontSize: 20)),
    //     ),
    //     Container(
    //       color: Colors.green,
    //       child: Text('Goodbye!', style: TextStyle(fontSize: 20)),
    //     ),
    //   ],
    // );
    // 26) 左右等宽。Expanded 收到 201紧 0-874松
    // return Row(
    //   children: [
    //     Expanded(
    //       child: Container(
    //         color: Colors.red,
    //         child: Text('This is a very long text that won\'t fit the line.', style: TextStyle(fontSize: 20)),
    //       ),
    //     ),
    //     Expanded(
    //       child: Container(
    //         color: Colors.green,
    //         child: Text('Goodbye!', style: TextStyle(fontSize: 20)),
    //       ),
    //     ),
    //   ],
    // );
    // 27) Flexible 收到 0-201 0-874，Container 也是，Text 也是
    // 可见，Row 给 Expanded 紧约束，给 Flexible 松约束。结果就是，F 的子 <= F，E 的子 == E。它俩都忽略子的尺寸
    // return Row(
    //   children: [
    //     Flexible(
    //       child: Container(
    //         color: Colors.red,
    //         child: Text('This is a very long text that won\'t fit the line.', style: TextStyle(fontSize: 20)),
    //       ),
    //     ),
    //     Flexible(
    //       child: Container(
    //         color: Colors.green,
    //         child: Text('Goodbye!', style: TextStyle(fontSize: 20)),
    //       ),
    //     ),
    //   ],
    // );

    // ================================================================================
    // Scaffold 自己收到紧约束，被强制全屏，但它给 body 的是松约束，所以 body 不强制全屏
    //
    // SizedBox.expand 把从 Scaffold 收到的松约束变成紧的，再传下去
    // ================================================================================
    //*28) Column 占据屏幕左侧部分空间
    // Container 收到松约束 0-402 0-874，Column 也是，Text 限宽不限高
    // return Scaffold(
    //   body: Container(
    //     color: Colors.blue,
    //     child: Column(children: [Text('Hello!'), Text('Goodbye!')]),
    //   ),
    // );
    //*29)
    // Scaffold 给 SizedBox 松约束，而 SizedBox 向下传紧约束
    // SizedBox 收到松约束 0-402 0-874，Container 收到 402 874 紧，Column 也是
    // return Scaffold(
    //   body: SizedBox.expand(
    //     child: Container(
    //       color: Colors.blue,
    //       child: Column(children: [Text('Hello!'), Text('Goodbye!')]),
    //     ),
    //   ),
    // );

    return Text("--");
  }
}
