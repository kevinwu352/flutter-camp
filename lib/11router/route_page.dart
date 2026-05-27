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

          // 3) 动态路由
          // 新页面有参数时，直接在构造的时候把参数传给它
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteDetailPage(val: 'god')));
          // 新页面无参数时，通过 RouteSettings 传递参数
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const RouteDetailPage(),
          //     settings: RouteSettings(arguments: "yep1"),
          //   ),
          // );
          // final val = ModalRoute.of(context)?.settings.arguments as String; 页面内部 build 方法内把值取出来用

          // 4) 静态路由
          // 新页面有参数时
          // Navigator.of(context).pushNamed('/app', arguments: 'xx11');
          // '/app': (context) => AppPage(val: ModalRoute.of(context)?.settings.arguments as String)
          // 新页面无参数时
          // Navigator.of(context).pushNamed("/detail", arguments: "yep2");
          // '/boo': (context) => BooPage() 配置路由时，正常操作
          // final val = ModalRoute.of(context)?.settings.arguments as String; 页面内部 build 方法内把值取出来用
        },
        child: Text("detail"),
      ),
    );
  }
}
