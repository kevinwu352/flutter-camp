import 'package:flutter/material.dart';

class IntrinsicPage extends StatelessWidget {
  const IntrinsicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Container(
      //   color: Colors.white,
      //   child: Column(
      //     children: [
      //       Container(
      //         color: Colors.green,
      //         // width: double.infinity,
      //         child: Text("title"),
      //       ),
      //       Container(
      //         color: Colors.blue,
      //         // width: double.infinity, // 本来宽度是由这决定的，加上 width infinity 以后，宽度变成屏幕宽了
      //         child: Text("this content"),
      //       ),
      //     ],
      //   ),
      // ),
      child: IntrinsicWidth(
        // 文档说 IntrinsicWidth 这东西很耗性能
        // 用这包起来，只会把 title 的宽度拉大
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.green,
                width: double.infinity,
                child: Text("title"),
              ),
              Container(
                color: Colors.blue,
                width: double.infinity,
                child: Text("this content"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
