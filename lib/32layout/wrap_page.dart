import 'package:flutter/material.dart';

// Wrap 能自动换行的 Row/Column，Chip 放里面比较好
// Chip 三个元素的小组件，文字/图标/删除
//   ActionChip 添加 onPress，删除 delete 相关的，相当于两个元素的组件
//   ChoiceChip 增加选中状态，删除 delete 相关的
//   FilterChip 选中时，变宽，前面显示一个勾勾，背景色也变。除了有 delete，没看出和 ChoiceChip 有什么区别
//   InputChip 也有选中状态和删除按钮，允许设置 isEnabled，没看出和 FilterChip 有什么区别

// 尺寸尽量小
// 收到 松100-200 时，传给子的是 0-200 0-inf

// ================================================================================

// Axis direction = Axis.horizontal

// double spacing = 0.0 水平间距
// double runSpacing = 0.0 垂直间距

// 每一行是个 run，这个 run 内部的元素分配空间的策略，横轴
// WrapAlignment alignment = WrapAlignment.start
// 每一行是个 run， 当 run 内部元素高度不一样时，矮元素 靠上/居中/靠下？竖轴
// WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start
// 每一行是个 run，如果 Wrap 高度大于 runs 高度的和，那么这些 runs 分配空间的策略
// WrapAlignment runAlignment = WrapAlignment.start

// VerticalDirection verticalDirection = VerticalDirection.down

// TextDirection? textDirection
// Clip clipBehavior = Clip.none

class WrapPage extends StatelessWidget {
  const WrapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wrap')),
      body: OverflowBox(
        // minWidth: 300,
        // maxWidth: 300,
        // minHeight: 300,
        // maxHeight: 300,
        minWidth: 100,
        maxWidth: 300,
        minHeight: 100,
        maxHeight: 300,
        // minWidth: 0,
        // maxWidth: double.infinity,
        // minHeight: 0,
        // maxHeight: double.infinity,
        child: Container(
          color: Colors.teal,
          child: Wrap(
            // direction: Axis.vertical,
            // alignment: WrapAlignment.spaceEvenly,
            spacing: 10,
            // runSpacing: 10,
            // runAlignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue),
                label: Text('H', style: TextStyle(fontSize: 48)),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue),
                label: Text('Lafayette'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue),
                label: Text('Mulligan'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue),
                label: Text('Laurens'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
