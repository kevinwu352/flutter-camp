import 'package:flutter/material.dart';

// SliverAppBar
// Widget? flexibleSpace 通常传 FlexibleSpaceBar
// double? collapsedHeight
// double? expandedHeight
// bool floating = false
// bool pinned = false
// bool snap = false
// bool stretch = false 滑到最大尺寸以后，继续拉 ScrollView 要不要放大 AppBar
// double stretchTriggerOffset = 100.0 拖动多少才会触发下面的回调
// AsyncCallback? onStretchTrigger

// ================================================================================

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
// SliverPersistentHeader
// SliverToBoxAdapter
//
// SliverFillViewport 就是 PageView
// SliverFillRemaining
//   填充 Viewport 的剩余空间，通常是最后一个元素。通过实验我发现如果 Viewport 空间被占完了，它只占用它自身该有的空间

class SliverPage extends StatelessWidget {
  const SliverPage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Sliver')),
  //     floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
  //     // 两个 ListView 各滚各的，而且还需要 Expanded 包起来
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: 20,
  //             itemBuilder: (context, index) => ListTile(title: Text('aaa $index')),
  //           ),
  //         ),
  //         Divider(color: Colors.grey),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: 20,
  //             itemBuilder: (context, index) => ListTile(title: Text('bbb $index')),
  //           ),
  //         ),
  //       ],
  //     ),
  //     // 两个 Sliver 拼在一起，且连在一起滚动
  //     body: CustomScrollView(
  //       slivers: [
  //         SliverFixedExtentList.builder(
  //           itemCount: 20,
  //           itemBuilder: (context, index) => ListTile(title: Text('aaa $index')),
  //           itemExtent: 56,
  //         ),
  //         SliverFixedExtentList.builder(
  //           itemCount: 20,
  //           itemBuilder: (context, index) => ListTile(title: Text('bbb $index')),
  //           itemExtent: 56,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // 注意这个根不是 Scaffold
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              }, childCount: 20),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}
