import 'package:flutter/material.dart';

var count = 2;

class ReenterPage extends StatelessWidget {
  const ReenterPage({super.key});

  void doit1() async {
    print('begin 1, $count');
    await Future.delayed(Duration(seconds: 5));
    print('end 1, $count');
  }

  void doit2() async {
    print('begin 2, $count');
    await Future.delayed(Duration(seconds: 2));
    count = 1;
    print('end 2, $count');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reenter')),
      body: Center(
        child: TextButton(
          onPressed: () {
            doit1();
            doit2();
          },
          child: Text('111'),
        ),
      ),
    );
  }
}
