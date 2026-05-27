import 'package:flutter/material.dart';
import '/core/core.dart';

// PageView 没有缓存功能，滑出屏幕的页面会销毁
// allowImplicitScrolling 能帮助缓存前后一页，但更前更后的就不行了
// 最佳缓存方案要用 AutomaticKeepAliveClientMixin，见下例

// ================================================================================

// .builder
// int? itemCount
// required NullableIndexedWidgetBuilder itemBuilder
// bool pageSnapping = true 拖动结束后要不要停在整个页面结束处
// bool padEnds = true 当单页宽度比例小于 0 时，在最前最后添加 padding，以确保每个页面拖动结束后居中
// ValueChanged<int>? onPageChanged
//
// bool allowImplicitScrolling = false 给 Accessibility 用的

// PageController.viewportFraction 单个页面的宽度占据视窗多少比例

class PagePage extends StatefulWidget {
  const PagePage({super.key});

  @override
  State<PagePage> createState() => _PagePageState();
}

class _PagePageState extends State<PagePage> {
  final pc = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: PageView.builder(
        // controller: pc,
        // pageSnapping: false,
        // padEnds: true,
        itemCount: 5,
        // itemBuilder: (context, index) => Container(color: ColorsExt.rand()),
        itemBuilder: (context, index) => SubPage(name: '$index'),
        allowImplicitScrolling: true,
      ),
    );
  }
}

class SubPage extends StatelessWidget {
  SubPage({super.key, required this.name}) {
    print('init $name');
  }
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(color: ColorsExt.rand());
  }
}

// 让子页面能够缓存，分成三步
class ChildPage extends StatefulWidget {
  ChildPage({super.key, required this.name}) {
    print('init $name');
  }
  final String name;

  @override
  State<ChildPage> createState() => _ChildPageState();
}

// 1) 增加 mixin
class _ChildPageState extends State<ChildPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // 2) 调用 super.build
    return Container(color: ColorsExt.rand());
  }

  // 3) 添加属性
  @override
  bool get wantKeepAlive => true;
}
