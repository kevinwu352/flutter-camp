import 'package:flutter/material.dart';

// Widget? flexibleSpace 通常传 FlexibleSpaceBar

// double? collapsedHeight
// double? expandedHeight

// bool floating = false
// bool pinned = false
// bool snap = false

// bool stretch = false 滑到最大尺寸以后，继续拉 ScrollView 要不要放大 AppBar
// double stretchTriggerOffset = 100.0 拖动多少才会触发下面的回调
// AsyncCallback? onStretchTrigger

class SliverBarPage extends StatelessWidget {
  const SliverBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("TITLE"),
            // 上拉时，马上压缩 AppBar，然后继续把 AppBar 推出去，再推出内容
            // 下拉时，马上把 AppBar 拉出来，拉到最大，再拉出内容
            floating: false,
            // 上拉时，马上压缩 AppBar，然后固定住，再推出内容
            // 下拉时，先拉内容，再拉高 AppBar
            pinned: false,
            // 上拉一下，停了，一下就弹出去了
            // 下拉一下，停了，一下就弹回来了
            snap: false,
            flexibleSpace: Placeholder(),
            expandedHeight: 200,
          ),
          SliverList.builder(itemBuilder: (context, index) => ListTile(title: Text('Item #$index')), itemCount: 50),
        ],
      ),
    );
  }
}
