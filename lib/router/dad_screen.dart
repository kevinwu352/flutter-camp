import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DadScreen extends StatelessWidget {
  // DadScreen({super.key}) {
  //   print("dad init");
  // }
  DadScreen({super.key, required this.name}) {
    print('son init');
  }
  final String? name;
  // final String? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DAD")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      // body: Text('name: $name $age'),
      body: Text('data'),
    );
  }
}

class SonScreen extends StatelessWidget {
  SonScreen({super.key}) {
    print("son init");
  }
  // const SonScreen({super.key, required this.name, required this.age});
  // final String? name;
  // final String? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SON")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      // body: Text('name: $name $age'),
      body: Text('data'),
    );
  }
}
