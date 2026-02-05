import 'dart:async';
import 'package:flutter/material.dart';

class MemTimerPage extends StatefulWidget {
  const MemTimerPage({super.key});

  @override
  State<MemTimerPage> createState() => _MemTimerPageState();
}

class _MemTimerPageState extends State<MemTimerPage> {
  // 没使用当前类的任何东西，所以不会阻碍当前类的释放
  // 当前页面退出后，计时器会继续运行，除非在 dispose 中调用 cancel
  // final timer = Timer.periodic(Duration(seconds: 2), (timer) => print('cb'));

  // 不重复的计时器效果类似
  // final timer = Timer(Duration(seconds: 20), () => print('called'));

  // 访问了当前类的 成员/this，当前页面退出后，计时器会继续运行，当前类释放不了，除非在 dispose 中调用 cancel
  late Timer timer;
  // final value = 1;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) => print('cb, $this'));
  }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer')),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                //
              },
              child: Text('start'),
            ),
          ],
        ),
      ),
    );
  }
}
