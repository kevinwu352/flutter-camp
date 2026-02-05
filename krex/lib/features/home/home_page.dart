import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/theme/theme.dart';
import '/ui/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.message);
            },
            icon: Icon(Icons.message),
          ),
        ],
      ),
      body: Center(
        child: Text('data', style: MyStyles.title3.copyWith(color: MyColors.viewBg(context))),
      ),
    );
  }
}
