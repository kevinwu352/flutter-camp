import 'package:flutter/material.dart';

// Align
// 无子时
//   收到紧约束，最终尺寸当然是紧了
//   收到 松100-200，最终尺寸 200
//   收到无限约束，最终尺寸尽量小，因为无子，所以是 0
// 有子时
//   收到紧约束，最终尺寸当然是紧了，但子收到的是 0-200
//   收到 松100-200，最终尺寸 200，但子收到的是 0-200
//   收到无限约束，子也会收到无限约束，最终尺寸和子一样大，有没有溢出警告主要是看自己外面用的是哪种盒子 UnconstrainedBox/OverflowBox
//
// 自己不会有溢出警告
// 如果自己收到有限约束，子也会收到有限约束，子会严格遵守那个约束，只要遵守了就不会超出边界，也就不会溢出了
// 如果自己收到无限约束，子也会收到无限约束，自己的尺寸会和子一样大，这时关键看自己外面的盒子会不会溢出，反正自己是不会溢出的
//
// 总结：占用约束允许的最大空间，并在空间内将子定位到某处

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

class AlignPage extends StatelessWidget {
  const AlignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basic')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: OverflowBox(
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
        child: Align(alignment: Alignment.center, child: FlutterLogo(size: 5000)),
      ),
    );
  }
}
