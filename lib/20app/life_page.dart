import 'package:flutter/material.dart';

// REVIEW

// Widget.canUpdate
// 一个旧的 Element 能否被新的 Widget 更新
// element 节点在更新前都会调用其对应 Widget 的 canUpdate 方法
// 理解：
// Widget 树和 Element 树节点是一一对应的
// 某时刻，一个位置上有一个 Widget，与它对应的有一个 Element
// 当页面刷新时，新的 Widget 来了，它要找一个元素与之对应，此位置上的旧 Widget 对应的旧 Element 能不能拿来用呢？
// 把这俩 Widget 比较一下，runtimeType 和 Widget.key 相同，则用旧 Element，否则丢弃旧 Element，并创建一个新的且加入到树中

// StatelessWidget 当某控件只依赖于 构造参数 上下文信息 时
//   很少重写此方法
//   StatelessElement createElement()
//   此方法应该是无副作用的
//   Widget build(BuildContext context)

// StatefulWidget
//   很少重写此方法
//   StatefulElement createElement()
//   可能会被调用多次：
//     被安插到树上多个位置，会为每个位置创建各自状态
//     先从树上移除，又重新加入到树，会重新创建状态
//   State createState()

// State.mounted 表示 _element != null
// Element.mounted 表示 _widget != null

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
//    备注：
//      订阅通知 创建资源，并在 dispose 里释放这些东西
//      如有必要，在 didUpdateWidget 里取消旧的订阅新的
// 4) 系统调用 didChangeDependencies，子类在此方法内实现 和 InheritedWidget 相关的初始化操作
//    此方法可能会被调用多次
//    至此，state 实例算是被完全初始化
//    备注：
//      初次流程走下来会调这里；如果 build 里依赖了 InheritedWidget，且依赖的值变化了，也会调这里
//      因为依赖变化后，系统会调用 build，所以子类很少重写此方法。除非一些重活，重活不能在 build 里做，比如请求网络
//
//
// 5) 系统可能会调用 build 多次来获取子树，自己的 setState 调用也会触发 build 方法
//
// 6) 父可能会重建，可能要求此位置显示 runtimeType 和 Widget.key 相同的新控件
//    此时 widget 属性会变成新的，然后调用 didUpdateWidget，参数是旧 widget
//    此方法应该做的事？文档举例说在此开启隐式动画
//    系统随后会调用 build，所以在 didUpdateWidget 里调用 setState 是多余的
//    备注：
//      父刷新的确导致这里被调用，这里应该把父给的新状态拿来更新自己，参考下面的例子
//      从文档的描述来看，didUpdateWidget 就是系统更新 state.widget 属性后的回调通知
//
//
// 7) 开发中 hot reload 会导致 reassemble 被调用，子类在此方法中 重新初始化 initState 里做的那些事
//
//
// 8) 此 state 对应的子树被移除时，比如父刷新且 runtimeType 或 Widget.key 不同，系统会调用 deactivate
//    方法内应该清除 state 和其它元素的连接，没太懂？
//    如果子类在此方法内释放了某些资源而后此子树又重新插入到树，要在 activate 里重新获取这些资源
//
// 9) 子树可能会被重新插入到树中其它位置，系统会调用 build 确保 state 适配新的位置
//    如果系统确实重新插入此子树，系统会在当前动画最后一帧结束前做，因为动画帧结束后如果还没从 inactive-> active 子树会从树上移除
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
// 用 if 隐藏再显示
//   deactivate
//   dispose
//   initState
//   didChangeDependencies
//   build
// push/pop 时，此页面状态里的函数啥也不会调用

// ================================================================================

// StatelessWidget.build 调用时机
//   初次加入到树
//   父改变了参数重建它
//   自己依赖的 InheritedWidget 变化了

// State.build 调用时机
//   initState 后
//   didChangeDependencies 后
//   didUpdateWidget 后
//   setState 后
//   从树中移除会调用 deactivate，重新插入到树的其他位置后

// ================================================================================

// 为何 build 方法要在 State 上？
// 继承 StatefulWidget 时更灵活
// 1) 如果 build 在 StatefulWidget 中，而状态在 State 中，build 就得增加 state 参数，且要把 State 类的属性公开
// 2) 文档中以 AnimatedWidget 为例，它是 StatefulWidget 且引入了一个 build 方法
//    如果照上面说的给 build 增加 state 参数，子类调用 super.build(state) 时，父类必须提供自己私有的状态实例给子类，子类拿它来作为 state 参数

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
  bool show = true;
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

            SizedBox(height: 50),

            TextButton(
              onPressed: () {
                setState(() => show = !show);
              },
              child: Text(show ? 'hide' : 'show'),
            ),
            if (show) CounterWidget(initValue: count),

            SizedBox(height: 50),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubPage()));
              },
              child: Text('push'),
            ),
          ],
        ),
      ),
    );
  }
}

// 注意 State 生命周期函数调用父类时的顺序，有些要先调 super，有些要后调 super

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  // --------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    print("build");
    return TextButton(child: Text('$_counter'), onPressed: () => setState(() => ++_counter));
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget, _counter:$_counter new:${widget.initValue} old:${oldWidget.initValue}');
    // _counter = widget.initValue;
  }

  // --------------------------------------------------------------------------------

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  // --------------------------------------------------------------------------------

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
    print('activate');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sub')),
      body: Text('hehe'),
    );
  }
}
