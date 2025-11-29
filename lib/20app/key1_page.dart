import 'package:flutter/material.dart';

// ValueKey 比较内容是否相等
// ObjectKey 比较是否是同一实例
// UniqueKey 每次都不一样

// 这样创建出来的每次都不一样，hot reload 时 widget 的状态就丢了
// ColorBox(key: UniqueKey(), color: Colors.blue)
// 但能把它保存下来，widget 刷新的时候 key 就不会变了
final keyRed = UniqueKey();
final keyBlue = UniqueKey();

// 这三种 local key，当 widget 层级发生一丝变化，就找不到了，匹配不成功，比如用 Center 把某个包起来，状态就丢失了

// 通常用 GlobalKey 的这三个属性
// currentContext currentState currentWidget
// final state = gKeyBlue.currentState as _ColorBoxState;
// state.count++; // 还能改变状态的值
// state.setState(() {});
final gKeyRed = GlobalKey();
final gKeyBlue = GlobalKey();

// 泛型必须是个 State<StatefulWidget> 类型
// currentState 本来是 State<StatefulWidget>，变成 _ColorBoxState
final GlobalKey<_ColorBoxState> navigatorKey = GlobalKey<_ColorBoxState>();
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// MaterialApp.router(
//   routerConfig: router,
//   navigatorKey: navigatorKey,
// )

class Key1Page extends StatelessWidget {
  const Key1Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100),

        // Container(width: 100, height: 100, color: Colors.red),
        // Container(width: 100, height: 100, color: Colors.blue),
        // ColorBox(key: ValueKey(1), color: Colors.red),
        // Center(
        //   child: ColorBox(key: ValueKey(2), color: Colors.blue),
        // ),
        ColorBox(key: gKeyRed, color: Colors.red),
        ColorBox(key: gKeyBlue, color: Colors.blue),

        // Center(
        //   child: ColorBox(key: gKeyBlue, color: Colors.blue),
        // ),

        // ColorBox(key: UniqueKey(), color: Colors.blue),
        // ColorBox(key: UniqueKey(), color: Colors.red),
        // ColorBox(key: keyBlue, color: Colors.blue),
        // ColorBox(key: keyRed, color: Colors.red),
        ElevatedButton(
          onPressed: () {
            final state = gKeyBlue.currentState as _ColorBoxState;
            print(state.count);
          },
          child: Text("doit"),
        ),
      ],
    );
  }
}

class ColorBox extends StatefulWidget {
  const ColorBox({super.key, required this.color});

  final Color color;

  @override
  State<ColorBox> createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      color: widget.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$count', style: TextStyle(color: Colors.white)),
          IconButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
