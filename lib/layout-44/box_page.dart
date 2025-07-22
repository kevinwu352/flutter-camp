import 'package:flutter/material.dart';

class BoxPage extends StatelessWidget {
  const BoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: ConstrainedBox(
    //     constraints: const BoxConstraints(
    //       maxWidth: 200,
    //     ), // 让文字换行，如果文字只有 150 宽，实际也会是 150
    //     child: Text("god is a girl"),
    //   ),
    // );

    // return Center(
    //   child: ConstrainedBox(
    //     constraints: const BoxConstraints(minHeight: 100), // 增加按钮高度
    //     child: Container(color: Colors.green, child: Text("god is a girl")),
    //   ),
    // );

    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints.expand(),
    //     child: Card(child: Text('Hello World!')),
    //   ),
    // );

    return Text("data");
  }
}
