import 'package:flutter/material.dart';

// 位于页面底部
class Tabbar2Page extends StatefulWidget {
  const Tabbar2Page({super.key});

  @override
  State<Tabbar2Page> createState() => _Tabbar2PageState();
}

class _Tabbar2PageState extends State<Tabbar2Page> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
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
