import 'package:flutter/material.dart';

// ListView(children: [])
// 用这种方式创建 ListView，虽然创建了所有的子控件，但也是懒加载的
// 子控件的构造器都被调用了，但只有需要显示的行和附近的几行会 build，其它的 build 方法都没调用

// ListView.builder 不传数量则是无限列表

// AnimatedList 是带有添加动画和删除动画的列表

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

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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

  final controller = ScrollController(keepScrollOffset: false, initialScrollOffset: 0);

  var count = 5;
  final listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {});
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubPage()));
          // final list = controller.positions;
          // print(list);
          // setState(() {
          //   count += 1;
          // });
          count += 1;
          listKey.currentState?.insertItem(count - 1);
        },
        child: Icon(Icons.run_circle),
      ),

      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //         controller: controller,
      //         itemCount: 30,
      //         itemBuilder: (context, index) => ListTile(title: Text('data $index')),
      //       ),
      //     ),
      //     Divider(),
      //     Expanded(
      //       child: ListView.builder(
      //         controller: controller,
      //         itemCount: 30,
      //         itemBuilder: (context, index) => ListTile(title: Text('data $index')),
      //       ),
      //     ),
      //   ],
      // ),
      // body: AnimatedList(
      //   key: listKey,
      //   initialItemCount: count,
      //   itemBuilder: (context, index, animation) => ListTile(title: Text('data $index')),
      // ),

      // body: SingleChildScrollView(
      //   padding: EdgeInsets.all(20),
      //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //   child: Column(children: List.generate(50, (i) => TextField()).toList()),
      // ),
      body: ListView.builder(
        // controller: sc,
        itemCount: 30,
        itemBuilder: (context, index) => ListTile(title: Text('$index')),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      ),
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

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book')),
      body: Text('--'),
    );
  }
}
