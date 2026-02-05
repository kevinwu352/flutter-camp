import 'dart:collection';
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
            pattern: 'RenderEditable',
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
                Form(child: Column(children: [TextFormField()])),
                DropdownMenu<ColorLabel>(dropdownMenuEntries: ColorLabel.entries, requestFocusOnTap: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef ColorEntry = DropdownMenuEntry<ColorLabel>;

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;

  static final List<ColorEntry> entries = UnmodifiableListView<ColorEntry>(
    values.map<ColorEntry>(
      (ColorLabel color) => ColorEntry(
        value: color,
        label: color.label,
        enabled: color.label != 'Grey',
        style: MenuItemButton.styleFrom(foregroundColor: color.color),
      ),
    ),
  );
}
