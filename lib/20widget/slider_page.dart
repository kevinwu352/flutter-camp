import 'package:flutter/material.dart';

// RangeSlider

// 默认高度 48，修改上下14左右24的 padding
// 实测，设为 .zero 后，严格贴边的

// ================================================================================

// required double value
// double? secondaryTrackValue 像在线视频播放进度条一样，这里是加载进度，value 大于此的时候，看不到这个进度

// required ValueChanged<double>? onChanged
// ValueChanged<double>? onChangeStart
// ValueChanged<double>? onChangeEnd

// double min = 0.0
// double max = 1.0
// int? divisions 分成几段

// String? label 拖动的时候才能看到

// Color? activeColor 左边 track 的颜色
// Color? inactiveColor 右边 track 的颜色
// Color? secondaryActiveColor

// Color? thumbColor 泡泡的颜色
// MaterialStateProperty<Color?>? overlayColor 泡泡点下去以后，有个圈，这个圈的颜色

// SliderInteraction? allowedInteraction 能不能拖 能不能点

// EdgeInsetsGeometry? padding 默认 上下14 左右24

// --------------------------------------------------------------------------------

// MouseCursor? mouseCursor

// SemanticFormatterCallback? semanticFormatterCallback

// FocusNode? focusNode
// bool autofocus = false

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double val = 0.2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slider')),
      body: Column(
        children: [
          // ...
          Slider(
            value: val,
            secondaryTrackValue: 0.4,
            secondaryActiveColor: Colors.red,
            // onChangeStart: (value) => print('111 $value'),
            // onChangeEnd: (value) => print('222 $value'),
            onChanged: (value) {
              print(value);
              setState(() {
                val = value;
              });
            },

            // divisions: 4,
            // min: 0.1,
            // max: 2.0,
            label: 'v:$val',

            activeColor: Colors.amber,
            inactiveColor: Colors.green,
            thumbColor: Colors.blue,
            overlayColor: WidgetStatePropertyAll(Colors.brown),

            allowedInteraction: SliderInteraction.slideThumb,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
