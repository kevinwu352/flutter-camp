import 'package:flutter/material.dart';

// PreferredSizeWidget? appBar
// Widget? body
// Color? backgroundColor

// Widget? bottomNavigationBar
// Widget? bottomSheet 底部显示一个内容，一直显示，据说 push 后也在
// List<Widget>? persistentFooterButtons 底部显示一堆按钮，有何用呢
// AlignmentDirectional persistentFooterAlignment = AlignmentDirectional.centerEnd

// Widget? floatingActionButton
// FloatingActionButtonLocation? floatingActionButtonLocation
// FloatingActionButtonAnimator? floatingActionButtonAnimator

// Widget? drawer
// DrawerCallback? onDrawerChanged   抽屉打开和关闭时调用
// Widget? endDrawer 位于右侧的抽屉
// DrawerCallback? onEndDrawerChanged
// DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start 不清楚？
// Color? drawerScrimColor 抽屉弹出后，后面的背景内容颜色
// double? drawerEdgeDragWidth
// bool drawerEnableOpenDragGesture = true
// bool endDrawerEnableOpenDragGesture = true

// bool primary = true

// bool extendBody = false
// bool extendBodyBehindAppBar = false
// bool? resizeToAvoidBottomInset

// String? restorationId

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(title: Text("TITLE")),
      body: Text("abc"),
      drawer: Drawer(
        child: SafeArea(child: Column(children: [Text("data"), Text("data")])),
      ),
      onDrawerChanged: (isOpened) {
        print("open: $isOpened");
      },
      bottomSheet: Text("god is a girl"),
      persistentFooterButtons: [
        ElevatedButton(onPressed: () {}, child: Text("data1")),
        ElevatedButton(onPressed: () {}, child: Text("data2")),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (value) {},
        selectedItemColor: Colors.red,
      ),
    );
  }
}
