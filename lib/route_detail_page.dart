import 'package:flutter/material.dart';

// class RouteDetailPage extends StatelessWidget {
//   const RouteDetailPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Detail")),
//       body: ElevatedButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: Text("back"),
//       ),
//     );
//   }
// }

// 2) 返回，且给前边页面返回一个结果
// class RouteDetailPage extends StatelessWidget {
//   const RouteDetailPage({super.key, required this.para});
//   final String para;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Detail")),
//       body: ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).pop(101);
//         },
//         child: Text("back"),
//       ),
//     );
//   }
// }

// 3) 接受前边传过来的参数
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

// 4) 静态路由接收参数
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

// class RouteDetailPage extends StatelessWidget {
//   const RouteDetailPage({super.key, required this.para});

//   final String para;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Detail")),
//       body: ElevatedButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: Text("back: $para"),
//       ),
//     );
//   }
// }
