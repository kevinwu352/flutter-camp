import 'package:flutter/material.dart';

// 封装数据，这是一个 widget，它有一个数据
class MyStateWidget extends InheritedWidget {
  const MyStateWidget({super.key, required this.data, required super.child});

  final int data;

  static MyStateWidget of(BuildContext context) {
    // 这种方式会注册依赖，当值变化后，会调用子的 didChangeDependencies/build
    // final result = context.dependOnInheritedWidgetOfExactType<MyStateWidget>();
    // 这种方式不会注册依赖，当值变化后，子不会更新
    final result = context.getElementForInheritedWidgetOfExactType<MyStateWidget>();
    assert(result != null, 'No MyStateWidget found in context');
    return result!.widget as MyStateWidget;
  }

  @override
  bool updateShouldNotify(MyStateWidget oldWidget) => data != oldWidget.data;
}

// 使用数据，这是另外一个 widget，它从树里面查找上面那个数据，但这个 widget 和上面的 widget 无任何关系
class Use1Widget extends StatelessWidget {
  const Use1Widget({super.key});
  @override
  Widget build(BuildContext context) {
    print('build 1');
    var data = MyStateWidget.of(context).data;
    return Text('data $data');
    // return Scaffold(body: Center(child: Text('$data')));
  }
}

class Use2Widget extends StatefulWidget {
  const Use2Widget({super.key});
  @override
  State<Use2Widget> createState() => _Use2WidgetState();
}

class _Use2WidgetState extends State<Use2Widget> {
  @override
  Widget build(BuildContext context) {
    print('build 2');
    var data = MyStateWidget.of(context).data;
    return Text('data $data');
    // 如果不使用 InheritedWidget 的数据，这里也被调用了，估计要变成 const 才能阻击多次被 build 吧
    // return Text('asdf');
  }

  // 使用了 InheritedWidget 提供的数据以后，每次数据变化，这里会被调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('did change');
  }
}

// 组合起来，这里是一个 StatefulWidget
// MyStatePage 管理状态，增减也在此处理
// MyStatePage 把数据给 MyStateWidget，它把数据共享出去
// 然后 UseWidget 从树中查找数据并显示
class MyStatePage extends StatefulWidget {
  const MyStatePage({super.key});

  @override
  State<MyStatePage> createState() => _MyStatePageState();
}

class _MyStatePageState extends State<MyStatePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyState')),
      body: Center(
        child: MyStateWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Use1Widget(),
              Use2Widget(),
              TextButton(onPressed: () => setState(() => ++count), child: Text('+++')),
            ],
          ),
        ),
      ),
    );
  }
}
