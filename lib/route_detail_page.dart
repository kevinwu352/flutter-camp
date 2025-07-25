import 'package:flutter/material.dart';

// 2) 接受前边传过来的参数
// class RouteDetailPage extends StatelessWidget {
//   const RouteDetailPage({super.key, required this.para});
//   final String para;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Detail")),
//       body: Text("val: $para"),
//     );
//   }
// }
//
// class RouteDetailPage extends StatefulWidget {
//   const RouteDetailPage({super.key, required this.para});
//   final String para;
//   @override
//   State<RouteDetailPage> createState() => _RouteDetailPageState();
// }
// class _RouteDetailPageState extends State<RouteDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Detail")),
//       body: Text("val: ${widget.para}"),
//     );
//   }
// }

// 3) 返回，且给前边页面返回一个结果
class RouteDetailPage extends StatelessWidget {
  const RouteDetailPage({super.key, required this.para});
  final String para;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(101);
        },
        child: Text("back"),
      ),
    );
  }
}
