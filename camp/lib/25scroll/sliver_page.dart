import 'package:flutter/material.dart';

// SliverList
// SliverFixedExtentList 固定高度的列表，通过 itemExtent
// SliverPrototypeExtentList 固定高度的列表，通过 prototypeItem
// SliverVariedExtentList
//
// SliverGrid
//
// SliverChildListDelegate 接受一个 children 列表，一次性创建所有子元素，将此列表的元素提供给 sliver
// SliverChildBuilderDelegate 接受一个 builder 方法，需要的时候再构造元素，再将元素提供给 sliver

// SliverPadding
// SliverToBoxAdapter 将 box 组件包装一下，使之成为 sliver
// SliverPersistentHeader
//   会停留在顶部的条，本来是为了实现 SliverAppBar 而造的，目前能拿来通用
//   它的参数 SliverPersistentHeaderDelegate 是个抽象类，我们得手动写个实际类，可以参照书上写一个通用的类
//
// SliverFillViewport 就是 PageView
// SliverFillRemaining
//   填充 Viewport 的剩余空间，通常是最后一个元素。通过实验我发现如果 Viewport 空间被占完了，它只占用它自身该有的空间

// SliverOpacity
// DecoratedSliver 增加装饰，通常用 BoxDecoration

// ================================================================================

// 文档说 NestedScrollView 最常见的用法是，顶部用 SliverAppBar 和 TabBar，下面用 TabBarView
// 但它的动机初衷那段没看明白，他到底为了解决一个什么样的问题呢？看 nestscroll1/nestscroll2

// 使用 NestedScrollView 时，向上滑，把 header 完全推出屏幕，然后用手稍微向下拉一点点，这样 header 就完全弹回来了
// 这样会盖住前面几行，NestedScrollView 文档的第一个例子就是解决方案，头部用 SliverOverlapAbsorber 包起来，子增加一个 SliverOverlapInjector
// 但我感觉这解决方案也就那样，不过，书上说这是标准解决方案，直接抄就行

class SliverPage extends StatelessWidget {
  const SliverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sliver')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      // 两个 ListView 各滚各的，而且还需要 Expanded 包起来
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: 20,
      //         itemBuilder: (context, index) => ListTile(title: Text('aaa $index')),
      //       ),
      //     ),
      //     Divider(color: Colors.grey),
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: 20,
      //         itemBuilder: (context, index) => ListTile(title: Text('bbb $index')),
      //       ),
      //     ),
      //   ],
      // ),
      // 两个 Sliver 拼在一起，且连在一起滚动
      // body: CustomScrollView(
      //   slivers: [
      //     SliverFixedExtentList.builder(
      //       itemCount: 20,
      //       itemBuilder: (context, index) => ListTile(title: Text('aaa $index')),
      //       itemExtent: 56,
      //     ),
      //     SliverFixedExtentList.builder(
      //       itemCount: 20,
      //       itemBuilder: (context, index) => ListTile(title: Text('bbb $index')),
      //       itemExtent: 56,
      //     ),
      //   ],
      // ),
      // 演示如何将 box 转换成 sliver
      // body: CustomScrollView(
      //   slivers: [
      //     SliverToBoxAdapter(
      //       // PageView 的滑动方向和 CustomScrollView 不同，所以它俩不冲突
      //       // 如果换成垂直的，内外的滑动就不相干了
      //       child: SizedBox(
      //         height: 300,
      //         child: PageView(scrollDirection: Axis.vertical, children: [Text("1"), Text("2")]),
      //       ),
      //     ),
      //     SliverFixedExtentList.builder(
      //       itemCount: 20,
      //       itemBuilder: (context, index) => ListTile(title: Text('aaa $index')),
      //       itemExtent: 56,
      //     ),
      //   ],
      // ),
      // 演示如何使用分区条，注意第一个条并未被第二个条给顶出边界去
      // body: CustomScrollView(
      //   slivers: [
      //     SliverPersistentHeader(delegate: SliverHeaderDelegate(minExtent: 40, maxExtent: 120), pinned: true),
      //     SliverFixedExtentList.builder(
      //       itemCount: 20,
      //       itemBuilder: (context, index) => ListTile(title: Text('aaa $index')),
      //       itemExtent: 56,
      //     ),
      //     SliverPersistentHeader(delegate: SliverHeaderDelegate(minExtent: 60, maxExtent: 60), pinned: true),
      //     SliverFixedExtentList.builder(
      //       itemCount: 20,
      //       itemBuilder: (context, index) => ListTile(title: Text('aaa $index')),
      //       itemExtent: 56,
      //     ),
      //   ],
      // ),
    );
  }

  // 来自书上的例子，演示 NestedScrollView，它的文档中还有另外一个更加完善的例子
  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     child: NestedScrollView(
  //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //         // 返回一个 Sliver 数组给外部可滚动组件
  //         return [
  //           SliverAppBar(
  //             title: const Text('嵌套ListView'),
  //             pinned: true, // 固定在顶部
  //             forceElevated: innerBoxIsScrolled,
  //           ),
  //           SliverList.builder(itemCount: 5, itemBuilder: (context, index) => ListTile(title: Text('data $index'))),
  //         ];
  //       },
  //       body: ListView.builder(
  //         padding: const EdgeInsets.all(8),
  //         physics: const ClampingScrollPhysics(), //重要
  //         itemCount: 30,
  //         itemBuilder: (BuildContext context, int index) {
  //           return SizedBox(height: 50, child: Center(child: Text('Item $index')));
  //         },
  //       ),
  //     ),
  //   );
  // }

  // 注意这个根不是 Scaffold
  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     child: CustomScrollView(
  //       slivers: [
  //         SliverAppBar(
  //           pinned: true,
  //           expandedHeight: 250.0,
  //           stretch: true,
  //           flexibleSpace: FlexibleSpaceBar(
  //             title: const Text('Demo'),
  //             background: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
  //           ),
  //         ),
  //         SliverPadding(
  //           padding: const EdgeInsets.all(8.0),
  //           sliver: SliverGrid(
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2,
  //               mainAxisSpacing: 10.0,
  //               crossAxisSpacing: 10.0,
  //               childAspectRatio: 4.0,
  //             ),
  //             delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
  //               return Container(
  //                 alignment: Alignment.center,
  //                 color: Colors.cyan[100 * (index % 9)],
  //                 child: Text('grid item $index'),
  //               );
  //             }, childCount: 20),
  //           ),
  //         ),
  //         SliverFixedExtentList(
  //           itemExtent: 50.0,
  //           delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
  //             return Container(
  //               alignment: Alignment.center,
  //               color: Colors.lightBlue[100 * (index % 9)],
  //               child: Text('list item $index'),
  //             );
  //           }, childCount: 20),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegate({required this.minExtent, required this.maxExtent});
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.teal, alignment: Alignment.centerLeft, child: Text('data'));
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}
