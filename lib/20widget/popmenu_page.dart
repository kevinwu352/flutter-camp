import 'package:flutter/material.dart';

// showMenu 这个方法也能显示

// PopupMenuEntry -> PopupMenuItem
// PopupMenuDivider

// ================================================================================

// Widget? child 菜单弹出前，这个按钮显示的内容
// Widget? icon 这里的 child 和 icon 只能设其一
// double? iconSize
// Color? iconColor

// T? initialValue
// required PopupMenuItemBuilder<T> itemBuilder
// PopupMenuItemSelected<T>? onSelected
// VoidCallback? onOpened
// PopupMenuCanceled? onCanceled

// PopupMenuPosition? position over 菜单左上角 对准 按钮左上角，under 菜单左上角 对准 按钮左下角
// Offset offset = Offset.zero 菜单的偏移，默认在左上角，遮挡住原控件

// EdgeInsetsGeometry padding = const EdgeInsets.all(8.0) 按钮的
// EdgeInsetsGeometry? menuPadding 菜单的
// BoxConstraints? constraints 菜单的

// Color? color 菜单的背景色
// ShapeBorder? shape 菜单的边框

// ButtonStyle? style 按钮的

// double? elevation 都是菜单的
// Color? shadowColor
// Color? surfaceTintColor

// --------------------------------------------------------------------------------

// bool enabled = true

// Clip clipBehavior = Clip.none

// AnimationStyle? popUpAnimationStyle 覆盖默认的动画吧，以后再说

// String? tooltip
// bool? enableFeedback

// bool? requestFocus 菜单显示时要不要请求焦点，有啥用？

// BorderRadius? borderRadius 包裹 child 的 InkWell 的圆角，看不见，估计用的少
// double? splashRadius

// bool useRootNavigator = false 没懂？
// RouteSettings? routeSettings 没懂？

class PopmenuPage extends StatefulWidget {
  const PopmenuPage({super.key});

  @override
  State<PopmenuPage> createState() => _PopmenuPageState();
}

class _PopmenuPageState extends State<PopmenuPage> {
  SampleItem? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popup Menu')),
      body: Center(
        child: PopupMenuButton<SampleItem>(
          initialValue: selectedItem,
          onSelected: (SampleItem item) {
            setState(() {
              selectedItem = item;
            });
          },

          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem<SampleItem>(value: SampleItem.itemOne, child: Text('Item 1')),
            const PopupMenuItem<SampleItem>(value: SampleItem.itemTwo, child: Text('Item 2')),
            const PopupMenuItem<SampleItem>(value: SampleItem.itemThree, child: Text('Item 3')),
          ],

          onOpened: () => print('111'),
          onCanceled: () => print('222'),

          // child: Text('data'),
          icon: Icon(Icons.settings),

          // enabled: false,
          // // iconColor: Colors.teal,
          // iconSize: 60,
          // color: Colors.green,
          offset: Offset.zero,
          position: PopupMenuPosition.under,

          // borderRadius: BorderRadius.all(Radius.circular(20)),
          splashRadius: 20,

          // shape: Border.all(color: Colors.red, width: 5),
          // padding: EdgeInsets.all(20),
          // menuPadding: EdgeInsets.all(40),
          // constraints: BoxConstraints(minWidth: 300),
          style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.red)),

          elevation: 5,
          shadowColor: Colors.brown,
          surfaceTintColor: Colors.green,
          color: Colors.amber,
        ),
      ),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }
