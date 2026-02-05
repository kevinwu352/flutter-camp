import 'package:flutter/material.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 收到 紧300
    //   无子，尺寸随紧
    //   有子，尺寸随紧，但子收到 松0-300
    // 收到 松100-200
    //   无子，尺寸尽量大 200
    //   有子，尺寸尽量大 200，但子收到 松0-200
    // 收到 无限0-inf
    //   无子，尺寸尽量小 0
    //   有子，尺寸随子，子可能非常大，子收到 0-inf
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
      // child: Center(),
      child: Center(child: FlutterLogo(size: 5000)),
    );

    // --------------------------------------------------------------------------------
    // Center 尺寸 = 子尺寸 * factor。但如果 Center 是根，它还是会被强制全屏
    // return Center(widthFactor: 2, child: Text("abc"));
    // return Center(child: Center(widthFactor: 2, heightFactor: 2, child: Text("abc")));

    // --------------------------------------------------------------------------------
    // Center 收到紧约束
    // ConstrainedBox 收到松约束，与自己附加的合并，传给子紧约束
    // Card 收到紧约束
    // Text 收到紧约束，不过要小一些
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints.expand(),
    //     child: Card(child: Text('Hello World!')),
    //   ),
    // );
  }
}
