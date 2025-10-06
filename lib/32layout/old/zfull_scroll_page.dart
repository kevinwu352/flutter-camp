import 'package:flutter/material.dart';

// 屏幕大的时候，把元素布满整屏
// 屏幕小的时候，能滚动
// 如果用到 Spacer/Expanded，要用 IntrinsicHeight 包起来

class FullScrollPage extends StatelessWidget {
  const FullScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = 280;
    return Scaffold(
      appBar: AppBar(title: Text("Scroll If Needed")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: double.infinity,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.red,
                    height: height,
                    child: Text("11111"),
                  ),
                  Container(
                    color: Colors.green,
                    height: height,
                    child: Text("22222"),
                  ),
                  Container(
                    color: Colors.blue,
                    height: height,
                    child: Text("33333"),
                  ),
                ],
              ),
              // child: IntrinsicHeight(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         color: Colors.red,
              //         height: height,
              //         child: Text("11111"),
              //       ),
              //       Container(
              //         color: Colors.green,
              //         height: height,
              //         child: Text("22222"),
              //       ),
              //       Spacer(),
              //       Expanded(
              //         child: Container(
              //           color: Colors.blue,
              //           height: height,
              //           child: Text("33333"),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
          );
        },
      ),
    );
  }
}
