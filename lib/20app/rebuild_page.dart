import 'package:flutter/material.dart';

// StatefulWidget 调用 setState() 后，它包含的 const 控件并不会调用自己的 build 方法
// const 构造器不能有 body，所以不知道构造器是否会被调用多次，不过就算调用多次也不重要，是吧？

// const 控件不仅节省 CPU 时间，还节省内存

// 无法定义一个变量，再用变量去创建 const 控件，因为变量在编译时无法确定值

class RebuildPage extends StatefulWidget {
  const RebuildPage({super.key});

  @override
  State<RebuildPage> createState() => _RebuildPageState();
}

class _RebuildPageState extends State<RebuildPage> {
  @override
  Widget build(BuildContext context) {
    print('do rebuild');
    return Scaffold(
      appBar: AppBar(title: Text('Rebuild')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            print('to rebuild');
          });
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        children: [
          ColorWidget(size: 10),
          ColorWidget(size: 20),
          ColorWidget(size: 10),
          const ColorWidget(size: 50),
          const ColorWidget(size: 60),
          const ColorWidget(size: 50),
        ],
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    print('build $size');
    return Container(width: size, height: size, color: Colors.red);
  }
}
