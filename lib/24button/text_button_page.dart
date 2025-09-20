import 'package:flutter/material.dart';

// statesController 咋用？文档里有个例子

// ================================================================================

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

// 这个控件的海拔，假设屏幕是地面，这个值是离屏幕的海拔
// 阴影在右下，下多一点。值越小则阴影越 实 明显，值越大阴影越 散 虚
// double? elevation
// Color? shadowColor 阴影颜色
// Color? surfaceTintColor M3 引入了一种新的方式来突显海拔，在背景前面蒙一层淡淡的颜色。AppBar 那边，如果设置纯绿色，会有一点淡淡的绿色在背景上
// 单独设置海拔无阴影（下面 Material 单独设置海拔就有阴影），加上背景色也不行。海拔和阴影颜色必须同时设置，且显示出来的阴影是胶囊形状的
// 另外 surfaceTintColor 真的在按钮背景的上面蒙了一层淡淡的颜色，海拔和它必须同时设置
//
//   Material(
//     elevation: 20.0,
//     // shadowColor: Colors.red,
//     surfaceTintColor: Colors.red,
//     child: Container(width: 100, height: 100, color: Colors.blue, child: Center(child: Text('Elevated'))),
//   )

// ================================================================================

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
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Material(
          //   elevation: 20.0,
          //   // shadowColor: Colors.red,
          //   surfaceTintColor: Colors.red,
          //   child: Container(
          //     width: 100,
          //     height: 100,
          //     color: Colors.blue,
          //     child: Center(child: Text('Elevated')),
          //   ),
          // ),
          // TextButton(
          //   onPressed: () {},
          //   style: TextButton.styleFrom(
          //     foregroundColor: Colors.red,
          //     // backgroundColor: Colors.amber,
          //     textStyle: TextStyle(color: Colors.purple, fontSize: 24),
          //     elevation: 10,
          //     // shadowColor: Colors.blue,
          //     surfaceTintColor: Colors.green,
          //     // shape: OutlinedBorder
          //   ),
          //   child: Text('data'),
          // ),

          // TextButton.icon(
          //   onPressed: null,
          //   style: TextButton.styleFrom(
          //     iconColor: Colors.teal,
          //     disabledIconColor: Colors.amber,
          //     iconSize: 50,
          //     iconAlignment: IconAlignment.end,
          //   ),
          //   icon: const Icon(Icons.access_alarm),
          //   label: const Text('Alarm'),
          // ),
          ElevatedButton(
            // style: ButtonStyle(
            //   // 按下时调用闭包，states 包含 .pressed，如果返回值则用，如果返回 null 则用原来的默认值
            //   // backgroundColor: WidgetStateProperty.resolveWith(
            //   //   (states) => states.contains(WidgetState.pressed) ? Colors.green : null,
            //   // ),
            //   backgroundColor: WidgetStateProperty.resolveAs(value, states),
            // ),
            child: const Text('Fly me to the moon'),
            onPressed: () {},
          ),

          ElevatedButton(
            style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.green)),
            child: const Text('Let me play among the stars 1'),
            onPressed: () {},
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Let me play among the stars 2'),
            onPressed: () {},
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
