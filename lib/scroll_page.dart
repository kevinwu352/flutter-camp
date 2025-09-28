import 'package:flutter/material.dart';

// Scrollable 为滑动控件实现操作，包括手势识别，一般不会直接使用此类
// Viewport 显示内容

// ListView
// GridView
// SingleChildScrollView
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

  @override
  void initState() {
    sc.addListener(handleScroll);
    super.initState();
  }

  @override
  void dispose() {
    sc.removeListener(handleScroll);
    super.dispose();
  }

  void handleScroll() {
    print('scrolled ${sc.position}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scroll')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: ListView.builder(
        controller: sc,
        itemCount: 20,
        itemBuilder: (context, index) => ListTile(title: Text('$index')),
      ),
      // body: NotificationListener(
      //   onNotification: (notification) {
      //     print('got $notification');
      //     return true;
      //   },
      //   child: ListView.builder(itemCount: 20, itemBuilder: (context, index) => ListTile(title: Text('$index'))),
      // ),
      // body: NotificationListener(
      //   onNotification: (notification) {
      //     print('got 111');
      //     return true;
      //   },
      //   child: NotificationListener(
      //     onNotification: (notification) {
      //       print('got 222');
      //       return true;
      //     },
      //     child: ListView.builder(itemCount: 20, itemBuilder: (context, index) => ListTile(title: Text('$index'))),
      //   ),
      // ),
    );
  }
}
