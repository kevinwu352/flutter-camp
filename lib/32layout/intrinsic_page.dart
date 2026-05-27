import 'package:flutter/material.dart';

class IntrinsicPage extends StatelessWidget {
  const IntrinsicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // 原始形态，两个文字各自拥有自己的宽度，Column 的宽度由最宽的文字决定
      // child: Container(
      //   color: Colors.white,
      //   child: Column(
      //     children: [
      //       SizedBox(height: 100),
      //       Container(color: Colors.green, child: Text("title")),
      //       Container(color: Colors.blue, child: Text("long content")),
      //     ],
      //   ),
      // ),

      // 给文字加上 width infinity 以后，因为文字收到的宽度约束是 0-402，所以两个文字都直接撑到屏幕宽了
      // child: Container(
      //   color: Colors.white,
      //   child: Column(
      //     children: [
      //       SizedBox(height: 100),
      //       Container(color: Colors.green, width: double.infinity, child: Text("title")),
      //       Container(color: Colors.blue, width: double.infinity, child: Text("long content")),
      //     ],
      //   ),
      // ),

      // 再用 IntrinsicWidth 包起来，就只会使用两个文字的固有宽度了
      // Container 收到 宽度紧约束，这估计是反复算出来，然后写死的      <= 特别注意
      // 文档说 IntrinsicWidth 很耗性能，能不能则不用
      child: IntrinsicWidth(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(color: Colors.green, width: double.infinity, child: Text("title")),
              Container(color: Colors.blue, width: double.infinity, child: Text("long content")),
            ],
          ),
        ),
      ),
    );
  }
}
