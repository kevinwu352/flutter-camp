import 'package:flutter/material.dart';

// REVIEW

// Key 对象存在的目的主要是：
// 区分和维持 Widget 的状态，它是元素树里的节点复用的重要标识
// 能提升 Flutter 性能，因为提高了复用率，减少了刷新的工作量
// 大多数情况下，无状态的 Widget 是不需要 Key 的，通过其构造器传的新参数来更新界面

// 同级兄弟区分/保留状态
//
// LocalKey 只作用于标识同一父 Widget 中的 Widget，不能用于识别其父 Widget 之外的 Widget
// 也就是只用于区分同级兄弟
// 文档说：如果一个 widget 是父唯一的子，那么它无需 key

// 整个树区分/保留状态/操作导航
//
// 允许开发者在 Widget 树里去「唯一」标识 Widget，并提供 BuildContext(Element)/State 的全局访问
// 这里的「唯一」更多体现在当前这一帧里的「唯一」
//
// 如果 Element 在同一帧中移动或者删除，并且它具有 GlobalKey，那么它仍然可能被重新激活使用
// 所以 GlobalKey 不仅可以作为 Key 区分 Widget，帧内还可以在 BuildOwner 里“全局”保持住 Element、State 和 RenderObject 的“状态”，即使它出现移动或者删除
// 注意：GlobalKey 在整个树保留状态，但仅限于同一帧内。如果点击某按钮显隐某个具有 GlobalKey 的 Widget，两次点击是跨帧的，状态是无法保留的
// 同时，通过 GlobalKey，我们也可以访问对应的 BuildContext 和 State 数据，甚至是直接给 MaterialApp 添加 GlobalKey 来操作导航
//
// 注意：使用 GlobalKey 不能频繁创建，通常应该是让它和 State 对象拥有类似的“生命长度”

class Key3Page extends StatefulWidget {
  const Key3Page({super.key});
  @override
  State<Key3Page> createState() => _Key3PageState();
}

class _Key3PageState extends State<Key3Page> {
  final _gkey = GlobalKey();
  // final _lkey = ValueKey('asdf');

  int _value = 0;

  void _incrementCounter() {
    setState(() {
      _value++;
      print('counter: $_value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Key3')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 无 key，状态会丢失了，_value 的值保留且增加，Counter 重建且 _counter 无法保留
            // if (_value.isOdd) Counter(onPressed: _incrementCounter),
            // Text('value: $_value'),
            // if (_value.isEven) Counter(onPressed: _incrementCounter),
            //
            // if (_value.isEven) Text('value: $_value'),
            // Counter(onPressed: _incrementCounter),
            // if (_value.isOdd) Text('value: $_value'),

            // 用 GlobalKey，状态保留了
            // if (_value.isOdd) Counter(onPressed: _incrementCounter, key: _gkey),
            // Text('value: $_value'),
            // if (_value.isEven) Counter(onPressed: _incrementCounter, key: _gkey),

            // 用 LocalKey，状态保留了
            // if (_value.isOdd) Counter(onPressed: _incrementCounter, key: _lkey),
            // Text('value: $_value'),
            // if (_value.isEven) Counter(onPressed: _incrementCounter, key: _lkey),

            // 用 LocalKey，但不是同级兄弟了，状态丢失了
            // if (_value.isOdd) Counter(onPressed: _incrementCounter, key: _lkey),
            // Text('value: $_value'),
            // Column(
            //   children: [if (_value.isEven) Counter(onPressed: _incrementCounter, key: _lkey)],
            // ),

            // 用 GlobalKey，但不是同级兄弟了，状态保留了
            if (_value.isOdd) Counter(onPressed: _incrementCounter, key: _gkey),
            Text('value: $_value'),
            Column(
              children: [if (_value.isEven) Counter(onPressed: _incrementCounter, key: _gkey)],
            ),

            // 用 GlobalKey，跨帧，无法保留状态
            // if (_value.isEven) Counter(onPressed: () {}, key: _gkey),
            // TextButton(onPressed: () => setState(() => _value++), child: Text('$_value')),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  void initState() {
    super.initState();
    print('init state');
  }

  @override
  void didUpdateWidget(Counter oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('did update');
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _incrementCounter, child: Text('counter: $_counter'));
  }
}
