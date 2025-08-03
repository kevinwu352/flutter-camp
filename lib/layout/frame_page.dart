import 'package:flutter/material.dart';

final strlong =
    'children are placed next to each other from left to right within the available horizontal space';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    this.color,
    this.padding,
    this.header,
    this.footer,
    required this.children,
  });

  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Widget? header;
  final Widget? footer;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final list = ListView(
      physics: BouncingScrollPhysics(),
      padding: padding,
      children: children,
    );
    if (footer is Widget || footer is Widget) {
      if (color is Color) {
        return Container(
          color: color,
          child: SafeArea(
            child: Column(
              children: [
                if (header is Widget) header!,
                Expanded(child: list),
                if (footer is Widget) footer!,
              ],
            ),
          ),
        );
      } else {
        return SafeArea(
          child: Column(
            children: [
              if (header is Widget) header!,
              Expanded(child: list),
              if (footer is Widget) footer!,
            ],
          ),
        );
      }
    } else {
      if (color is Color) {
        return Container(color: color, child: list);
      } else {
        return list;
      }
    }
  }
}

class FramePage extends StatelessWidget {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frame')),

      body: ListWidget(
        color: Colors.green,
        padding: EdgeInsetsGeometry.all(20),
        footer: ElevatedButton(onPressed: () {}, child: Text('Done')),
        children: [
          Text(strlong),
          FlutterLogo(size: 100),
          ...List.generate(70, (i) => Text('data $i')),
          Text(strlong),
        ],
      ),

      // body: ListView(
      //   physics: BouncingScrollPhysics(),
      //   padding: EdgeInsetsGeometry.all(20),
      //   children: [
      //     Text(strlong),
      //     FlutterLogo(size: 100),
      //     ...List.generate(20, (i) => Text('data $i')),
      //     Text(strlong),
      //   ],
      // ),

      // 无底部
      // body: Container(
      //   color: Colors.green,
      //   child: ListView(
      //     physics: BouncingScrollPhysics(),
      //     padding: EdgeInsetsGeometry.all(20),
      //     children: [
      //       // Text(strlong),
      //       ...List.generate(20, (i) => Text('data $i')),
      //       // Text(strlong),
      //     ],
      //   ),
      // ),

      // 有底部
      // body: Container(
      //   color: Colors.green,
      //   child: SafeArea(
      //     child: Column(
      //       children: [
      //         Expanded(
      //           child: ListView(
      //             physics: BouncingScrollPhysics(),
      //             padding: EdgeInsetsGeometry.all(20),
      //             children: [
      //               // Text(strlong),
      //               ...List.generate(20, (i) => Text('data $i')),
      //               // Text(strlong),
      //             ],
      //           ),
      //         ),
      //         ElevatedButton(onPressed: () {}, child: Text('Done')),
      //       ],
      //     ),
      //   ),
      // ),
      // body: SafeArea(
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: ListView(
      //           physics: BouncingScrollPhysics(),
      //           padding: EdgeInsetsGeometry.all(20),
      //           children: [
      //             // Text(strlong),
      //             ...List.generate(70, (i) => Text('data $i')),
      //             // Text(strlong),
      //           ],
      //         ),
      //       ),
      //       ElevatedButton(onPressed: () {}, child: Text('Done')),
      //     ],
      //   ),
      // ),

      // ================================================================================

      // 不滚动，自主排列，无底部。会溢出，安全区自己规避
      // body: Container(
      //   color: Colors.green,
      //   constraints: BoxConstraints.expand(),
      //   padding: EdgeInsetsGeometry.all(20),
      //   child: Column(children: List.generate(30, (i) => Text('data $i'))),
      // ),
      // 不滚动，自主排列，无底部。无溢出，安全区自己规避
      // body: Container(
      //   color: Colors.green,
      //   constraints: BoxConstraints.expand(),
      //   padding: EdgeInsetsGeometry.all(20),
      //   child: OverflowBox(
      //     maxHeight: double.infinity,
      //     alignment: Alignment.topCenter,
      //     child: Column(children: List.generate(60, (i) => Text('data $i'))),
      //   ),
      // ),

      // 不滚动，自主排列，有底部。会溢出，安全区规避底部
      // body: Container(
      //   color: Colors.green,
      //   constraints: BoxConstraints.expand(),
      //   child: SafeArea(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         Expanded(
      //           child: Padding(
      //             padding: EdgeInsetsGeometry.all(20),
      //             child: Column(
      //               children: List.generate(20, (i) => Text('data $i')),
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsetsGeometry.all(20),
      //           child: ElevatedButton(onPressed: () {}, child: Text('Done')),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // body: LayoutBuilder(
      //   builder: (context, constraints) {
      //     print(constraints);
      //     return Container(
      //       color: Colors.green,
      //       width: constraints.maxWidth,
      //       height: constraints.maxHeight,
      //       padding: EdgeInsetsGeometry.all(20),
      //       child: Column(
      //         children: [
      //           Text(strlong),
      //           ...List.generate(20, (i) => Text('data $i')),
      //           Text(strlong),
      //         ],
      //       ),
      //     );
      //   },
      // ),
      // body: LayoutBuilder(
      //   builder: (context, constraints) {
      //     print(constraints);
      //     return Container(
      //       color: Colors.green,
      //       width: constraints.maxWidth,
      //       height: constraints.maxHeight,
      //       padding: EdgeInsetsGeometry.all(20),
      //       child: OverflowBox(
      //         maxHeight: double.infinity,
      //         alignment: Alignment.topCenter,
      //         child: Column(
      //           children: [
      //             Text(strlong),
      //             ...List.generate(60, (i) => Text('data $i')),
      //             Text(strlong),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      // body: ListView(
      //   physics: BouncingScrollPhysics(),
      //   padding: EdgeInsetsGeometry.all(20),
      //   children: [
      //     Text(strlong),
      //     ...List.generate(70, (i) => Text('data $i')),
      //     Text(strlong),
      //   ],
      // ),

      // body: SafeArea(
      //   // child: SizedBox.expand(
      //   //   child: Column(
      //   //     children: [
      //   //       Expanded(child: Column(children: [Text('data'), Text('data')])),
      //   //       ElevatedButton(onPressed: () {}, child: Text('Done')),
      //   //     ],
      //   //   ),
      //   // ),
      //   // child: SizedBox.expand(
      //   //   child: Column(
      //   //     children: [
      //   //       Expanded(
      //   //         child: Container(
      //   //           color: Colors.grey,
      //   //           padding: EdgeInsets.all(20),
      //   //           child: Column(
      //   //             children: [
      //   //               Text('data'),
      //   //               Text(strlong),
      //   //             ],
      //   //           ),
      //   //         ),
      //   //       ),
      //   //       ElevatedButton(onPressed: () {}, child: Text('Done')),
      //   //     ],
      //   //   ),
      //   // ),
      //   child: Stack(children: [Container(color: Colors.red)]),
      // ),

      // body: SizedBox.expand(
      //   child: Column(
      //     children: [
      //       Expanded(child: Column(children: [Text('data'), Text('data')])),
      //       ElevatedButton(onPressed: () {}, child: Text('Done')),
      //     ],
      //   ),
      // ),

      // body: Column(
      //   // mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Column(
      //       mainAxisSize: MainAxisSize.max, // 为何这里拉不高？
      //       children: [Text('data'), Text('data')],
      //     ),
      //     ElevatedButton(onPressed: () {}, child: Text('Done')),
      //   ],
      // ),

      // 用 stretch 拉大，少一层，但 alignment 固定了
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Text('data', textAlign: TextAlign.center),
      //     Text('data', textAlign: TextAlign.center),
      //   ],
      // ),

      // 用 SizedBox.expand 拉大，多一层，但 alignment 自由了
      // body: SizedBox.expand(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [Text('data'), Text('data')],
      //   ),
      // ),
    );
  }
}
