import 'package:flutter/material.dart';

// 显示 Dialog，showDialog / showAdaptiveDialog
// 文档说 showGeneralDialog 是基础，其它的基于此，它用来自定义一些细节
// barrier 是指背后的遮罩
// return showDialog<void>(
//   context: context,
//   builder: (BuildContext context) {
//     return AlertDialog( ... );
//   },
// );
// 不直接用 Dialog.new / Dialog.fullscreen，用更具体的 AlertDialog / SimpleDialog
// SimpleDialog 用来展示标题和一堆选项

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dialog')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dialogBuilder(context);
        },
        child: Icon(Icons.run_circle),
      ),
      body: Text('--'),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(Icons.settings),
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
