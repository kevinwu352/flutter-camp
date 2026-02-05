import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/storage/storage.dart';
import '/ui/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [IconButton(onPressed: () => context.push(Routes.settings), icon: Icon(Icons.settings))],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final secures = context.read<Secures>();
            secures.lastUsername = 'kevin';
            secures.accessToken = '123456';
            context.go(Routes.home);
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
