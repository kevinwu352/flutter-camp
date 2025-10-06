import 'package:flutter/material.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 无子时
    //   收到紧约束，尺寸固定
    //   收到有限约束，尺寸尽量大
    //   收到无限约束，尺寸尽量小
    // 有子时
    //   收到紧约束，尺寸固定，给子松约束 0-200
    //   收到 松100-200，最终尺寸 200，但子收到的是 0-200
    //   收到无限约束，子也会收到无限约束，最终尺寸和子一样大，有没有溢出警告主要是看自己外面用的是哪种盒子 UnconstrainedBox/OverflowBox
    //
    // 总结：占用约束允许的最大空间，并在空间内将子定位到中心，因为是 Align 的子类，所以特性非常接近
    return OverflowBox(
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
      child: Center(child: FlutterLogo(size: 5000)),
    );

    // --------------------------------------------------------------------------------
    // Center 尺寸 = 子尺寸 * factor。但如果 Center 是根，它还是会被强制全屏
    // return Center(widthFactor: 2, child: Text("abc"));
    // return Center(child: Center(widthFactor: 2, heightFactor: 2, child: Text("abc")));
  }
}
