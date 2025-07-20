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
          // Container(
          //   width: 200,
          //   height: 200,
          //   color: Colors.lightGreen,
          //   child:
          //       // Text(
          //       //   "abc",
          //       //   style: TextStyle(
          //       //     color: Colors.purple,
          //       //     foreground: Paint()..color = Colors.blue,
          //       //     backgroundColor: Colors.teal,
          //       //   ),
          //       // ),
          //       Text(
          //         "this is your dad, come on get it.",
          //         style: TextStyle(
          //           fontSize: 20,
          //           backgroundColor: Colors.red,
          //           height: 4,
          //           // leadingDistribution: TextLeadingDistribution.proportional,
          //         ),
          //         textHeightBehavior: TextHeightBehavior(
          //           applyHeightToFirstAscent: false,
          //           applyHeightToLastDescent: false,
          //           leadingDistribution: TextLeadingDistribution.proportional,
          //         ),
          //       ),
          // ),
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
          // RichText(
          //   textAlign: TextAlign.justify,
          //   overflow: TextOverflow.fade,
          //   maxLines: 3,
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: 'Already have an account',
          //         style: TextStyle(fontSize: 16, letterSpacing: 0.5),
          //       ),
          //       TextSpan(
          //         text: 'Login Here',
          //         style: TextStyle(
          //           fontSize: 16,
          //           letterSpacing: 0.5,
          //           color: Colors.blueAccent,
          //           fontWeight: FontWeight.w600,
          //           decoration: TextDecoration.underline,
          //         ),
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () {
          //             print('abc');
          //           },
          //       ),
          //     ],
          //   ),
          // ),
          // Text.rich(
          //   style: DefaultTextStyle.of(context).style..color,
          //   TextSpan(
          //     children: [
          //       TextSpan(
          //         text: 'Already have an account',
          //         style: TextStyle(fontSize: 16, letterSpacing: 0.5),
          //       ),
          //       TextSpan(
          //         text: 'Login Here',
          //         style: TextStyle(
          //           fontSize: 16,
          //           letterSpacing: 0.5,
          //           color: Colors.red,
          //           fontWeight: FontWeight.w600,
          //           fontFamily: 'Gilroy',
          //           fontStyle: FontStyle.italic,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Row(
          //   children: <Widget>[
          //     Container(
          //       color: Colors.green,
          //       child: const Text("ABC", style: TextStyle(fontSize: 32.0)),
          //     ),
          //     Container(
          //       color: Colors.red,
          //       child: const Text("あいう", style: TextStyle(fontSize: 32.0)),
          //     ),
          //   ],
          // ),
          Row(
            children: <Widget>[
              Container(
                color: Colors.green,
                child: const Text(
                  "ABC",
                  style: TextStyle(fontSize: 16.0),
                  // strutStyle: StrutStyle(fontSize: 16.0, height: 1.3),
                ),
              ),
              Container(
                color: Colors.red,
                child: const Text(
                  "あいう",
                  style: TextStyle(fontSize: 16.0),
                  // strutStyle: StrutStyle(fontSize: 16.0, height: 1.3),
                ),
              ),
            ],
          ),
    );
  }
}
