import 'package:flutter/material.dart';
// import 'package:flutter_camp/layout/scroll_widget.dart';

import 'zlist_widget.dart';

final strlong = 'children are placed next to each other from left to right within the available horizontal space';

final redbg = TextStyle(backgroundColor: Colors.red);

class FramePage extends StatelessWidget {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frame')),

      body: ListWidget(
        // color: Colors.green,
        // padding: EdgeInsetsGeometry.all(20),
        footer: Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: ElevatedButton(onPressed: () {}, child: Text('Done')),
        ),
        children: [
          Text(strlong, style: redbg),
          FlutterLogo(size: 100),
          ...List.generate(70, (i) => Text('data $i', style: redbg)),
          Text(strlong, style: redbg),
          // Text('data', style: redbg),
        ],
      ),
      // body: ScrollWidget(
      //   color: Colors.green,
      //   // footer: Container(
      //   //   padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      //   //   child: ElevatedButton(onPressed: () {}, child: Text('Done')),
      //   // ),
      //   children: [
      //     // Text(strlong, style: redbg),
      //     // FlutterLogo(size: 100),
      //     // ...List.generate(70, (i) => Text('data $i', style: redbg)),
      //     // Text(strlong, style: redbg),
      //     Text('data', style: redbg),
      //   ],
      // ),

      // list 无底
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     Container(color: Colors.green),
      //     ListView(
      //       physics: BouncingScrollPhysics(),
      //       // padding: padding,
      //       children: [
      //         Text(strlong, style: redbg),
      //         FlutterLogo(size: 100),
      //         ...List.generate(70, (i) => Text('data $i', style: redbg)),
      //         Text(strlong, style: redbg),
      //         // Text('data', style: redbg),
      //       ],
      //     ),
      //   ],
      // ),

      // list 有底
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     Container(color: Colors.green),
      //     SafeArea(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: [
      //           ElevatedButton(onPressed: () {}, child: Text('Done')),
      //           Expanded(
      //             child: ListView(
      //               physics: BouncingScrollPhysics(),
      //               // padding: padding,
      //               children: [
      //                 // Text(strlong, style: redbg),
      //                 // FlutterLogo(size: 100),
      //                 // ...List.generate(70, (i) => Text('data $i', style: redbg)),
      //                 // Text(strlong, style: redbg),
      //                 Text('data', style: redbg),
      //               ],
      //             ),
      //           ),
      //           ElevatedButton(onPressed: () {}, child: Text('Done')),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),

      // scroll 无底
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     Container(color: Colors.green),
      //     SingleChildScrollView(
      //       // padding: EdgeInsetsGeometry.all(20),
      //       child: SafeArea(
      //         child: Column(
      //           children: [
      //             // Text(strlong, style: redbg),
      //             // FlutterLogo(size: 100),
      //             // ...List.generate(70, (i) => Text('data $i', style: redbg)),
      //             // Text(strlong, style: redbg),
      //             Text('data', style: redbg),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      // scroll 有底
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     Container(color: Colors.green),
      //     SafeArea(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: [
      //           ElevatedButton(onPressed: () {}, child: Text('Done')),
      //           Expanded(
      //             child: SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   Text(strlong, style: redbg),
      //                   FlutterLogo(size: 100),
      //                   ...List.generate(70, (i) => Text('data $i', style: redbg)),
      //                   Text(strlong, style: redbg),
      //                   // Text('data', style: redbg),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           ElevatedButton(onPressed: () {}, child: Text('Done')),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
