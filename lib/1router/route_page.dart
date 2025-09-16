import 'package:flutter/material.dart';

// 主要讲解不定义路由表的时候，如何跳转传参之类的
// 动态路由，写死在代码里的，用页面类名跳转
// 静态路由，runApp 那边定义了路由表，用路由名字跳转

class RouteListPage extends StatelessWidget {
  const RouteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List")),
      body: ElevatedButton(
        onPressed: () async {
          // 1) 两种 push 方式
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteDetailPage()));
          // Navigator.push(context, MaterialPageRoute(builder: (context) => RouteDetailPage()));

          // 2) 接收后边页面传回来的结果
          // final res = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => RouteDetailPage()));
          // print(res);
          // 后边页面这样返回值给前面
          // Navigator.of(context).pop(101);

          // 3) 后边页面参数有名字时
          // 动态路由，直接在构造的时候把参数传给它
          // RouteDetailPage(para: "haha")
          // 静态路由，咋传？
          // ...

          // 4) 后边页面参数无名字时
          // 动态路由
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const RouteDetailPage(),
          //     settings: RouteSettings(arguments: "yep1"),
          //   ),
          // );
          // 静态路由
          // Navigator.of(context).pushNamed("/detail", arguments: "yep2");
        },
        child: Text("detail"),
      ),
    );
  }
}

// 4)
class RouteDetailPage extends StatelessWidget {
  const RouteDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    final para = ModalRoute.of(context)?.settings.arguments as String;
    print(para);
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("back: $para"),
      ),
    );
  }
}
