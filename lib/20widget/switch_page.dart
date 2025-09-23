import 'package:flutter/material.dart';

// required bool value
// required ValueChanged<bool>? onChanged

// // thumb 是中间的圆点，track 是滑轨
// Color? activeThumbColor
// Color? activeTrackColor
// Color? inactiveThumbColor
// Color? inactiveTrackColor

// MaterialStateProperty<Icon?>? thumbIcon 加到泡泡上面的图标
// 下面的图片是把泡泡整个换成自己
// ImageProvider<Object>? activeThumbImage
// ImageErrorListener? onActiveThumbImageError
// ImageProvider<Object>? inactiveThumbImage
// ImageErrorListener? onInactiveThumbImageError

// MaterialStateProperty<Color?>? thumbColor
// MaterialStateProperty<Color?>? trackColor
// MaterialStateProperty<Color?>? trackOutlineColor 关闭状态下的边框
// MaterialStateProperty<double?>? trackOutlineWidth
// 原始的控件尺寸是 60*48，有很大的空白区域
// 添大边框会让控件看起来变大一点，不过也只是在空白区域内，超超超大边框也不会改变 60*48

// MaterialStateProperty<Color?>? overlayColor 按下泡泡的时候，泡泡周围有个圈，这个圈的颜色

// EdgeInsetsGeometry? padding 默认 上下0 左右4

// --------------------------------------------------------------------------------

// DragStartBehavior dragStartBehavior = DragStartBehavior.start 没看出有啥区别

// MaterialTapTargetSize? materialTapTargetSize

// MouseCursor? mouseCursor

// double? splashRadius

// ValueChanged<bool>? onFocusChange
// FocusNode? focusNode
// bool autofocus = false
// Color? focusColor
// Color? hoverColor

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  var ok = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Switch')),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: Switch(
              value: ok,
              onChanged: (value) {
                setState(() {
                  ok = value;
                });
              },

              activeThumbColor: Colors.red,
              activeTrackColor: Colors.teal,
              inactiveThumbColor: Colors.green,
              inactiveTrackColor: Colors.purple,
              trackOutlineColor: WidgetStatePropertyAll(Colors.blue),
              // trackOutlineWidth: WidgetStatePropertyAll(30),
              thumbIcon: WidgetStatePropertyAll(Icon(Icons.settings)),

              activeThumbImage: AssetImage("assets/images/bear.png"),

              overlayColor: WidgetStatePropertyAll(Colors.red),
              padding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
