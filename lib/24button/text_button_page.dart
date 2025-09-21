import 'package:flutter/material.dart';

// TextButton.statesController 咋用？文档里有个例子

class TextButtonPage extends StatelessWidget {
  const TextButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Button')),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            elevation: 20.0,
            // shadowColor: Colors.red,
            surfaceTintColor: Colors.red,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text('abc')),
            ),
          ),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              // backgroundColor: Colors.amber,
              textStyle: TextStyle(color: Colors.purple, fontSize: 24),
              elevation: 10,
              // shadowColor: Colors.blue,
              surfaceTintColor: Colors.green,
              // shape: OutlinedBorder
            ),
            child: Text('data'),
          ),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              // shape: CircleBorder(),
              side: BorderSide(color: Colors.red, width: 4),
              shape: CircleBorder(side: BorderSide(color: Colors.green, width: 1)),
            ),
            child: Text('abc'),
          ),

          TextButton.icon(
            onPressed: null,
            style: TextButton.styleFrom(
              iconColor: Colors.teal,
              disabledIconColor: Colors.amber,
              iconSize: 50,
              iconAlignment: IconAlignment.end,
            ),
            icon: const Icon(Icons.access_alarm),
            label: const Text('Alarm'),
          ),

          // ================================================================================
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.access_alarm),
            label: const Text('TextButton.icon #1'),
          ),

          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.red, backgroundColor: Colors.yellow),
            onPressed: () {},
            icon: const Icon(Icons.access_alarm),
            label: const Text('TextButton.icon #2'),
          ),

          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: Colors.green, width: 1),
              ),
            ),
            onPressed: () {},
            child: const Text('TextButton #3'),
          ),

          TextButton(
            style: TextButton.styleFrom(overlayColor: Colors.red),
            onPressed: () {},
            child: const Text('TextButton #4'),
          ),
        ],
      ),
    );
  }
}
