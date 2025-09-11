import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// 文档说必须设 text direction，如果用 MaterialApp 的话，它帮你设了
// runApp(Text("Hello, world!", textDirection: TextDirection.ltr));

// ================================================================================
// Text 参数

// TextStyle? style
// StrutStyle? strutStyle
//
// TextAlign? textAlign
// TextDirection? textDirection
//
// int? maxLines
// bool? softWrap
// TextOverflow? overflow

// Color? selectionColor
// 选中部分的颜色，不是左右那两个柄

// TextHeightBehavior? textHeightBehavior
// 设置 height 后要不要显示上下的 leading，只管第一最后，多行的中间一直是显示的

// TextWidthBasis? textWidthBasis
// 前提：父给了约束
//   .parent 当文字是单行时，和文字一样宽；当文字是多行时，和父的约束那样宽。默认是这
//   .longestLine 文字肯定无法刚好满足父的宽，所以每行文字肯定都比父的宽度小。这通常用于做聊天那种泡泡

// TextScaler? textScaler
// 系统设置 Accessibility 时，用这参数来缩放字典
// 传 TextScaler.linear(2)，行高会变成 2 倍

// Locale? locale
//
// String? semanticsLabel
// String? semanticsIdentifier

// ================================================================================
// TextStyle 参数

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text')),
      body: Column(
        children: [
          // 单行，完全展示
          // 用 clip|ellipsis 根据实际情况，默认好像是 clip
          // 后俩属性没必要设置，看心情吧
          Text('abc', softWrap: false, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end),
          // 这个效果一样，但是受 TextStyle 和 DefaultTextStyle 影响
          Text('Setting maxLines to 1 is not equivalent to disabling soft wrapping.', softWrap: false),

          // 单行，有宽度限制
          // TextOverflow.clip 直接把末尾的部分切掉。软换行时，没啥变化
          // TextOverflow.ellipsis 末尾添加省略号。软换行时，没啥变化，省略号还是在右边
          // TextOverflow.fade 会在末尾有一点点变淡的效果，逐渐变成完全透明。软换行时，渐变到下边去了
          // TextOverflow.visible 超过边界的部分也能被看见。软换行时，超出部分看不见了，右边和下边都看不见
          Container(
            width: 110,
            decoration: BoxDecoration(border: Border.all()),
            child: Text('Hello, how are you?', softWrap: false, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),

          // 两行，肯定有宽度限制的
          // 经测试 softWrap 默认是真
          // clip 时，此时软换行是真，所以超出第二行的内容在第三行，只是看不见，所以这种模式不可能露出半个单词
          // ellipsis 时，如果内容没把第二行占满，末尾没有省略号
          // fade 时，如果内容没把第二行占满，下边不会有渐变
          // visible 时，超过下边界的部分看不见
          Container(
            width: 150,
            decoration: BoxDecoration(border: Border.all()),
            child: Text(
              'Setting maxLines to 1 is not equivalent to disabling soft wrapping.',
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // 多行，完全展示
          // 其它模式没啥特别的，但 ellipsis 居然不换行了，而是在末尾加上省略号
          Text('Setting maxLines to 1 is not equivalent to disabling soft wrapping.'),

          // ================================================================================

          // 横排两个 Text 如何分配空间？空间太多时拉谁？空间不够时压谁？

          // ================================================================================

          // Text 接受的参数是 String，RichText 接受的参数是 TextSpan
          Text.rich(
            // 这里有一堆其它参数，参数类似 Text
            // style: TextStyle(), 里面的样式会覆盖这里的
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

          // 有父样式，子继承样式，但修改了字号
          DefaultTextStyle(
            style: TextStyle(fontSize: 14, color: Colors.red),
            child: Text('111', style: TextStyle(fontSize: 30)),
          ),
          // 有父样式，子继承样式
          // TextSpan 里面和外面都能修改样式
          DefaultTextStyle(
            style: TextStyle(fontSize: 14, color: Colors.green),
            child: Text.rich(TextSpan(text: '222')),
          ),
          // 有父样式，但 RichText 没继承，而且界面上看不到 333
          DefaultTextStyle(
            style: DefaultTextStyle.of(
              context,
            ).style.copyWith(fontSize: 30, color: Colors.purple), //TextStyle(fontSize: 14, color: Colors.blue),
            child: RichText(
              text: TextSpan(
                text: '333',
                // 加上这行能看见 333，但有黄线
                style: DefaultTextStyle.of(context).style,
                // 加上这行能看见 333，但有黄线，且字号和颜色都起作用了
                // style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30, color: Colors.purple),
                // 下级也看不见
                // children: [TextSpan(text: '444')],
              ),
            ),
          ),

          // RichText(
          //   text: TextSpan(
          //     // text: 'inherit no',
          //     style: DefaultTextStyle.of(context).style,
          //     children: [TextSpan(text: '123', style: TextStyle(fontSize: 14))],
          //   ),
          // ),

          // ================================================================================

          // 设置文字背景色
          // 如果是多行文字，TextStyle 的背景色可能是参差不齐的，第一行宽 100，第二行宽 80，第三行宽 110
          Text('abc', style: TextStyle(backgroundColor: Colors.blue)),
          Container(color: Colors.purple, child: Text('abc')),

          // 让文字能选中
          // selectionColor 选中部分的颜色，不是左右那两个柄
          // 要让中间部分选中不了，用 SelectionContainer.disabled(child: Text('Non-selectable text'))
          SelectionArea(child: Text('Selectable text', selectionColor: Colors.red)),

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

    // return Scaffold(
    //   appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text("Text")),
    //   body:
    //       // Text(
    //       //   "This is a pretty long text.",
    //       //   textAlign: TextAlign.center,
    //       //   overflow: TextOverflow.ellipsis,
    //       //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    //       // ),
    //       // Container(
    //       //   width: 200,
    //       //   height: 200,
    //       //   color: Colors.lightGreen,
    //       //   child:
    //       //       // Text(
    //       //       //   "abc",
    //       //       //   style: TextStyle(
    //       //       //     color: Colors.purple,
    //       //       //     foreground: Paint()..color = Colors.blue,
    //       //       //     backgroundColor: Colors.teal,
    //       //       //   ),
    //       //       // ),
    //       //       Text(
    //       //         "this is your dad, come on get it.",
    //       //         style: TextStyle(
    //       //           fontSize: 20,
    //       //           backgroundColor: Colors.red,
    //       //           height: 4,
    //       //           // leadingDistribution: TextLeadingDistribution.proportional,
    //       //         ),
    //       //         textHeightBehavior: TextHeightBehavior(
    //       //           applyHeightToFirstAscent: false,
    //       //           applyHeightToLastDescent: false,
    //       //           leadingDistribution: TextLeadingDistribution.proportional,
    //       //         ),
    //       //       ),
    //       // ),
    //       // Container(
    //       //   width: 100,
    //       //   decoration: BoxDecoration(border: Border.all()),
    //       //   child: Text(
    //       //     'Hello, how are you?',
    //       //     // maxLines: 1,
    //       //     // softWrap: false,
    //       //     // overflow: TextOverflow.ellipsis,
    //       //     // style: TextStyle(backgroundColor: Colors.red),
    //       //     // textAlign: TextAlign.start,
    //       //     // textDirection: TextDirection.rtl,
    //       //     textScaleFactor: 2,
    //       //   ),
    //       // ),
    //       // RichText(
    //       //   textAlign: TextAlign.justify,
    //       //   overflow: TextOverflow.fade,
    //       //   maxLines: 3,
    //       //   text: TextSpan(
    //       //     children: [
    //       //       TextSpan(
    //       //         text: 'Already have an account',
    //       //         style: TextStyle(fontSize: 16, letterSpacing: 0.5),
    //       //       ),
    //       //       TextSpan(
    //       //         text: 'Login Here',
    //       //         style: TextStyle(
    //       //           fontSize: 16,
    //       //           letterSpacing: 0.5,
    //       //           color: Colors.blueAccent,
    //       //           fontWeight: FontWeight.w600,
    //       //           decoration: TextDecoration.underline,
    //       //         ),
    //       //         recognizer: TapGestureRecognizer()
    //       //           ..onTap = () {
    //       //             print('abc');
    //       //           },
    //       //       ),
    //       //     ],
    //       //   ),
    //       // ),
    //       // Text.rich(
    //       //   style: DefaultTextStyle.of(context).style..color,
    //       //   TextSpan(
    //       //     children: [
    //       //       TextSpan(
    //       //         text: 'Already have an account',
    //       //         style: TextStyle(fontSize: 16, letterSpacing: 0.5),
    //       //       ),
    //       //       TextSpan(
    //       //         text: 'Login Here',
    //       //         style: TextStyle(
    //       //           fontSize: 16,
    //       //           letterSpacing: 0.5,
    //       //           color: Colors.red,
    //       //           fontWeight: FontWeight.w600,
    //       //           fontFamily: 'Gilroy',
    //       //           fontStyle: FontStyle.italic,
    //       //         ),
    //       //       ),
    //       //     ],
    //       //   ),
    //       // ),
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
    // );
  }
}
