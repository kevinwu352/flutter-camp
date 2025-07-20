import 'package:flutter/material.dart';

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
            color: Colors.lightGreen,
            child:
                // Text(
                //   "abc",
                //   style: TextStyle(
                //     color: Colors.purple,
                //     foreground: Paint()..color = Colors.blue,
                //     backgroundColor: Colors.teal,
                //   ),
                // ),
                Text(
                  "this is your dad, come on get it.",
                  style: TextStyle(
                    fontSize: 20,
                    backgroundColor: Colors.red,
                    height: 4,
                    // leadingDistribution: TextLeadingDistribution.proportional,
                  ),
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                    leadingDistribution: TextLeadingDistribution.proportional,
                  ),
                ),
          ),
      // Container(
      //   width: 100,
      //   decoration: BoxDecoration(border: Border.all()),
      //   child: Text(
      //     'Hello, how are you?',
      //     // maxLines: 1,
      //     // softWrap: false,
      //     // overflow: TextOverflow.ellipsis,
      //     // style: TextStyle(backgroundColor: Colors.red),
      //     // textAlign: TextAlign.start,
      //     // textDirection: TextDirection.rtl,
      //     textScaleFactor: 2,
      //   ),
      // ),
    );
  }
}
