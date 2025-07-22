import 'dart:math';

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
    // 简单总结：有子随子，有对准时将约束放松；无子随父，父无限时尺寸是 0
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

    // a) 无子 无对准 无宽高约束，父给有限约束则尽量大，父给无限约束则尽量小
    // return Center(child: Container(color: Colors.red)); // Center 给子有限约束
    // return UnconstrainedBox(child: Container(color: Colors.red)); // UnconstrainedBox 给子无限约束
    // b) 无子 无对准 有宽高约束，和父给的约束一起决定，尽量小
    // return Center(child: Container(color: Colors.red, width: 100, height: 100));
    // return Center(
    //   child: Container(
    //     color: Colors.red,
    //     // constraints: BoxConstraints.tight(Size(50, 50)),
    //     // constraints: BoxConstraints.expand(width: 50, height: 50), // 有值是紧约束，该是 50
    //     // constraints: BoxConstraints.expand(), // 无值是紧无限，真的撑满屏了
    //     // constraints: BoxConstraints.loose(Size(50, 50)), // 0-50 松，尺寸 50，不应该是 0 吗？
    //     // constraints: BoxConstraints.tightFor(), // 0-inf 松，尺寸撑满，不应该是 0 吗？
    //   ),
    // );
    // return Center(
    //   child: Container(
    //     color: Colors.red,
    //     width: 200,
    //     height: 200,
    //     // constraints: BoxConstraints.tight(Size(50, 50)), // 优先级高于宽高
    //     // constraints: BoxConstraints.expand(), // 优先级高于宽高
    //     // constraints: BoxConstraints.loose(Size(50, 50)), // 优先级高于宽高，尺寸 50
    //     // constraints: BoxConstraints.tightFor(), // 0-inf 松，尺寸 200
    //   ),
    // );
    // c) 有子 有对准 父给有限约束，扩大适配父，子找位置对准
    // return Center(
    //   child: Container(
    //     alignment: Alignment.centerRight,
    //     color: Colors.red,
    //     child: Text("abc"),
    //   ),
    // );
    // d) 有子 有对准 父给无限约束，缩小适配子
    // return UnconstrainedBox(
    //   child: Container(
    //     alignment: Alignment.centerRight,
    //     color: Colors.red,
    //     child: Text("abc"),
    //   ),
    // );
    // 其它修饰
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.green,
        ),
        // padding: EdgeInsets.symmetric(vertical: 50),
        // transform: Matrix4.rotationZ(pi / 4),
        child: Text("abc"),
      ),
    );

    // return Text("data");
  }
}
