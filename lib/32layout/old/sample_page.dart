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

    //*9) 红色占满全屏。ConstrainedBox 只会给子施加比它从父得到的约束更多的约束
    // ***重点关注***
    // 我的理解：
    //   ConstrainedBox 收到紧约束，它自己那个松的附加约束就传不下去，只能往下传紧，所以，Container 收到的是紧约束 402 807
    //   但如果传 BoxConstraints.tight(Size(50, 50)) 也传不下去，难道 50 50 不比 402 807 更紧？
    // return ConstrainedBox(
    //   constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
    //   // constraints: BoxConstraints.tight(Size(50, 50)),
    //   child: Container(color: Colors.red, width: 10, height: 10),
    // );
    // 10) 尺寸是 70*70
    // 我的理解：ConstrainedBox 收到的是松约束，它附加的约束比这松约束紧一点，所以传下去了
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
    // Container 收到的是 70-150，而自己要的尺寸刚好在这区间内
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
    //     child: Container(color: Colors.red, width: 100, height: 100),
    //   ),
    // );

    //*13) 尺寸是 20*50，居中。子收到的是无限约束
    // return UnconstrainedBox(
    //   child: Container(color: Colors.red, width: 20, height: 50),
    // );
    // 14) 显示溢出警告
    // return UnconstrainedBox(
    //   child: Container(color: Colors.red, width: 1000, height: 50),
    // );
    //*15) 没有溢出警告。传infinity就收到的是无限约束，传具体值则收到松约束，传100也不会有溢出警告但尺寸变成100了。溢出的不会被切掉
    // 注意这些约束是向下传的
    // return OverflowBox(
    //   minWidth: 0,
    //   minHeight: 0,
    //   maxWidth: double.infinity,
    //   maxHeight: double.infinity,
    //   // maxWidth: 5000,
    //   // maxHeight: 5000,
    //   child: Container(color: Colors.red, width: 4000, height: 50),
    // );
    //*16) 会崩。父提供无限约束，子真的想要无限，不答应
    // return UnconstrainedBox(
    //   child: Container(color: Colors.red, width: double.infinity, height: 100),
    // );
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
    // LimitedBox 的 100 丢掉了，重点：LimitedBox 只有在收到上面传过来的无限约束时，才会把自己那个值传下去
    // 我感觉：一般用它来做那些想尽量大的控件，这些控件想占多大就多大，但这控件如果在列表等无限的环境下又会接受那个限制参数而变得有限
    // return Center(
    //   child: LimitedBox(
    //     maxWidth: 100,
    //     child: Container(
    //       color: Colors.red,
    //       width: double.infinity,
    //       height: 100,
    //     ),
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
