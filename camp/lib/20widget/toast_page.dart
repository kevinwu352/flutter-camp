import 'package:flutter/material.dart';
// import 'package:bot_toast/bot_toast.dart';
import 'toast_widget.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toast')),
      body: Center(
        child: TextButton(
          onPressed: () {
            //
            // BotToast.showText(text: 'text');
            // context.showTextToast('asdf', duration: Duration(seconds: 3000));
            context.showTextToast(
              'the period during which something exists, lasts, or is in progress',
              // duration: Duration(seconds: 3000),
            );
          },
          child: Text('doit'),
        ),
      ),
    );
  }
}
