import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/storage/storage.dart';
import '/ui/router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              final secures = context.read<Secures>();
              secures.lastUsername = null;
              secures.accessToken = null;
              context.go(Routes.login);
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(onPressed: () => context.push(Routes.settings), icon: Icon(Icons.settings)),
        ],
      ),
      body: Center(child: Text('data')),
    );
  }
}
