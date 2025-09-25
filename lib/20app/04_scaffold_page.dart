import 'package:flutter/material.dart';

// 是否位于屏幕顶部，会自动处理状态栏高度，并调整 AppBar 的高度
// bool primary = true

// PreferredSizeWidget? appBar 参数类型是拥有固有尺寸的控件
// Widget? body
// Color? backgroundColor

// 一般传 BottomAppBar，可以用 Row 显示一堆按钮，靠左。还能嵌入一个 FAB
// 还能传 NavigationBar / BottomNavigationBar，就是 iOS 的 TabBar。而 BottomNavigationBar 是旧组件，不要用了
// Widget? bottomNavigationBar

// --------------------------------------------------------------------------------

// 底部显示一个内容，位于 TabBar 上面，一直显示，据说 push 后也在
// 这是非模态的，相当于 showBottomSheet 方法，另外还有 showModalBottomSheet 方法
// Widget? bottomSheet

// 最上面显示 bottomSheet，中间显示 persistentFooterButtons，最下面是 bottomNavigationBar
// List<Widget>? persistentFooterButtons
// AlignmentDirectional persistentFooterAlignment = AlignmentDirectional.centerEnd
// BoxDecoration? persistentFooterDecoration

// Widget? floatingActionButton
// FloatingActionButtonLocation? floatingActionButtonLocation
// FloatingActionButtonAnimator? floatingActionButtonAnimator

// Widget? drawer
// DrawerCallback? onDrawerChanged 打开/关闭
// Widget? endDrawer
// DrawerCallback? onEndDrawerChanged
// DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start 没懂？
// Color? drawerScrimColor 遮罩颜色
// bool drawerBarrierDismissible = true 点遮罩触发关闭
// double? drawerEdgeDragWidth 在此宽度内向右拖才会触发抽屉的打开
// bool drawerEnableOpenDragGesture = true 能不能用拖动的方式打开
// bool endDrawerEnableOpenDragGesture = true

// 背景色是延伸到顶部和底部条条后面的，但内容没有
// bool extendBody = false 如果没开启，内容高度超过底部条条就会报溢出错误，开启后内容能伸到条条背后，但伸出屏幕也会报溢出错误
// bool extendBodyBehindAppBar = false 和上面一样的功能，决定内容是否会延伸到条条背后

// --------------------------------------------------------------------------------

// bool? resizeToAvoidBottomInset 键盘弹出的时候压缩 body，以后再研究

// Widget? bottomSheetScrimBuilder(BuildContext, Animation<double>) = _defaultBottomSheetScrimBuilder 没懂？

// String? restorationId

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  int screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('Scaffold'), backgroundColor: Colors.red.withValues(alpha: 0.2)),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        children: [
          TextField(),
          Container(color: Colors.red, width: 100, height: 100),
          Container(color: Colors.green, width: 100, height: 100),
          Container(color: Colors.blue, width: 100, height: 100),
          Container(color: Colors.yellow, width: 100, height: 100),
          Container(color: Colors.brown, width: 100, height: 100),
          Container(color: Colors.yellow, width: 100, height: 100),
        ],
      ),

      extendBody: true,
      extendBodyBehindAppBar: false,

      bottomNavigationBar: BottomAppBar(color: Colors.red.withValues(alpha: 0.2), child: Text('data')),
      bottomSheet: Row(children: [Text('asdf')]),

      persistentFooterButtons: [
        ElevatedButton(onPressed: () {}, child: Text("data1")),
        ElevatedButton(onPressed: () {}, child: Text("data2")),
      ],
      persistentFooterAlignment: AlignmentDirectional.bottomStart,
      persistentFooterDecoration: BoxDecoration(color: Colors.green),

      drawer: Drawer(
        child: SafeArea(child: Column(children: [Text("111"), Text("222")])),
      ),
      onDrawerChanged: (isOpened) {
        print("open: $isOpened");
      },
      // drawerScrimColor: Colors.red,
      drawerBarrierDismissible: true,
      drawerEdgeDragWidth: 50,

      endDrawer: NavigationDrawer(
        onDestinationSelected: (value) => setState(() {
          screenIndex = value;
        }),
        selectedIndex: screenIndex,

        indicatorColor: Colors.green,
        indicatorShape: RoundedRectangleBorder(
          // side: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(4),
        ), //Border.all(color: Colors.red),

        backgroundColor: Colors.grey,
        header: Text('header'), // 这俩的位置不随着内容滚动
        footer: Text('footer'),
        children: [
          Container(padding: EdgeInsets.fromLTRB(28, 16, 16, 10), child: Text('section')),
          ...destinations.map((destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          }),
          Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
        ],
      ),

      // resizeToAvoidBottomInset: true,
      // bottomSheetScrimBuilder: (_, _) {
      //   return Text('adsfas');
      // },
    );
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination('Messages', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  ExampleDestination('Profile', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  ExampleDestination('Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
];

// ================================================================================

// NavigationRail 的用法

// Row(
//   children: <Widget>[
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: NavigationRail(
//         minWidth: 50,
//         destinations: destinations.map((ExampleDestination destination) {
//           return NavigationRailDestination(
//             label: Text(destination.label),
//             icon: destination.icon,
//             selectedIcon: destination.selectedIcon,
//           );
//         }).toList(),
//         selectedIndex: screenIndex,
//         useIndicator: true,
//         onDestinationSelected: (int index) {
//           setState(() {
//             screenIndex = index;
//           });
//         },
//       ),
//     ),
//     const VerticalDivider(thickness: 1, width: 1),
//     Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Text('Page Index = $screenIndex'),
//           ElevatedButton(onPressed: openDrawer, child: const Text('Open Drawer')),
//         ],
//       ),
//     ),
//   ],
// )
