import 'package:flutter/material.dart';

// CheckboxListTile / RadioListTile / SwitchListTile

// ExpansionTile 能打开/关闭细节内容的 ListTile

// ================================================================================

// Widget? leading
// Widget? title 自己确保 title 只有一行
// Widget? subtitle 自己确保 subtitle 只有一行，isThreeLine 为真则另说
// Widget? trailing

// TextStyle? titleTextStyle
// TextStyle? subtitleTextStyle
// TextStyle? leadingAndTrailingTextStyle

// bool? isThreeLine 是不是 2 行由 sustitle 决定，是不是 3 行由 subtitle 的行数决定
// bool? dense 高度会变矮一点，title 和 subtitle 间距是 0，只是 label 高度变了

// bool enabled = true 会影响样式，元素会变灰，以下俩回调也失效
// GestureTapCallback? onTap
// GestureLongPressCallback? onLongPress

// bool selected = false
// Color? tileColor 背景色
// Color? selectedTileColor 背景色
// Color? selectedColor 如果 selected 为真，此颜色覆盖下面俩个
// Color? iconColor 前后图标的颜色
// Color? textColor 前中后文字的颜色

// double? minTileHeight 最小高度，默认 一行56 二行72 三行88，如果 dense，则 48 64 76
// EdgeInsetsGeometry? contentPadding 额外的 padding，而不是修改默认的。默认左右 20 上下 0
// double? horizontalTitleGap 文字左右距前后，默认 16。前边距离严格等于此值，但后边为何最小 8？
// double? minVerticalPadding 中间文字上边和下边的最小边距
// double? minLeadingWidth 不是前边的宽度，而是给前边留多宽，前边不一定会把宽度用光

// 前后两块如何与中间对齐
//   top/center/bottom 假设中间文字比较高，那么前边的图标就 上对齐/居中/下对齐
//   threeLine 如果 isThreeLine 则 top，否则 center
//   titleHeight
//     h>72 前距上 = 后距上 = 16
//     h=72 前距上 = 16 后居中
//     h<72 前后都居中
// ListTileTitleAlignment? titleAlignment

// ShapeBorder? shape 边框 Border.all()

// ListTileStyle? style 决定 title 的字体，两个类型 list 和 drawer，没感觉有什么不一样

// --------------------------------------------------------------------------------

// MouseCursor? mouseCursor
// FocusNode? focusNode
// bool autofocus = false
// ValueChanged<bool>? onFocusChange
// Color? focusColor
// Color? hoverColor
// Color? splashColor

// MaterialStatesController? statesController

// VisualDensity? visualDensity

// bool? enableFeedback

// bool internalAddSemanticForOnTap = true

class ListTilePage extends StatelessWidget {
  const ListTilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Tile')),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               leading: Icon(Icons.settings),
          //               title: Text('It is the'),
          //               subtitle: Text('It is the responsi'),
          //               trailing: Icon(Icons.run_circle),
          //
          //               // enabled: false,
          //               tileColor: Colors.amber,
          //               selectedTileColor: Colors.green,
          //               selectedColor: Colors.brown,
          //               iconColor: Colors.teal,
          //               textColor: Colors.purple,
          //               selected: false,
          //             ),
          //           ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('It is the'),
            // subtitle: Text('It is the responsi'),
            // subtitle: Text('True if this widget will be selected as the initial focus when no other node in'),
            trailing: Icon(Icons.run_circle),

            // dense: true,
            titleAlignment: ListTileTitleAlignment.center,
            // isThreeLine: true,

            // enabled: false,
            // tileColor: Colors.amber,
            // selectedTileColor: Colors.green,
            // selectedColor: Colors.brown,
            // iconColor: Colors.teal,
            // textColor: Colors.purple,
            // selected: false,

            // shape: Border.all(color: Colors.green, width: 1),

            // contentPadding: EdgeInsets.all(40),
            // horizontalTitleGap: 0,
            // minVerticalPadding: 15,
            // minLeadingWidth: 50,
            // titleTextStyle: TextStyle(color: Colors.green),
            // style: ListTileStyle.drawer,
          ),

          ListTile(title: Text('ListTile with red background'), tileColor: Colors.red),
        ],
      ),
    );
  }
}
