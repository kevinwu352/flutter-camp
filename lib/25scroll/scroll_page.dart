import 'package:flutter/material.dart';

// Scrollable 主要通过对手势的处理来实现滑动效果
// Viewport 提供的是一个 视窗 的作用，也就是列表所在的可视区域大小
// Sliver 主要是用于在 Viewport 里面布局和渲染内容

// 三者占用的空间是重合的
// Sliver 父组件为 Viewport，Viewport 的父组件为 Scrollable

// 布局流程
// Scrollable 监听到用户滑动行为后，根据最新的滑动偏移构建 Viewport
// Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver
// Sliver 中对子组件（RenderBox）按需进行构建和布局，然后确认自身的位置、绘制等信息，保存在 geometry 中（一个 SliverGeometry 对象）

// Widget 树中会有一个默认的 PrimaryScrollController，如果可滚动控件没传 controller 且 primary = true（默认），就使用全局的。Scaffold 正是使用此来实现 iOS 上点击状态栏回到顶部

// Scrollbar 把子包起来就有滚动条了。内容少时，就算可滚动，也不会有滚动条

// ================================================================================

// SingleChildScrollView 不会懒加载，所以，如果超出屏幕的内容太多，性能比较差，应该改用 ListView
//   reverse 用于做聊天那种窗口，创建后直接显示最后一行
//   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag 拖动时关闭键盘

// SingleChildScrollView 是单个子元素，它并未使用 RenderSliver，而是在 performLayout 时直接调整子的 offset 来达到滑动效果

// ================================================================================

// ListView(children: [])
// 用这种方式创建 ListView，虽然创建了所有的子控件，但也是懒加载的
// 子控件的构造器都被调用了，但只有需要显示的行和附近的几行会 build，其它的 build 方法都没调用

// ListView.builder 不传数量则是无限列表

// ListView 中的列表行都是 RenderBox，并不是 Sliver
// 一个 ListView 中只有一个 Sliver，默认是 SliverList，按需加载的逻辑是 Sliver 中实现的

// itemExtent / prototypeItem 预先决定行高，性能好，只能设其一
// itemExtentBuilder 根据 index 返回相应的行高，行高不相同的时候用
// cacheExtent 预渲染区域高度，在可见区域 前 后

// shrinkWrap 决定 ListView 的尺寸，是填充满父，还是压缩到和子一样大
// 主要用来 ListView 嵌套用的，里面的紧凑压缩自己。另外，Column 包含 ListView 会崩，此参数可解决崩溃
// 以前版本中，如果为真，会加载所有的子，用来计算总高度，这会导致懒加载失效，从而导致性能问题
// 不过刚才实验了一下，并没有全部加载，itemCount 设很大，itemBuilder 里面打印日志

// addAutomaticKeepAlives
// addRepaintBoundaries

// findChildIndexCallback 文档说，重排顺序的时候，用 key 来查询新的 index，有啥用？

// semanticChildCount 有多少个子元素，应该是给 Accessibility 用的，数量是能推断出来的，ListView 直接就是子的数量，但如果是 ListView.separated 创建的会折半
// addSemanticIndexes 为真时，把每个子元素用 IndexedSemantics 包起来

// ================================================================================

// GridView
// CustomScrollView 使用 sliver 创建自定义 ScrollView
// PageView 每个页面尺寸相同，能左右换页也能上下，像是那种上面有个 tabbar 切换不同分类的场景

// 两种方式接收滚动事件
//   1) ScrollController
//   controller.addListener(...)
//   2) NotificationListener，它的回调里面返回 true 时，滚动通知不会沿着链条向上传递，相当于吞掉了通知
//   NotificationListener(onNotification: (notification) { return true; }, child: ...)

class ScrollPage extends StatefulWidget {
  const ScrollPage({super.key});

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  final sc = ScrollController();

  //   @override
  //   void initState() {
  //     sc.addListener(handleScroll);
  //     super.initState();
  //   }
  //
  //   @override
  //   void dispose() {
  //     sc.removeListener(handleScroll);
  //     super.dispose();
  //   }
  //
  //   void handleScroll() {
  //     print('scrolled ${sc.position}');
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scroll')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),

      // body: ListView(children: List.generate(50, (i) => ChildItem(index: i)).toList()),
      // body: ListView.builder(itemExtent: 40, itemBuilder: (context, index) => Text('dt $index')),
      // body: Column(
      //   children: [
      //     ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: 100,
      //       // prototypeItem: ListTile(title: Text("1")),
      //       itemBuilder: (context, index) {
      //         return ListTile(title: Text('data $index'));
      //       },
      //     ),
      //   ],
      // ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 100,
        // prototypeItem: ListTile(title: Text("1")),
        itemBuilder: (context, index) {
          print('build $index');
          return ListTile(title: Text('data $index'));
        },
      ),

      // body: SingleChildScrollView(
      //   padding: EdgeInsets.all(20),
      //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //   child: Column(children: List.generate(50, (i) => TextField()).toList()),
      // ),
      // body: ListView.builder(
      //   // controller: sc,
      //   itemCount: 30,
      //   itemBuilder: (context, index) => ListTile(title: Text('$index')),
      //   physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      // ),
      // body: NotificationListener(
      //   onNotification: (notification) {
      //     print('got $notification');
      //     return true;
      //   },
      //   child: ListView.builder(itemCount: 20, itemBuilder: (context, index) => ListTile(title: Text('$index'))),
      // ),
    );
  }
}

class ChildItem extends StatelessWidget {
  ChildItem({super.key, required this.index}) {
    print('create $index');
  }
  final int index;
  @override
  Widget build(BuildContext context) {
    print('build $index');
    return Padding(padding: EdgeInsets.all(20), child: Text('data $index'));
  }
}
