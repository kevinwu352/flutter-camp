import 'package:flutter/material.dart';

// 位于导航条下面
class Tabbar1Page extends StatelessWidget {
  const Tabbar1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // 也能用 TabController，像 TextController 那样，创建一个实例，传给 TabBar 和 TabBarView
    // 看网上说的：如果要手动切换 tab，就得用 TabController
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TABS"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          children: [Icon(Icons.directions_car), Icon(Icons.directions_transit), Icon(Icons.directions_bike)],
        ),
      ),
    );
  }
}
