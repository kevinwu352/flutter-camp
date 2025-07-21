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
    return Center(
      child: Container(
        height: 120.0,
        width: 120.0,
        color: Colors.blue[50],
        child: Align(
          alignment: Alignment(-2.4285, 2.4285),
          child: Container(width: 50, height: 50, color: Colors.amber),
        ),
      ),
    );
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
  }
}
