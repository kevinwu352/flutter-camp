import 'package:flutter/material.dart';
import '/31event/mutex_pointer.dart';
import '/31event/swallow_pointer.dart';

class KeyboardPage extends StatelessWidget {
  const KeyboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ...
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: SizedBox.expand(
        child: Listener(
          // behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            print('down');
            FocusManager.instance.primaryFocus?.unfocus();
          },
          // child: Column(
          //   children: [
          //     IconButton(onPressed: () => print('clicked-1'), icon: Icon(Icons.run_circle)),
          //     SwallowPointer(
          //       child: IconButton(onPressed: () => print('clicked-2'), icon: Icon(Icons.run_circle)),
          //     ),
          //     TextField(decoration: InputDecoration(border: OutlineInputBorder())),
          //     SwallowPointer(
          //       child: TextField(decoration: InputDecoration(border: OutlineInputBorder())),
          //     ),
          //   ],
          // ),
          child: MutexPointer(
            child: Column(
              children: [
                IconButton(onPressed: () => print('clicked-1'), icon: Icon(Icons.run_circle)),
                SwallowPointer(
                  child: IconButton(onPressed: () => print('clicked-2'), icon: Icon(Icons.run_circle)),
                ),
                TextField(decoration: InputDecoration(border: OutlineInputBorder())),
                SwallowPointer(
                  child: TextField(decoration: InputDecoration(border: OutlineInputBorder())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
