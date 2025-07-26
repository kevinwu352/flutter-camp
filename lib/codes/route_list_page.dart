import 'package:flutter/material.dart';
import 'package:flutter_camp/codes/route_detail_page.dart';

// home: RouteListPage(), 不要这句了
// initialRoute: "/",
// routes: {
//   "/": (_) => HomePage(),
//   "/list": (_) => RouteListPage(),
//   "/detail": (_) => RouteDetailPage(),
// },
// 定义的时候有 /，push 的时候也要加 /。定义的时候不加，使用的时候可以不加
// 最好是加？还是不加呢？

class RouteListPage extends StatelessWidget {
  const RouteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List")),
      body: ElevatedButton(
        onPressed: () async {
          // 1) 两种 push 方式
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return RouteDetailPage();
          //     },
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return RouteDetailPage();
          //     },
          //   ),
          // );

          // 2) 接收后边页面传回来的结果
          // final res = await Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) {
          //       return RouteDetailPage(para: "haha");
          //     },
          //   ),
          // );
          // print(res);

          // 3)
          // 后边参数有名字：动态路由传参数
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) {
          //       return RouteDetailPage(para: "haha");
          //     },
          //   ),
          // );
          // 后边参数有名字：静态？

          // 4)
          // 后边参数无名字：动态路由传参数
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const RouteDetailPage(),
          //     settings: RouteSettings(arguments: "yep1"),
          //   ),
          // );
          // 后边参数无名字：静态路由传参数
          // Navigator.of(context).pushNamed("/detail", arguments: "yep2");
        },
        child: Text("detail"),
      ),
    );
  }
}
