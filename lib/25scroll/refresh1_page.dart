import 'package:flutter/material.dart';

// required Widget child 通常 ListView/CustomScrollView
// required RefreshCallback onRefresh

// RefreshIndicatorTriggerMode triggerMode = RefreshIndicatorTriggerMode.onEdge
//   onEdge 先 scroll 一点点，再往下拉，拉不出来。只有 offset.y = 0 时，往下拉，才能拉出来
//   anywhere 目前滑动位置并未在 0，往下拉，能拉出来
// 感觉用 anywhere 好一点

// Color? color 圈圈的颜色
// Color? backgroundColor 背景的颜色，adaptive-ios 时无效果
// double strokeWidth 圈圈的线宽度，默认 2，adaptive-ios 时无效果

// double edgeOffset = 0.0 默认从导航条的最下面被拉出来，修改后，在导航条下面 100 的位置被拉出来，像是从虚空中拉出来的
// double displacement = 40.0 触发刷新时，圈圈到顶部的距离，使劲拉的时候，圈圈可能会超过这个距离
// 圈圈距离顶部的距离 = edgeOffset + displacement

// ScrollNotificationPredicate notificationPredicate = defaultScrollNotificationPredicate

// --------------------------------------------------------------------------------

// double elevation = 2.0

// String? semanticsLabel
// String? semanticsValue

class Refresh1Page extends StatefulWidget {
  const Refresh1Page({super.key});

  @override
  State<Refresh1Page> createState() => _Refresh1PageState();
}

class _Refresh1PageState extends State<Refresh1Page> {
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        if (loading) {
          print('more: loading:true, ignore');
        } else {
          print('more: loading:true, to load');
        }
        moreData();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final controller = ScrollController();

  List<String> items = List<String>.generate(20, (i) => '0 - $i');
  int order = 0;

  bool loading = false;

  Future<void> refreshData() async {
    if (loading) return;
    loading = true;
    await Future.delayed(Duration(seconds: 3));
    order = 0;
    final list = List<String>.generate(20, (i) => '$order - $i');
    items = list;
    loading = false;
    setState(() {});
  }

  Future<void> moreData() async {
    if (loading) return;
    loading = true;
    await Future.delayed(Duration(seconds: 3));
    order++;
    final list = List<String>.generate(10, (i) => '$order - $i');
    items += list;
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Refresh 1'), backgroundColor: Colors.grey),
      body: RefreshIndicator.adaptive(
        color: Colors.green,
        backgroundColor: Colors.red,
        // edgeOffset: 50,
        // displacement: 100,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: refreshData,
        child: ListView.builder(
          // 在内容少时，本来 ListView 能滑动超过边界
          // 加上 controller 以后，却无法超过边界了，只能再加个 physics
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: controller,
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(title: Text(items[index])),
        ),
      ),
    );
  }
}
