import 'package:flutter/material.dart';

// Container 在顶层就撑满屏幕，加上 Center 则放松约束
// Center-Container，有约束就用约束，无限则满屏，无子也满屏
// Center-Container，有子随子，但如果 Container 有宽高向下传递的是紧约束 (7)

// ConstrainedBox 向下传比收到的更严格的约束。所以它顶层时收到全屏紧约束，它自己的松就会被忽略掉，继续向下传紧 (9)

// UnconstrainedBox 向下传无限约束，子小无所谓，子太大会有溢出警告，子无限会崩 (13)(14)(16)
// UnconstrainedBox-LimitedBox 如果 LimitedBox 收到无限约束才起效 (17)
// OverflowBox 那一堆约束参数是往下传的，溢出不警告，也不会被切 (15)

// FittedBox 在顶层时，缩放它的内容。内容如果无限会崩
// Center-FittedBox 内容大会缩小，不拉大
// Center-长文字 会换行

// Row 给 Expanded 紧约束，给 Flexible 松约束。所以，F 的子 <= F，E 的子 == E。它俩都忽略子的尺寸

// 注意 Scaffold 不强制全屏，它向下传递的是松约束
// 注意 SizedBox 向下传紧约束

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ================================================================================
    // Center-Container 时，子想要无限或有限都行，最终都不能超过屏幕
    // ================================================================================
    // 1) 屏幕强制它占满
    // return Container(color: Colors.red);
    // 2) 虽然自己要求 100*100 的尺寸，但屏幕强制它占满
    // return Container(width: 100, height: 100, color: Colors.red);
    // 3) Center 占满屏幕，它要求子尺寸不超过屏幕即可
    // return Center(child: Container(width: 100, height: 100, color: Colors.red));
    // 4) Align 是 Center 的父类，子类也能自由决定自己的尺寸
    // return Align(
    //   alignment: Alignment.centerRight,
    //   child: Container(width: 100, height: 100, color: Colors.red),
    // );
    //*5) Center 占满屏幕，子想要无限或有限，都不能超过父。它尽量大
    // 例 3 是有限，这里是无限，例 6 是不给子
    // return Center(
    //   child: Container(width: double.infinity, height: double.infinity, color: Colors.red),
    // );
    //*6) Center 占满屏幕，Container 无子无尺寸，它决定占尽量大
    // return Center(child: Container(color: Colors.red));
    //*7) Center 占满屏幕，红色有子，跟随子的尺寸
    // ***重点关注***
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
    // ConstrainedBox
    // 只会给子施加比它从父得到的约束更严的约束，如何理解这句话？
    //   1)如果父给的是 100 紧约束，因为子必须严格遵守父的约束，所以就算自己的附加约束是 50 紧约束，这 50 虽然更严格，但传不下去
    //   2)如果父给的是松约束，就把父给的和自己附加的取交集，然后传给子
    //     注意，这俩有交集还好，如果无交集，以父的为准，不超过父的区间。为什么以父的为准？因为子必须遵守父的约束
    //     如果自己区间整体小于父区间，那么向下传紧约束，值是父的最小
    //     如果自己区间整体大于父区间，那么向下传紧约束，值是父的最大
    //     不管自己是紧或松，都是有区间的，紧的区间上下限相同罢了
    // 记住：子必须遵守父的约束，父都给紧约束了，没有任何商量的余地了，附加约束再怎么也不管用。只有父给松约束时，下面才有可操作空间。像是皇帝下命令
    // ================================================================================
    //*9) 红色占满全屏
    // ConstrainedBox 收到紧约束，它自己那个松的附加约束就传不下去，只能往下传紧，所以，Container 收到的是紧约束 402 807
    // return ConstrainedBox(
    //   constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
    //   // constraints: BoxConstraints.tight(Size(50, 50)),
    //   child: Container(color: Colors.red, width: 10, height: 10),
    // );
    //*10) 尺寸是 70*70
    // ConstrainedBox 收到松约束，注意子收到的并不是 constraints 参数的约束，而是这俩约束的交集
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
    //     child: Container(color: Colors.red, width: 10, height: 10),
    //   ),
    // );
    // 11) 尺寸是 150*150
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
    //     child: Container(color: Colors.red, width: 1000, height: 1000),
    //   ),
    // );
    // 12) 尺寸是 100*100
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
    //     child: Container(color: Colors.red, width: 100, height: 100),
    //   ),
    // );

    // ================================================================================
    // UnconstrainedBox
    //   alignment 当子尺寸小的时候定位用
    //   constrainedAxis 这个轴的尺寸固定为父给的尺寸。子想要高 50，不加此参数时，子收到的是无限，加上此参数后，子收到的是紧约束 874
    // 传递给子的是无限约束，相当于告诉子，你自由发挥，想多大就多大
    // 但 UnconstrainedBox 自己肯定是个有限框，所以，它拿到子自由决定的期望尺寸，然后在自己的框内布局
    //   如果子要的尺寸小，没问题，并且用 alignment 来布局
    //   如果子要的尺寸大，显示溢出警告
    //   如果子想要无限大，那就崩溃吧
    // 像极了父母给孩子的承诺
    // ================================================================================
    //*13) 尺寸是 20*50，居中。子收到的是无限约束
    // return UnconstrainedBox(
    //   // constrainedAxis: Axis.vertical,
    //   child: Container(color: Colors.red, width: 20, height: 50),
    // );
    // 14) 显示溢出警告
    // return UnconstrainedBox(child: Container(color: Colors.red, width: 1000, height: 50));
    //*16) 会崩。父提供无限约束，子真的想要无限，不答应
    // return UnconstrainedBox(
    //   child: Container(color: Colors.red, width: double.infinity, height: 100),
    // );

    // ================================================================================
    // OverflowBox
    //   alignment 子小或大都受此参数影响，上面 UnconstrainedBox 的子只能小于等于父，OverflowBox 的子可以大于父
    //   fit 当子尺寸小的时候，deferToChild 使 OverflowBox 在约束范围内尽量和子一样小，max 使 OverflowBox 在约束范围内尽量和父一样大
    // 参数里的约束是传给子的，子一定会遵守这些约束，子想要多大就多大
    // 子的内容超过边界不会被切掉
    // ================================================================================
    //*15) 没有溢出警告
    // 下例中，子想要 4000 宽度，最终子就是 4000，它不会被压缩，没有溢出警告，只是屏幕窄了挡住了它
    // return OverflowBox(
    //   minWidth: 20,
    //   minHeight: 20,
    //   maxWidth: double.infinity,
    //   maxHeight: double.infinity,
    //   // child: Container(color: Colors.red, width: 4000, height: 50),
    //   // alignment: Alignment.centerLeft,
    //   fit: OverflowBoxFit.max,
    //   child: FlutterLogo(size: 1000),
    // );

    // ================================================================================
    // LimitedBox
    //   当收到无限约束时，把自己参数那个约束传下去
    //   当收到有限约束时，把收到的约束传下去，自己参数就忽略掉
    // ================================================================================
    //*17) 尺寸是 100*100
    // UnconstrainedBox 收到紧，LimitedBox 收到无限约束，它传给 Container 的是松约束 0-100
    // return UnconstrainedBox(
    //   child: LimitedBox(
    //     maxWidth: 100,
    //     child: Container(color: Colors.red, width: double.infinity, height: 100),
    //   ),
    // );
    // 尺寸是 402*100
    // Center 收到紧约束 402，LimitedBox 收到松约束 0-402，Container 收到松约束 0-402
    // return Center(
    //   child: LimitedBox(
    //     maxWidth: 100,
    //     child: Container(color: Colors.red, width: double.infinity, height: 100),
    //   ),
    // );

    //*18) Text 收到无限约束，让它能随意大小，但最后 FittedBox 缩放它。变大变小
    // return FittedBox(child: Text('god is a girl god is a girl god is a girl'));
    // 19) Text 收到无限约束，文字少不拉大，文字多会缩小。只会变小
    // return Center(child: FittedBox(child: Text('123')));
    // 20) 文字太长会缩小
    //*21) 长文字直接放 Center 会换行，放 FittedBox 会缩小
    // return Center(
    //   child: Text('This is some very very very large text that is too big to fit a regular screen in a single line.'),
    // );
    //*22) 会崩。它只会缩放 非无限 的控件
    // return FittedBox(
    //   child: Container(height: 20, width: double.infinity, color: Colors.red),
    // );

    // 23) Row 限高不限宽。Container 收到 0-inf 0-874，Text 也是
    // return Row(
    //   children: [
    //     Container(
    //       color: Colors.red,
    //       child: Text('Hello!', style: TextStyle(fontSize: 20)),
    //     ),
    //     Container(
    //       color: Colors.green,
    //       child: Text('Goodbye!', style: TextStyle(fontSize: 20)),
    //     ),
    //   ],
    // );
    // 24) 内容太长会显示溢出警告
    // 25) 用 Expanded 包起来以后，这个子的尺寸不重要了，其它子先布局，剩下的空间才是它的
    // Expanded 收到 300.4紧 0-874松，Container 也是，Text 也是
    // 例子中为何要用 Center 包起来？感觉要不要效果一样
    // return Row(
    //   children: [
    //     Expanded(
    //       child: Container(
    //         color: Colors.red,
    //         child: Text(
    //           'This is a very long text that won\'t fit the line.',
    //           style: TextStyle(fontSize: 20),
    //         ),
    //       ),
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
    //         child: Text(
    //           'This is a very long text that won\'t fit the line.',
    //           style: TextStyle(fontSize: 20),
    //         ),
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
    //*27) Flexible 收到 0-201 0-874，Container 也是，Text 也是
    // 可见，Row 给 Expanded 紧约束，给 Flexible 松约束。结果就是，F 的子 <= F，E 的子 == E。它俩都忽略子的尺寸
    // return Row(
    //   children: [
    //     Flexible(
    //       child: Container(
    //         color: Colors.red,
    //         child: Text(
    //           'This is a very long text that won\'t fit the line.',
    //           style: TextStyle(fontSize: 20),
    //         ),
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

    //*28) Column 占据屏幕左侧部分空间
    // 注意 Scaffold 不强制全屏，它向下传递的是松约束
    // Container 收到松约束 0-402 0-874，Column 也是，Text 限宽不限高
    // return Scaffold(
    //   body: Container(
    //     color: Colors.blue,
    //     child: Column(children: [Text('Hello!'), Text('Goodbye!')]),
    //   ),
    // );
    //*29)
    // 注意 SizedBox 向下传紧约束
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
