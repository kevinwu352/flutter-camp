import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Center
    // 如果有 factor 参数，子尺寸 * factor。但如果是根还是会被拉满屏幕
    // return Center(widthFactor: 2, child: Text("abc"));
    // return Center(child: Center(widthFactor: 2, child: Text("abc"))); // 不是根 factor 起作用了
    // 如果无 factor 参数
    //   如果有限定，尺寸是尽量大
    // return Center(child: Text("abc")); // 屏幕就是它的限定吧？
    //   如果无限定，和它的子一样大
    // 目前不知如何写例子？

    // Align
    // Alignment: 原点在父中心，右下是正方向
    // (1, 1) 把子放在右下贴边，但 1 并不是最下最右的坐标
    // 总公式：i = 2x / (fw-cw) - 1, fw=father-width, cw=child-width, x=UIView.x
    // 正方向外部贴边公式：x = 2fw / (fw-cw) - 1, (50, 50) => 2.4285
    // 负方向外部贴边公式：x = -2cw / (fw - cw) - 1, (50, 50) => -2.4285
    // return Center(
    //   child: Container(
    //     height: 120.0,
    //     width: 120.0,
    //     color: Colors.blue[50],
    //     child: Align(
    //       alignment: Alignment(-2.4285, 2.4285),
    //       child: Container(width: 50, height: 50, color: Colors.amber),
    //     ),
    //   ),
    // );
    // FractionalOffset: 原点在左上角，右下是正方向
    // (1, 1) 把子放在右下贴边，但 1 并不是最下最右的坐标
    // 总公式：i = x / (fw - cw), fw=father-width, cw=child-width, x=UIView.x
    // 正方向外部贴边公式：x = fw / (fw - cw), 50 => 1.7142
    // 负方向外部贴边公式：x = -cw / (fw - cw), 50 => -0.7142
    // return Center(
    //   child: Container(
    //     height: 120.0,
    //     width: 120.0,
    //     color: Colors.blue[50],
    //     child: Align(
    //       alignment: FractionalOffset(-0.7142, 0),
    //       child: Container(width: 50, height: 50, color: Colors.amber),
    //     ),
    //   ),
    // );

    // Container
    // Widget? child
    // Color? color 背景色，如果要渐变或图片用 decoration，用 decoration 这里必须置空
    // double? width
    // double? height
    // EdgeInsetsGeometry? padding
    // EdgeInsetsGeometry? margin

    // AlignmentGeometry? alignment

    // Decoration? decoration
    // Decoration? foregroundDecoration

    // BoxConstraints? constraints

    // Matrix4? transform
    // AlignmentGeometry? transformAlignment

    // Clip clipBehavior = Clip.none

    // to honor alignment
    // to size itself to the child
    // to honor the width, height, and constraints
    // to expand to fit the parent
    // to be as small as possible

    // If the widget has no child, no height, no width, no constraints, and the parent provides unbounded constraints, then Container tries to size as small as possible.
    // If the widget has no child and no alignment, but a height, width, or constraints are provided, then the Container tries to be as small as possible given the combination of those constraints and the parent's constraints.
    // If the widget has no child, no height, no width, no constraints, and no alignment, but the parent provides bounded constraints, then Container expands to fit the constraints provided by the parent.
    // If the widget has an alignment, and the parent provides unbounded constraints, then the Container tries to size itself around the child.
    // If the widget has an alignment, and the parent provides bounded constraints, then the Container tries to expand to fit the parent, and then positions the child within itself as per the alignment.

    // a) 无子 无宽高约束 父给无限约束，尽量小
    // return Center(child: Container(color: Colors.red)); // Center 给子有限约束
    // return UnconstrainedBox(child: Container(color: Colors.red)); // UnconstrainedBox 给子无限约束
    // b) 无子 无对准 有宽高约束，和父给的约束一起决定，尽量小
    return Center(child: Container(color: Colors.red, width: 100, height: 100));
    // return Center(
    //   child: Container(
    //     color: Colors.red,
    //     // constraints: BoxConstraints.tight(Size(50, 50)),
    //     // constraints: BoxConstraints.expand(width: 50, height: 50), // 有值是紧约束，该是 50
    //     // constraints: BoxConstraints.expand(), // 无值是紧无限，真的撑满屏了
    //     constraints: BoxConstraints.loose(Size(50, 50)), // 0-50 松，不应该是 0 吗？
    //     // constraints: BoxConstraints.tightFor(), // 0-inf 松，不应该是 0 吗？
    //   ),
    // );
    // c) 无子 无宽高约束 无对准 父给约束，适配父的约束
    // d) 有对准 父给无限约束，和子一样大
    // e) 有对准 父给有限约束，扩大适配父，子找位置对准
    // return Center(
    //   child: Container(
    //     alignment: Alignment.topRight,
    //     width: 300,
    //     color: Colors.green,
    //     child: Text("abc"),
    //   ),
    // );

    // return Text("data");
  }
}
