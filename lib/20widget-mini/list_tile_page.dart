import 'package:flutter/material.dart';

// Widget? leading
// Widget? title 自己确保 title 只有一行
// Widget? subtitle 自己确保 subtitle 只有一行，isThreeLine 为真则另说
// Widget? trailing
//
// bool? isThreeLine 是不是 2 行由 sustitle 决定，是不是 3 行由 subtitle 的行数决定
// bool? dense 高度会变矮一点，title 和 subtitle 间距是 0，上下边距 8，只是 label 高度变了

// bool enabled = true 会影响样式，元素会变灰，以下俩回调也失效
// GestureTapCallback? onTap
// GestureLongPressCallback? onLongPress

// bool selected = false
// Color? tileColor 背景色
// Color? selectedTileColor 背景色
// Color? selectedColor 如果 selected 为真，此颜色覆盖下面俩个
// Color? iconColor 前后图标的颜色
// Color? textColor 前中后文字的颜色

// ShapeBorder? shape 边框 Border.all()

// --------------------------------------------------------------------------------

// ListTileStyle? style

// TextStyle? titleTextStyle
// TextStyle? subtitleTextStyle
// TextStyle? leadingAndTrailingTextStyle

// EdgeInsetsGeometry? contentPadding
// double? horizontalTitleGap
// double? minVerticalPadding
// double? minLeadingWidth
// double? minTileHeight
// ListTileTitleAlignment? titleAlignment

// MaterialStatesController? statesController

// --------------------------------------------------------------------------------

// MouseCursor? mouseCursor
// FocusNode? focusNode
// bool autofocus = false
// ValueChanged<bool>? onFocusChange
// Color? focusColor
// Color? hoverColor
// Color? splashColor

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
            subtitle: Text('It is the responsi'),
            trailing: Icon(Icons.run_circle),

            // enabled: false,
            tileColor: Colors.amber,
            selectedTileColor: Colors.green,
            selectedColor: Colors.brown,
            iconColor: Colors.teal,
            textColor: Colors.purple,
            selected: false,

            shape: Border.all(color: Colors.green, width: 1),
          ),

          ListTile(title: Text('ListTile with red background'), tileColor: Colors.red),
        ],
      ),
    );
  }
}
