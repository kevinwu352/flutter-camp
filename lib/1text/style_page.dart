import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// TextStyle.copyWith 参数和创建时差不多
// TextStyle.apply 主要是用 factor 去修改样式，而不是直接修改值

// color / backgroundColor 是 foreground / background 的短形式，不能同时设置，会崩
// Text("abc",
//   style: TextStyle(backgroundColor: Colors.blue), 短形式
//   style: TextStyle(background: Paint()..color = Colors.blue), 完整形式
// )

// ================================================================================
// TextStyle 参数

// double? fontSize
// FontWeight? fontWeight
// FontStyle? fontStyle 是否斜体
// String? fontFamily 自定义字体
// List<String>? fontFamilyFallback ['Noto Sans CJK SC', 'Noto Color Emoji'] 找不到字体时的后备
// String? package

// Color? color
// Color? backgroundColor
// Paint? foreground
// Paint? background

// TextOverflow? overflow [in_text_too]

// double? letterSpacing 像素值，负数会重叠
// double? wordSpacing 像素值，负数会重叠

// double? height
// TextLeadingDistribution? leadingDistribution,
// TextBaseline? textBaseline 不清楚作用？

// TextDecoration? decoration 上中下划线
// Color? decorationColor
// TextDecorationStyle? decorationStyle
// double? decorationThickness
//
// List<Shadow>? shadows

// String? debugLabel
//
// Locale? locale
//
// List<FontFeature>? fontFeatures
// 上标/下标/小一点的大写字母，等等
// 这也只是开关字体的某个特性
// List<FontVariation>? fontVariations
// 字重/斜体/宽度，等等
// 精细化控制，前面的斜体，只能开关，这里能控制斜多少

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
          // // 里面得到的是 bodyMedium 样式
          // StyleWidget(name: '1aaa'),

          // // 里面得到的样式只有字号
          // DefaultTextStyle(
          //   style: TextStyle(fontSize: 31),
          //   child: StyleWidget(name: '2bbb'),
          // ),

          // // 里面得到的是 bodyLarge 样式
          // DefaultTextStyle(
          //   style: Theme.of(context).textTheme.bodyLarge!,
          //   child: StyleWidget(name: '3ccc'),
          // ),

          // // 里面得到的是 fallback 样式，也就是双黄线那种
          // // 可见 DefaultTextStyle.of 获取的一定是它上面的另一个 DefaultTextStyle 提供的样式，而不是周围环境的样式
          // DefaultTextStyle(
          //   style: DefaultTextStyle.of(context).style,
          //   child: StyleWidget(name: '4ddd'),
          // ),

          // // 里面得到的是 bodyMedium 样式
          // // 可见 DefaultTextStyle.merge 会获取周围环境的样式
          // DefaultTextStyle.merge(child: StyleWidget(name: '5eee')),

          // // 里面得到的是 bodyMedium 样式，但修改了部分属性
          // DefaultTextStyle.merge(
          //   style: TextStyle(color: Colors.red),
          //   child: StyleWidget(name: '6fff'),
          // ),

          // ================================================================================

          // // RichText 不继承周围环境的样式，Text.rich 会继承
          // // RichText 顶层无 style，Text.rich 可以设置个 base style
          // // 个人感觉用 Text.rich 好一点，它会使用环境的基础样式，我只需要修改部分样式即可
          // Text.rich(
          //   // 这里有一堆其它参数，参数类似 Text
          //   // style: TextStyle(), 里面的样式会和这里的合并
          //   TextSpan(
          //     // 这四个参数都是可选的
          //     text: 'abc',
          //     // style: TextStyle(),
          //     // recognizer: TapGestureRecognizer()..onTap = () => print('tapped'),
          //     // children: [],
          //   ),
          // ),
          // RichText(
          //   // 这里有一堆其它参数，参数类似 Text，但无 TextStyle
          //   text: TextSpan(
          //     // 这四个参数都是可选的
          //     // text: 'abc',
          //     // style: TextStyle(),
          //     // recognizer: TapGestureRecognizer()..onTap = () => print('tapped'),
          //     children: [
          //       TextSpan(
          //         text: 'abc',
          //         style: TextStyle(color: Colors.red),
          //         recognizer: TapGestureRecognizer()..onTap = () => print('tapped1'),
          //       ),
          //       TextSpan(
          //         text: '123',
          //         style: TextStyle(color: Colors.blue),
          //         recognizer: TapGestureRecognizer()..onTap = () => print('tapped2'),
          //       ),
          //     ],
          //   ),
          // ),

          // ================================================================================

          // 高度 20
          // Text('jKfa'),

          // 高度 14 * 1 = 14
          // Text('jKfb', style: TextStyle(height: 1)),

          // 高度 17，算算怎么来的，有点怪？
          // 原来高 20，fontSize 14，所以上下是 3
          // 文档说：当 textHeightBehavior 都为 false 时，用字体原来的 ascent，而不是 0，这一定要注意
          // 所以 14 + 3 = 17，这 3 应该就是字体的 ascent + descent
          // Text(
          //   'jKfc',
          //   style: TextStyle(height: 1, backgroundColor: Colors.blue),
          //   textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
          // ),
          // 经过观察，以 height = 1 为基准，它的高度是 14
          // height = null 时，上下边各增加 3，加起来刚好是 20
          // height = 1，且两个 false 时，上边增加 1，下边增加 2，加起来是 17
          // 仔细去研究那张图，b 的内容伸出去了，c 的背景色没填充满，没太搞懂

          // TextHeightBehavior 那两个属性决定上下边要不要显示空间，而下面这个属性决定上下如何分配空间
          // 空间有多少？height * fontSize - fontSize，也就是除开字体要占用的，其它的就是空间
          // TextHeightBehavior.leadingDistribution.proportional 按 ascent/descent 的比例分
          // TextHeightBehavior.leadingDistribution.even 平均分
          // 实测中，上下都是均分的，也许是字体的原因吧
          Text(
            'jKf',
            style: TextStyle(height: 1, backgroundColor: Colors.red),
            textHeightBehavior: TextHeightBehavior(leadingDistribution: TextLeadingDistribution.proportional),
          ),
          Text(
            'jKf',
            style: TextStyle(height: 2, backgroundColor: Colors.green),
            textHeightBehavior: TextHeightBehavior(leadingDistribution: TextLeadingDistribution.proportional),
          ),
          Text(
            'jKf',
            style: TextStyle(height: 4, backgroundColor: Colors.blue),
            textHeightBehavior: TextHeightBehavior(leadingDistribution: TextLeadingDistribution.proportional),
          ),

          // ================================================================================
          Container(
            width: 200,
            color: Colors.yellow,
            child: Column(
              children: [
                // Text(
                //   'Setting maxLines to 1 is not equivalent to disabling soft wrapping.',
                //   // overflow: TextOverflow.clip,
                //   // style: TextStyle(height: 4),
                //   style: TextStyle(height: 4, backgroundColor: Colors.red),
                //   textHeightBehavior: TextHeightBehavior(
                //     applyHeightToFirstAscent: false,
                //     applyHeightToLastDescent: true,
                //   ),
                // ),
                // Text(
                //   'jKf1',
                //   // overflow: TextOverflow.clip,
                //   // style: TextStyle(height: 4),
                //   style: TextStyle(height: 4, backgroundColor: Colors.red),
                //   textHeightBehavior: TextHeightBehavior(
                //     applyHeightToFirstAscent: true,
                //     applyHeightToLastDescent: true,
                //   ),
                // ),
                // Text(
                //   'jKf2',
                //   // overflow: TextOverflow.clip,
                //   // style: TextStyle(height: 4),
                //   style: TextStyle(height: 4, backgroundColor: Colors.green),
                //   textHeightBehavior: TextHeightBehavior(
                //     applyHeightToFirstAscent: true,
                //     applyHeightToLastDescent: false,
                //   ),
                // ),
                // Text(
                //   'jKf3',
                //   // overflow: TextOverflow.clip,
                //   // style: TextStyle(height: 4),
                //   style: TextStyle(height: 4, backgroundColor: Colors.blue),
                //   textHeightBehavior: TextHeightBehavior(
                //     applyHeightToFirstAscent: false,
                //     applyHeightToLastDescent: true,
                //   ),
                // ),
                Text('jKf1'), // 高度 20
                Text('jKf2', style: TextStyle(height: 1)), // 高度 14 * 2 = 28，但文字没变大，上下空间变大了
                Text(
                  'jKf4',
                  // overflow: TextOverflow.clip,
                  // style: TextStyle(height: 4),
                  style: TextStyle(height: 1, backgroundColor: Colors.purple),
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ],
            ),
          ),
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
