import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

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
            BotToast.showText(text: 'text');
          },
          child: Text('doit'),
        ),
      ),
    );
  }
}
