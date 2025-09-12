import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class StyleWidget extends StatelessWidget {
  const StyleWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = DefaultTextStyle.of(context).style;
    return Text(name);
  }
}

class StylePage extends StatelessWidget {
  const StylePage({super.key});

  @override
  Widget build(BuildContext context) {
    // App 里面创建 ThemeData 时，里面的 colorScheme 有值，且贯穿整个 App 都不变，实例的地址一直没变
    // 但 textTheme 实例变了，前面刚创建的时候，里面的 style 没有 fontSize，在这里获取出来才看到有了
    // final themeData = Theme.of(context);
    // final colorScheme = themeData.colorScheme;
    // final textTheme = themeData.textTheme;
    // final textStyle = DefaultTextStyle.of(context).style;
    return Scaffold(
      appBar: AppBar(title: Text('Style')),
      body: Column(
        children: [
          // 里面得到的是 bodyMedium 样式
          StyleWidget(name: '1aaa'),
          // 里面得到的样式只有字号
          DefaultTextStyle(
            style: TextStyle(fontSize: 31),
            child: StyleWidget(name: '2bbb'),
          ),
          // 里面得到的是 bodyLarge 样式
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!,
            child: StyleWidget(name: '3ccc'),
          ),
          // 里面得到的是 fallback 样式，也就是双黄线那种
          // 可见 DefaultTextStyle.of 获取的一定是它上面的另一个 DefaultTextStyle 提供的样式，而不是周围环境的样式
          DefaultTextStyle(
            style: DefaultTextStyle.of(context).style,
            child: StyleWidget(name: '4ddd'),
          ),
          // 里面得到的是 bodyMedium 样式
          // 可见 DefaultTextStyle.merge 会获取周围环境的样式
          DefaultTextStyle.merge(child: StyleWidget(name: '5eee')),
          // 里面得到的是 bodyMedium 样式，但修改了部分属性
          DefaultTextStyle.merge(
            style: TextStyle(color: Colors.red),
            child: StyleWidget(name: '6fff'),
          ),

          // ================================================================================

          // RichText 不继承周围环境的样式，Text.rich 会继承
          // RichText 顶层无 style，Text.rich 可以设置个 base style
          // 个人感觉用 Text.rich 好一点，它会使用环境的基础样式，我只需要修改部分样式即可
          Text.rich(
            // 这里有一堆其它参数，参数类似 Text
            // style: TextStyle(), 里面的样式会和这里的合并
            TextSpan(
              // 这四个参数都是可选的
              text: 'abc',
              // style: TextStyle(),
              // recognizer: TapGestureRecognizer()..onTap = () => print('tapped'),
              // children: [],
            ),
          ),
          RichText(
            // 这里有一堆其它参数，参数类似 Text，但无 TextStyle
            text: TextSpan(
              // 这四个参数都是可选的
              // text: 'abc',
              // style: TextStyle(),
              // recognizer: TapGestureRecognizer()..onTap = () => print('tapped'),
              children: [
                TextSpan(
                  text: 'abc',
                  style: TextStyle(color: Colors.red),
                  recognizer: TapGestureRecognizer()..onTap = () => print('tapped1'),
                ),
                TextSpan(
                  text: '123',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () => print('tapped2'),
                ),
              ],
            ),
          ),

          // ================================================================================
        ],
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text('StrutStyle Example')),
    //   body: Center(
    //     child: Text(
    //       'This text uses StrutStyle to control line height and spacing.',
    //       style: TextStyle(fontSize: 20),
    //       strutStyle: StrutStyle(
    //         fontSize: 20, // Should match the TextStyle's fontSize for consistency
    //         height: 1.5, // 1.5 times the font size
    //         leading: 0, // Half of the font size as leading
    //       ),
    //     ),
    //   ),
    // );

    //       // Row(
    //       //   children: <Widget>[
    //       //     Container(
    //       //       color: Colors.green,
    //       //       child: const Text("ABC", style: TextStyle(fontSize: 32.0)),
    //       //     ),
    //       //     Container(
    //       //       color: Colors.red,
    //       //       child: const Text("あいう", style: TextStyle(fontSize: 32.0)),
    //       //     ),
    //       //   ],
    //       // ),
    //       Row(
    //         children: [
    //           Container(
    //             color: Colors.green,
    //             child: Text(
    //               "ABC",
    //               style: TextStyle(fontSize: 16.0),
    //               // strutStyle: StrutStyle(fontSize: 16.0, height: 1.3),
    //             ),
    //           ),
    //           Container(
    //             color: Colors.red,
    //             child: Text(
    //               "あいう",
    //               style: TextStyle(fontSize: 16.0),
    //               // strutStyle: StrutStyle(fontSize: 16.0, height: 1.3),
    //             ),
    //           ),
    //         ],
    //       ),
  }
}
