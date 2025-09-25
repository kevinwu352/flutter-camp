import 'package:flutter/material.dart';

// NavigationBar 位于页面底部，就是 iOS 的 TabBar

// int selectedIndex = 0
// required List<Widget> destinations
// ValueChanged<int>? onDestinationSelected

// Duration? animationDuration 选中时的动画时间

// double? height

// Color? backgroundColor

// double? elevation
// Color? shadowColor
// Color? surfaceTintColor

// Color? indicatorColor 选中时那个泡泡的颜色，还能是透明
// ShapeBorder? indicatorShape

// NavigationDestinationLabelBehavior? labelBehavior 决定何时显示图标下面的文字
// MaterialStateProperty<TextStyle?>? labelTextStyle
// EdgeInsetsGeometry? labelPadding

// MaterialStateProperty<Color?>? overlayColor 点击时候的波纹颜色

// bool maintainBottomViewPadding = false 没懂

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        // animationDuration: Duration(seconds: 5),
        // backgroundColor: Colors.green,
        // indicatorColor: Colors.transparent,
        // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        // indicatorShape: RoundedRectangleBorder(
        //   side: BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),
        // overlayColor: WidgetStatePropertyAll(Colors.purple),
        onDestinationSelected: (value) => setState(() => index = value),
        selectedIndex: index,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: [TabHomeScreen(), TabProfileScreen()][index],
    );
  }
}

class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("home"));
  }
}

class TabProfileScreen extends StatelessWidget {
  const TabProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("profile"));
  }
}
