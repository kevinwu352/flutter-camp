import 'package:flutter/material.dart';
import 'package:flutter_camp/route_detail_page.dart';

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

          // 2) 传参数给后边页面
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) {
          //       return RouteDetailPage(para: "haha");
          //     },
          //   ),
          // );

          // 3) 接收后边页面传回来的结果
          // final res = await Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) {
          //       return RouteDetailPage(para: "haha");
          //     },
          //   ),
          // );
          // print(res);
        },
        child: Text("detail"),
      ),
    );
  }
}
