import 'package:flutter/material.dart';

// 这里呈现的问题是：
// CustomScrollView 内部嵌套了 TabBar，里面是 GridView/ListView
// 手指放到下面，拖动 GridView/ListView 时，只有内部在滑动
// 手指放到上面，拖动顶部时，上下一起滑动
// 很诡异
//
// 这就是 NestedScrollView 所要解决的问题

class Nestscroll1Page extends StatelessWidget {
  const Nestscroll1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app bar'), backgroundColor: Colors.grey),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Container(width: 402, height: 150, color: Colors.red)),
            SliverPersistentHeader(delegate: _SliverTabBarDelegate(tabs: ['Grid', 'List']), pinned: true),
            SliverFillRemaining(
              child: TabBarView(
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
                  ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(title: Text('list $index')),
                  ),
                ],
              ),
            ),
          ],
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
