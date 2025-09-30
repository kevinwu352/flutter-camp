import 'package:flutter/material.dart';
import '/core/core.dart';

// .builder
// int? itemCount
// required NullableIndexedWidgetBuilder itemBuilder
// bool pageSnapping = true 拖动结束后要不要停在整个页面结束处
// bool padEnds = true 当单页宽度比例小于 0 时，在最前最后添加 padding，以确保每个页面拖动结束后居中
// ValueChanged<int>? onPageChanged
//
// bool allowImplicitScrolling = false 给 Accessibility 用的

// PageController.viewportFraction 单个页面的宽度占据视窗多少比例

// ==========

class PagePage extends StatefulWidget {
  const PagePage({super.key});

  @override
  State<PagePage> createState() => _PagePageState();
}

class _PagePageState extends State<PagePage> {
  final pc = PageController(viewportFraction: 0.6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: PageView.builder(
        controller: pc,
        pageSnapping: false,
        padEnds: true,
        itemCount: 3,
        itemBuilder: (context, index) => Container(color: ColorsExt.rand()),
      ),
    );
  }
}

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: ColorsExt.rand());
  }
}
