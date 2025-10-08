import 'package:flutter/material.dart';

class SampleBasicPage extends StatelessWidget {
  const SampleBasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ================================================================================
    // Center 能将收到的紧约束变成松约束，再传给子
    // Align 是 Center 的父类
    // Container 的宽高会向下传递紧约束
    // ================================================================================
    // 1) 占满全屏
    // return Container(color: Colors.red);
    // 2) 占满全屏，虽然自己想要 100*100
    // return Container(width: 100, height: 100, color: Colors.red);

    // 4) Align 占满全屏，它的子能自由定位
    // return Align(
    //   alignment: Alignment.centerRight,
    //   child: Container(width: 100, height: 100, color: Colors.red),
    // );

    // 3) Center 占满全屏，子想要有限或无限尺寸都行，但最终都会被限制在屏幕内
    // return Center(child: Container(width: 100, height: 100, color: Colors.red));
    // 5)
    // return Center(
    //   child: Container(width: double.infinity, height: double.infinity, color: Colors.red),
    // );

    // 6) Container 占满全屏，因为无子随父
    // return Center(child: Container(color: Colors.red));
    //*7) Center 占满全屏，红色有子，跟随子的尺寸
    // 不加宽高，看见小绿块，绿块收到 0-402 0-807 松约束
    // 加上宽高，看见大绿块，绿块收到 100 100 紧约束
    // return Center(
    //   child: Container(
    //     color: Colors.red,
    //     width: 100,
    //     height: 100,
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

    // ********************************************************************************

    // ================================================================================
    // Column/Row
    // 宽随子 高随父，设置 mainAxisSize = .min 后 高随子
    //
    // CrossAxisAlignment.stretch 传递给子 402-402 0-inf，其它情况传递给子 0-402 0-inf
    //
    // MainAxisAlignment.spaceBetween 前后无空白
    // MainAxisAlignment.spaceAround 前后的空白是中间空白的一半
    // MainAxisAlignment.spaceEvenly 前后中间空白一致
    //
    // Spacer(flex: x) 控件用于精细化控件布局，它占用 Column/Row 的剩余空间，还能按比例分配剩余空间
    //
    // VerticalDirection verticalDirection = .down / .up 堆延伸的方向
    //
    // double spacing = 0.0
    //
    // 收到 紧300
    //   无子，尺寸随紧
    //   有子，尺寸随紧，但子收到 松 0-300 0-inf
    // 收到 松100-200
    //   无子，宽尽量小 100，高尽量大 200
    //   有子，宽尽量小 100，高尽量大 200，子收到 松 0-200 0-inf
    // 收到 无限0-inf
    //   无子，尺寸尽量小 0
    //   有子，尺寸随子，子可能非常大，子收到 0-inf 0-inf
    // ================================================================================
    // return Scaffold(
    //   body: OverflowBox(
    //     // minWidth: 300,
    //     // maxWidth: 300,
    //     // minHeight: 300,
    //     // maxHeight: 300,
    //     // minWidth: 100,
    //     // maxWidth: 200,
    //     // minHeight: 100,
    //     // maxHeight: 200,
    //     minWidth: 0,
    //     maxWidth: double.infinity,
    //     minHeight: 0,
    //     maxHeight: double.infinity,
    //     child: Column(
    //       // mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text('aaa', style: TextStyle(fontSize: 14)),
    //         Text('bbb', style: TextStyle(fontSize: 24)),
    //         Text('ccc', style: TextStyle(fontSize: 14)),
    //         // Text('displays its children'),
    //       ],
    //     ),
    //   ),
    // );
    // --------------------------------------------------------------------------------
    // 一个包含 Expanded/Flexible 的 Column 加到 Column/ListView 会崩
    // 一个 ListView 加到 Column 会崩
    // 解决办法：把内部的东西用 Expanded/Flexible/SizedBox 包起来
    // return Scaffold(
    //   // body: Column(
    //   //   children: [
    //   //     Column(children: [Text("11")]), // 正常
    //   //     // Column(children: [Expanded(child: Text("22"))]), // 要崩。内外层不同则不会崩，外 Column 内 Row / 外 Row 内 Column
    //   //   ],
    //   // ),
    //   // body: Column(
    //   //   children: [
    //   //     ListView(children: [Text("aa"), Text("bb")]), // 要崩。外层换成 Row 也会崩
    //   //   ],
    //   // ),
    //   // body: ListView(
    //   //   children: [
    //   //     Column(children: [Text("aa"), Text("bb")]), // 正常
    //   //     // Column(children: [Expanded(child: Text("11"))]), // 要崩。换成 Row 不会崩
    //   //   ],
    //   // ),
    // );

    return Text("--");
  }
}
