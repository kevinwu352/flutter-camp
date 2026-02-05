import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/storage/storage.dart';
import '/ui/router.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboard'),
        actions: [IconButton(onPressed: () => context.push(Routes.settings), icon: Icon(Icons.settings))],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final secures = context.read<Secures>();
            secures.didOnboard();
            context.go(secures.showLogin ? Routes.login : Routes.home);
          },
          child: Text('Enter'),
        ),
      ),
    );
  }
}
