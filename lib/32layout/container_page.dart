import 'package:flutter/material.dart';

// 总结：
//   有子随子，有对准时将约束放松
//   无子随父，父无限时尺寸是 0
//
// Container 是个大杂烩，它里面用各种其它控件来实现功能，比如 Padding/Align/ConstrainedBox

// --------------------------------------------------------------------------------

// Color? color 背景色，如果要渐变或图片用 decoration，用 decoration 这里必须置空
// Decoration? decoration
// Decoration? foregroundDecoration 这俩是分别位于 child 前后的装饰，设个前景色还能把 child 挡住

// width/height 在构造器里根据规则给 constraints 赋值
//   如果 width/height/constraints 有值，则用 width/height 与 constraints 结合，生成一个紧约束，主要看 width/height 位于 constraints 的左/中/右
//   如果 width/height 有值，直接生成一个紧约束
// double? width
// double? height
// 源码里面把 child 加到 ConstrainedBox 中，并用此参数作为附加约束
// BoxConstraints? constraints

// 源码里面把 child 加到 Align 中
// AlignmentGeometry? alignment

// EdgeInsetsGeometry? padding
// EdgeInsetsGeometry? margin 相邻两视图的 margin 不会融合到一起

// Matrix4? transform
// AlignmentGeometry? transformAlignment

// Clip clipBehavior = Clip.none

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 无子
    //   收到紧约束
    //   收到有限约束，尺寸尽量大   <= 无子随父，是指尽量撑到父那么大，说父也不对，应该是撑到父给的最大约束那么大，尽量大
    //   收到无限约束，尺寸尽量小
    // 有子，子很小
    //   收到紧约束
    //   收到有限约束，尺寸尽量小   <= 有子随子，这里是因为子很小，所以用了约束的下限，尽量小
    //   收到无限约束，尺寸随子
    // 有子，子很大
    //   收到紧约束
    //   收到有限约束，尺寸尽量大   <= 有子随子，这里是因为子很大，所以用了约束的上限，尽量大
    //   收到无限约束，尺寸随子
    return OverflowBox(
      minWidth: 300,
      maxWidth: 300,
      minHeight: 300,
      maxHeight: 300,
      // minWidth: 100,
      // maxWidth: 200,
      // minHeight: 100,
      // maxHeight: 200,
      // minWidth: 0,
      // maxWidth: double.infinity,
      // minHeight: 0,
      // maxHeight: double.infinity,
      child: Container(color: Colors.teal, child: FlutterLogo(size: 5000)),
    );
  }
}
