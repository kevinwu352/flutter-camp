import 'package:flutter/material.dart';

class SampleBoxPage extends StatelessWidget {
  const SampleBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    //
    // 收到 紧300
    //   无子，尺寸随紧
    //   有子，尺寸随紧，子收到 紧300
    // 收到 松100-200
    //   无子，尺寸尽量小，合并后的约束取下限       <= 注意这里，尺寸是收紧
    //   有子，尺寸随子，子收到合并后的约束         <= 也算是收紧
    // 收到 无限0-inf
    //   无子，尺寸尽量小，合并后的约束取下限
    //   有子，尺寸随子，子收到合并后的约束
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
    //   clipBehavior 子又不能像 OverflowBox 一样超出边界，你切个屁啊？
    // 传递给子的是无限约束，相当于告诉子，你自由发挥，想多大就多大
    // 但 UnconstrainedBox 自己肯定是个有限框，所以，它拿到子自由决定的期望尺寸，然后在自己的框内布局
    //   如果子要的尺寸小，没问题，并且用 alignment 来布局
    //   如果子要的尺寸大，显示溢出警告
    //   如果子想要无限大，那就崩溃吧
    // 像极了父母给孩子的承诺
    //
    // 不管 UnconstrainedBox 收到什么约束，它的子肯定收到无限约束
    // 收到 紧300
    //   无子，尺寸随紧
    //   有子，尺寸随紧
    // 收到 松100-200
    //   无子，尺寸尽量小 100
    //   有子，尺寸尽量小 100
    // 收到 无限0-inf
    //   无子，尺寸尽量小 0
    //   有子，尺寸随子，子可能非常大
    // ================================================================================
    //*13) 尺寸是 20*50，居中。子收到的是无限约束
    // return UnconstrainedBox(
    //   // constrainedAxis: Axis.vertical,
    //   child: Container(color: Colors.red, width: 20, height: 50),
    // );
    // 14) 显示溢出警告
    // return UnconstrainedBox(child: Container(color: Colors.red, width: 1000, height: 50));
    // 16) 会崩。父提供无限约束，子真的想要无限，不答应
    // return UnconstrainedBox(
    //   child: Container(color: Colors.red, width: double.infinity, height: 100),
    // );

    // ================================================================================
    // OverflowBox
    //   alignment 子小或大都受此参数影响，上面 UnconstrainedBox 的子只能小于等于父，OverflowBox 的子可以大于父
    //   fit 当子尺寸小的时候，deferToChild 使 OverflowBox 在约束范围内尽量和子一样小，max 使 OverflowBox 在约束范围内尽量和父一样大
    // 参数里的约束是传给子的，子一定会遵守这些约束，子想要多大就多大
    // 子的内容超过边界不会被切掉
    //
    // 总的来说，尺寸是尽量大，随父
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
    //
    // 总的来说，尺寸是尽量小，随子
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

    // ================================================================================
    // FittedBox
    //   fit 和图片那边的 fit 功能一模一样
    //   alignment
    //   clipBehavior
    // 传递给子的是无限约束，让子自由发挥。但如果子真的要无限，则崩溃，比如 container.width = double.infinity
    // 默认是完全包含子控件，并保持比例地拉伸子控件，拉大压小
    // 不管是拉大还是压小，眼睛看到的文字是变大变小了，但鼠标点上去看到的尺寸还是原来的
    //
    // 总的来说，尺寸是尽量小，随子
    //
    // 长文字直接放 Center 会换行，放 FittedBox 会压小
    // ================================================================================
    //*18) FittedBox 收到紧约束，文字收到无限约束
    // 文字少就将文字拉大
    // 文字多就将文字压小
    // return FittedBox(
    //   child: Text('this is some very very very large text that is too big'),
    //   // child: Text('asdf'),
    // );
    // 19) FittedBox 收到松约束，文字收到无限约束
    // 文字少不会拉大，因为 Center 不会强行拉大它的子 FittedBox
    // 文字多就会压小，因为 Center 的子不能超过上限
    // return Center(child: FittedBox(child: Text('123')));
    // 20) 文字太长会缩小
    // ...
    //
    //*21) 长文字直接放 Center 会换行，放 FittedBox 会压小
    // return Center(
    //   child: Text('this is some very very very large text that is too big to fit a regular screen in a single line'),
    // );
    //
    //*22) 会崩。它只会缩放 非无限 的控件
    // return FittedBox(
    //   child: Container(height: 20, width: double.infinity, color: Colors.red),
    // );

    // ********************************************************************************

    // ================================================================================
    // SizedBox
    // 总结：将子固定为某尺寸，自己是收紧类型的
    //
    // 收到 紧300
    //   无子，尺寸随紧
    //   有子，尺寸随紧，子收到 紧300
    //     w/h 无影响
    // 收到 松100-200
    //   无子，尺寸尽量小 100
    //   有子，尺寸尽量小 100，子收到 松100-200
    //     w/h 传给子紧，w/h 如果超过 100-200，子收到的就是 紧100/紧200
    // 收到 无限0-inf
    //   无子，尺寸尽量小 0
    //   有子，尺寸随子，子可能非常大，子收到 0-inf
    //     w/h 传给子紧
    // ================================================================================

    // ================================================================================
    // SizedOverflowBox
    // 自己的尺寸由父给约束和 size 参数共同决定。                           <= 这就是一个 SizedBox
    // 然后将父给约束透传给子，子尺寸可能会大，但没有溢出警告，也不会被切。 <= 这就是一个 OverflowBox
    // 如果子尺寸和父不相同，能用 alignment 给子定位
    //
    // 收到 紧300
    //   无子，尺寸随紧
    //   有子，尺寸随紧，子收到 紧300
    //     w/h 无影响
    // 收到 松100-200
    //   无子，尺寸：如果 size 在父给约束范围内则用，否则用父给约束的下限或上限
    //   有子，尺寸：同上。子收到 松100-200
    // 收到 无限0-inf
    //   无子，尺寸是 size
    //   有子，尺寸是 size，子收到 0-inf
    // ================================================================================

    // ================================================================================
    // FractionallySizedBox
    // 总结：把父给的约束上限乘以比例，传递紧约束给子，自己在父给的约束范围内尽量贴近子
    //
    // alignment 自己肯定必须遵守父给的约束，然后用比例算出的子尺寸可能小于自己，此时就需要定位子
    //
    // 收到 紧300
    //   无子，尺寸随紧
    //   有子，尺寸随紧，子收到 紧300
    //     w/h 会给子紧，值是 300*w / 300*h
    // 收到 松100-200
    //   无子，尺寸尽量小 100
    //   有子，尺寸尽量小 100，子收到 松100-200
    //     w/h 会给子紧，值是 200*w / 200*h
    // 收到 无限0-inf
    //   无子，尺寸尽量小 0
    //   有子，尺寸随子，子可能非常大，子收到 0-inf
    //     w/h 会崩
    // ================================================================================

    // ================================================================================
    // AspectRatio
    // 先取收到约束的最大宽，算出高
    // 如果最大宽是无限，则取最大高，算出宽
    // 然后检查算出的尺寸是否符合约束，如果不符合就重算并把约束考虑进去
    // 如果最终无法找到合适的尺寸，遵守约束而不遵守比例
    //
    // 松约束时，按照上面的规则计算尺寸，传递给子的是紧约束
    // 无限约束会异常，有子无子都异常
    //
    // 总的来说，它的尺寸是随父，就算子是小尺寸的 Text/SizedBox 也是随父，且子会被拉大
    // ================================================================================
    // return Scaffold(
    //   body: OverflowBox(
    //     // minWidth: 300,
    //     // maxWidth: 300,
    //     // minHeight: 300,
    //     // maxHeight: 300,
    //     minWidth: 100,
    //     maxWidth: 200,
    //     minHeight: 100,
    //     maxHeight: 200,
    //     // minWidth: 0,
    //     // maxWidth: double.infinity,
    //     // minHeight: 0,
    //     // maxHeight: double.infinity,
    //     // child: AspectRatio(aspectRatio: 0.5, child: SizedBox(width: 50, height: 50)),
    //     child: AspectRatio(aspectRatio: 0.5, child: Text('a')),
    //   ),
    // );

    return Text("--");
  }
}
