import 'package:flutter/material.dart';

// 重点：
// 当我们需要对树中同级别多个相同类型的 StatefulWidget 进行添加、移除或重排时，就需要使用 key，否则会出现意想不到的问题
//
// 还有一句话：
// 如果列表里的 StatefulWidget 里面，使用了另外一个 StatefulWidget
// 那么也必须要给另外的这个 StatefulWidget 指定 key，否则状态管理方面一定会出现问题

class Key2Page extends StatefulWidget {
  const Key2Page({super.key});

  @override
  State<Key2Page> createState() => _Key2PageState();
}

class _Key2PageState extends State<Key2Page> {
  bool order = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            order = !order;
          });
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: SizedBox.expand(
        child: Column(
          // 无 key，直接交换，Widget 虽然交换了，但 State 没交换
          // 它俩顺序变了，但对于系统来说，两个 Widget 类型一样，只是里面的属性不一样
          // 所以，系统会拿旧的 Element 过来，并用新的 Widget 更新旧的 Element，而 State 在 Element 上
          // children: order
          //     ? [_ColorView(color: Colors.red), _ColorView(color: Colors.green)]
          //     : [_ColorView(color: Colors.green), _ColorView(color: Colors.red)],
          //
          // 有 key，红色11绿色22，Widget 和 State 都交换了
          // 新的 Widget 通过 key 准确地找到了旧 Widget 对应的 Element
          // children: order
          //     ? [_ColorView(key: ValueKey(11), color: Colors.red), _ColorView(key: ValueKey(22), color: Colors.green)]
          //     : [_ColorView(key: ValueKey(22), color: Colors.green), _ColorView(key: ValueKey(11), color: Colors.red)],
          //
          // 本来有三个颜色框，数字不同 4/1/2，点击按钮以后，红色消失
          // 绿色找 Element 时，找到红色遗留下来的，它的数字是 4
          // 蓝色找 Element 时，找到绿色遗留下来的，它的数字是 1
          // 最终蓝色原来的 Element 被丢掉了
          children: [
            if (!order) _ColorView(color: Colors.red),
            _ColorView(color: Colors.green),
            _ColorView(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class _ColorView extends StatefulWidget {
  const _ColorView({super.key, required this.color});
  final Color color;

  @override
  State<_ColorView> createState() => __ColorViewState();
}

class __ColorViewState extends State<_ColorView> {
  @override
  void initState() {
    super.initState();
    print('init state');
  }

  @override
  void didUpdateWidget(_ColorView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('update widget');
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    print('build');
    return GestureDetector(
      onTap: () => setState(() => count++),
      child: Container(width: 100, height: 100, color: widget.color, child: Text('count: $count')),
    );
  }
}
