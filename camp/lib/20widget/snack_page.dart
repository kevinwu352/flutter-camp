import 'package:flutter/material.dart';

// 点击不会消失，拖动能消失，点按钮会消失，即使按钮回调为空

class SnackPage extends StatelessWidget {
  const SnackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Snack')),
      // floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle_outlined)),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('the percentage percentage percentage percentage abc'),
                  backgroundColor: Colors.red,
                  // elevation: 5,
                  duration: Duration(seconds: 1000),

                  // padding: EdgeInsets.zero,

                  // width: 200,
                  // margin: EdgeInsets.all(10),
                  // 只能和 float 一起使用，width 和 margin 不能同时用
                  behavior: SnackBarBehavior.fixed,

                  // showCloseIcon: true,
                  // closeIconColor: Colors.green,

                  // 这个的作用看看 hit page 那边，没懂？
                  // hitTestBehavior: HitTestBehavior.translucent,

                  // 0 会使按钮始终位于第二行，关闭按钮也是
                  // 具体作用没懂？
                  // actionOverflowThreshold: 0.25,
                  action: SnackBarAction(label: 'Done', onPressed: () {}),

                  dismissDirection: DismissDirection.vertical, // 拖动消失的方式
                ),
              );
            },
            child: Text('show snack'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SnackChildPage()));
            },
            child: Text('push'),
          ),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('333'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('222'), child: Text('push')),
          // ElevatedButton(onPressed: () => print('111'), child: Text('push')),
        ],
      ),
    );
  }
}

class SnackChildPage extends StatelessWidget {
  const SnackChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('child')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle_outlined)),
      body: Text('data'),
    );
  }
}
