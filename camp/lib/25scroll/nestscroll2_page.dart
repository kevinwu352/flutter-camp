import 'package:flutter/material.dart';

// 这里也有个问题：
// 切换 tab 时，上次滑动的位置丢失了

class Nestscroll2Page extends StatelessWidget {
  const Nestscroll2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app bar'), backgroundColor: Colors.grey),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(child: Container(width: 402, height: 150, color: Colors.red)),
              SliverPersistentHeader(delegate: _SliverTabBarDelegate(tabs: ['Grid', 'List']), pinned: true),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: 20,
                itemBuilder: (context, index) => Container(color: Colors.amber, child: Text('grid $index')),
              ),
              ListView.builder(itemCount: 20, itemBuilder: (context, index) => ListTile(title: Text('list $index'))),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverTabBarDelegate({required this.tabs});
  final List<String> tabs;

  @override
  double get minExtent => 40;

  @override
  double get maxExtent => 40;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return ColoredBox(
      color: Colors.green,
      child: TabBar(tabs: tabs.map((e) => Tab(text: e)).toList()),
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return tabs != oldDelegate.tabs;
  }
}
