import 'package:flutter/material.dart';

// StatelessWidget
//   很少重写此方法
//   StatelessElement createElement()
//   此方法应该是无副作用的
//   调用时机：
//     初次加入到树
//     父改变了参数重建它
//     自己依赖的 InheritedWidget 变化了
//   Widget build(BuildContext context)
//
// StatefulWidget
//   很少重写此方法
//   StatefulElement createElement()
//   可能会被调用多次：
//     被安插到树上多个位置，会为每个位置创建各自状态
//     先从树上移除，又重新加入到树，会重新创建状态
//   State createState()

// ================================================================================

// State 生命周期
//
// 1) 用 StatefulWidget.createState 创建 State 实例
// 2) 将 state 和某个 BuildContext 关联，这个关联是永久的，state 不会改变它的 BuildContext
//    然而 BuildContext 在树中的位置可能会被移动
//    至此，state 算是 mount 成功
//
// 3) 系统调用 initState，子类在此方法内实现 只执行一次的初始化操作
//    此时 context 和 widget 属性是有值的
// 4) 系统调用 didChangeDependencies，子类在此方法内实现 和 InheritedWidget 相关的初始化操作
//    此方法可能会被调用多次
//    至此，state 实例算是被完全初始化
//
//
// 5) 系统可能会调用 build 多次来获取子树，自己的 setState 调用也会触发 build 方法
//
// 6) 父可能会重建，可能要求此位置显示 runtimeType 和 Widget.key 相同的新控件
//    此时 widget 属性会变成新的，然后调用 didUpdateWidget，参数是旧 widget
//    此方法应该做的事？文档举例说在此开启隐式动画
//    系统随后会调用 build，所以在 didUpdateWidget 里调用 setState 是多余的
//    注：父刷新的确导致这里被调用，这里该把父给的新状态拿来更新自己，参考下面的例子
//
//
// 7) 开发中 hot reload 会导致 reassemble 被调用，子类在此方法中 重新初始化 initState 里做的那些事
//
//
// 8) 此 state 对应的子树被移除时，比如父刷新且 runtimeType 或 Widget.key 不同，系统调用 deactivate
//    方法内应该清除 state 和其它元素的连接，没太懂？
//
// 9) 子树可能会被重新插入到树中其它位置，系统会调用 build 确保 state 适配新的位置
//    如果系统确实重新插入此子树，系统会在动画帧结束前做，动画帧结束后子树会从树上移除
//    因此 state 可以推迟资源清理，直到 dispose 被调用
//
// 10) 如果此动画帧结束时子树未重新插入到树中，系统会调用 dispose
//     此后 build 不会再被调用，此时要清理各种资源
//
// 11) dispose 以后 mounted 为假，不能再调用 setState，state 无法再次 mount

// 启动页面时
//   initState
//   didChangeDependencies
//   build
// 修改字符串，再热更新
//   reassemble
//   didUpdateWidget
//   build
// 注释此控件，再热更新
//   reassemble
//   deactivate
//   dispose

// build 调用时机
//   initState 后
//   didChangeDependencies 后
//   didUpdateWidget 后
//   setState 后
//   从树中移除会调用 deactivate，重新插入到树的其他位置后

// ================================================================================

// 下例中，父子都是 StatefulWidget
// 子更新值时，子的 build 会被调用
// 父更新值时，子的 didUpdateWidget 和 build 会被调用，如果不将值更新到 _counter，画风就诡异了

class LifePage extends StatefulWidget {
  const LifePage({super.key});

  @override
  State<LifePage> createState() => _LifePageState();
}

class _LifePageState extends State<LifePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Life')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                setState(() => count++);
              },
              child: Text('+++'),
            ),
            Text('count: $count'),
            CounterWidget(initValue: count),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key, this.initValue = 0});
  final int initValue;
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print('initState');
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget _counter:$_counter new:${widget.initValue} old:${oldWidget.initValue}');
    // _counter = widget.initValue;
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return TextButton(child: Text('$_counter'), onPressed: () => setState(() => ++_counter));
  }
}
