import 'package:flutter/material.dart';

// TextStyle? textStyle 里面颜色不起作用，但字号有用

// Color? foregroundColor
// Color? disabledForegroundColor
// ButtonLayerBuilder? foregroundBuilder 高级功能
// Color? overlayColor splash 颜色 和 高亮背景颜色。如果为空，从 foreground 生成一个。如果是 Colors.transparent，高亮状态/splash 都没了

// Color? backgroundColor
// Color? disabledBackgroundColor
// ButtonLayerBuilder? backgroundBuilder

// Color? iconColor
// Color? disabledIconColor
// double? iconSize
// IconAlignment? iconAlignment 图标在 前/后

// EdgeInsetsGeometry? padding 这不会造成内部空间
// Size? minimumSize 设置大小后，内部可能会存在空间，alignment 就有作用了
// Size? fixedSize
// Size? maximumSize
// AlignmentGeometry? alignment

// ================================================================================

// double? elevation 这仨在一起才有效果，后面再研究
// Color? shadowColor
// Color? surfaceTintColor

// BorderSide? side
// OutlinedBorder? shape

// ================================================================================

// Duration? animationDuration

// VisualDensity? visualDensity
// MaterialTapTargetSize? tapTargetSize

// bool? enableFeedback

// InteractiveInkFeatureFactory? splashFactory

// MouseCursor? enabledMouseCursor
// MouseCursor? disabledMouseCursor

class TextButtonPage extends StatelessWidget {
  const TextButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Button')),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ...
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              textStyle: TextStyle(color: Colors.purple, fontSize: 24),
              // elevation: 5,
              // shadowColor: Colors.blue,
              // surfaceTintColor: Colors.green,
              // shape: OutlinedBorder
            ),
            child: Text('data'),
          ),

          TextButton.icon(
            onPressed: null,
            style: TextButton.styleFrom(
              iconColor: Colors.teal,
              disabledIconColor: Colors.amber,
              iconSize: 50,
              iconAlignment: IconAlignment.end,
            ),
            icon: const Icon(Icons.access_alarm),
            label: const Text('Alarm'),
          ),

          // ================================================================================
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.access_alarm),
            label: const Text('TextButton.icon #1'),
          ),

          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.red, backgroundColor: Colors.yellow),
            onPressed: () {},
            icon: const Icon(Icons.access_alarm),
            label: const Text('TextButton.icon #2'),
          ),

          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: Colors.green, width: 1),
              ),
            ),
            onPressed: () {},
            child: const Text('TextButton #3'),
          ),

          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {},
            child: const Text('TextButton #4'),
          ),
        ],
      ),
    );
  }
}
