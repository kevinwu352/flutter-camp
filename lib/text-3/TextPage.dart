import 'package:flutter/material.dart';

// 文档说必须设 text direction，如果用 MaterialApp 的话，它帮你设了
// runApp(Text("Hello, world!", textDirection: TextDirection.ltr));

// 两种设背景色的方法
// Text("Some text...",
//   style: TextStyle(backgroundColor: Colors.blue),
//   style: TextStyle(background: Paint()..color = Colors.blue),
// )

// 多种样式拼接
// Text.rich(
//   TextSpan(
//     text: "Hello", // default text style
//     children: <TextSpan>[
//       TextSpan(text: " beautiful ", style: TextStyle(fontStyle: FontStyle.italic)),
//       TextSpan(text: "world", style: TextStyle(fontWeight: FontWeight.bold)),
//     ],
//   ),
// )

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Text"),
      ),
      body:
          // Text(
          //   "This is a pretty long text.",
          //   textAlign: TextAlign.center,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          // ),
          Container(
            width: 200,
            height: 200,
            color: Colors.red,
            child: Text("abc"),
          ),
    );
  }
}
