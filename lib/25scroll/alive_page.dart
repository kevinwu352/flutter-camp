import 'package:flutter/material.dart';

// 如果列表里手动添加 AutomaticKeepAlive 组件，要设置 addSemanticIndexes=false，否则会异常，不理解
// 如果列表里不加 AutomaticKeepAlive 组件，则没事，addAutomaticKeepAlives=true 也没事
// Incorrect use of ParentDataWidget.

// 保留某行，不让系统回收的方式：
// 1) ListView.addAutomaticKeepAlives=true，行的 state 混入 AutomaticKeepAliveClientMixin
// 2) 用 KeepAlive 组件包起某行，其它都不用设置

class AlivePage extends StatelessWidget {
  const AlivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alive')),
      body: ListView.builder(
        addAutomaticKeepAlives: false, // 是否把子用 AutomaticKeepAlive 包起来
        addRepaintBoundaries: false, // 是否把子用 RepaintBoundary 包起来
        addSemanticIndexes: false, // 是否把子用 IndexedSemantics 包起来
        cacheExtent: 0,
        itemCount: 100,
        // itemBuilder: (context, index) => AutomaticKeepAlive(child: _KeepAliveItem1(index: index)),
        // itemBuilder: (context, index) => _KeepAliveItem1(index: index),
        itemBuilder: (context, index) => KeepAlive(
          keepAlive: index.isEven,
          child: _KeepAliveItem2(index: index),
        ),
      ),
    );
  }
}

class _KeepAliveItem1 extends StatefulWidget {
  const _KeepAliveItem1({required this.index});
  final int index;
  @override
  State<_KeepAliveItem1> createState() => _KeepAliveItem1State();
}

class _KeepAliveItem1State extends State<_KeepAliveItem1> with AutomaticKeepAliveClientMixin<_KeepAliveItem1> {
  int _counter = 0;
  @override
  bool get wantKeepAlive => widget.index.isEven;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListTile(
      title: Text('Item1 ${widget.index}: $_counter'),
      trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _counter++)),
    );
  }
}

class _KeepAliveItem2 extends StatefulWidget {
  const _KeepAliveItem2({required this.index});
  final int index;
  @override
  State<_KeepAliveItem2> createState() => __KeepAliveItem2State();
}

class __KeepAliveItem2State extends State<_KeepAliveItem2> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Item2 ${widget.index}: $_counter'),
      trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _counter++)),
    );
  }
}
