import 'package:flutter/material.dart';

// 文档说必须设 text direction，如果用 MaterialApp 的话，它帮你设了
// runApp(Text("Hello, world!", textDirection: TextDirection.ltr));

// ================================================================================
// Text 参数

// TextStyle? style
// StrutStyle? strutStyle
// TextHeightBehavior? textHeightBehavior
//
// 当 TextStyle.height 为空时，行高是字体定义的；当 TextStyle.height = n 时，行高是 fontSize * n
// 且 null 时的行高不一定等于 1 时的行高
//
// TextStyle.height 改变后，字体并不会变大，只是上下空间变多了，如何分配上下空间？
//   TextHeightBehavior.applyHeightToFirstAscent 和 TextHeightBehavior.applyHeightToLastDescent
// 多行文字时，不管 TextHeightBehavior 设置的是什么，两行之间的空间是 上一行的 descent + 下一行的 ascent
// TextHeightBehavior 的作用仅体现在 第一行前 和 最后一行后
// TextHeightBehavior 的值为 false 时，用字体原来的 ascent，而不是 0，这一定要注意

// TextAlign? textAlign
// TextDirection? textDirection

// int? maxLines
// bool? softWrap
// TextOverflow? overflow

// Color? selectionColor
// 选中部分的颜色，不是左右那两个柄

// TextWidthBasis? textWidthBasis
// 前提：父给了约束
//   .parent 当文字是单行时，和文字一样宽；当文字是多行时，和父的约束那样宽。默认是这
//   .longestLine 文字肯定无法刚好满足父的宽，所以每行文字肯定都比父的宽度小。这通常用于做聊天那种泡泡

// TextScaler? textScaler
// 系统设置 Accessibility 时，用这参数来缩放字典
// 传 TextScaler.linear(2)，行高会变成 2 倍

// Locale? locale

// String? semanticsLabel
// String? semanticsIdentifier

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
    // );
  }
}
