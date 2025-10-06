import 'package:flutter/material.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Center

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
    // return Center(
    //   child: Container(
    //     decoration: BoxDecoration(
    //       shape: BoxShape.rectangle,
    //       color: Colors.green,
    //     ),
    //     // padding: EdgeInsets.symmetric(vertical: 50),
    //     // transform: Matrix4.rotationZ(3.14 / 4),
    //     child: Text("abc"),
    //   ),
    // );

    return Text("data");
  }
}
