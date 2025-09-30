import 'package:flutter/material.dart';
import '/core/core.dart';

// .builder
// 通过两个 delegate 实现下面的 count/extent 功能
// SliverGridDelegateWithFixedCrossAxisCount/SliverGridDelegateWithMaxCrossAxisExtent
// int? itemCount
// required NullableIndexedWidgetBuilder itemBuilder
// required SliverGridDelegate gridDelegate

// .count
// 固定每行的 个数/间距，算出每个的宽度
// required int crossAxisCount
// double crossAxisSpacing = 0.0
// double mainAxisSpacing = 0.0
// double childAspectRatio = 1.0
// List<Widget> children = const <Widget>[]

// .extent
// 固定每行的 间距/最大宽度，算出每个的最佳宽度
// 它是先算出每行的最佳个数，再算出每个的最佳宽度，然后就算个数不足一行，也用这个宽度
// required double maxCrossAxisExtent
// double crossAxisSpacing = 0.0
// double mainAxisSpacing = 0.0
// double childAspectRatio = 1.0
// List<Widget> children = const <Widget>[]

class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grid')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),

      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 15),
        itemCount: 3,
        itemBuilder: (context, index) => Container(color: ColorsExt.rand()),
      ),

      // body: GridView.count(
      //   crossAxisCount: 5,
      //   crossAxisSpacing: 15,
      //   children: [
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //   ],
      // ),

      // body: GridView.extent(
      //   maxCrossAxisExtent: 100,
      //   crossAxisSpacing: 30,
      //   mainAxisSpacing: 10,
      //   childAspectRatio: 2,
      //   children: [
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     Container(color: ColorsExt.rand()),
      //     // Container(color: ColorsExt.rand()),
      //     // Container(color: ColorsExt.rand()),
      //     // Container(color: ColorsExt.rand()),
      //     // Container(color: ColorsExt.rand()),
      //     // Container(color: ColorsExt.rand()),
      //   ],
      // ),
    );
  }
}
