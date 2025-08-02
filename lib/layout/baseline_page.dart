import 'package:flutter/material.dart';

class BaselinePage extends StatelessWidget {
  const BaselinePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Container(
    //     decoration: BoxDecoration(border: Border.all(color: Colors.red)),
    //     height: 400,
    //     child: Baseline(
    //       baseline: 200,
    //       baselineType: TextBaseline.alphabetic,
    //       child: Text("igf"), // 非文字的基线位置是 box 的底部。这里可以是个 Container
    //     ),
    //   ),
    // );

    return Center(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Baseline(
          baseline: 150, // 试试几个值 -10  0  50  100  150
          baselineType: TextBaseline.ideographic,
          child: Container(width: 100, height: 100, color: Colors.blue[200]),
        ),
      ),
    );
  }
}
