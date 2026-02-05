import 'package:flutter/material.dart';

// 不启动动画，退出页面时，Widget/State/Controller 都能正常释放
// 启动动画，且动画未完成，如果调用了 dispose，都能正常释放，否则会抛出异常
// 启动动画，且动画已完成，调不调 dispose 都能正常释放

class MemAnimPage extends StatefulWidget {
  const MemAnimPage({super.key});

  @override
  State<MemAnimPage> createState() => _MemAnimPageState();
}

class _MemAnimPageState extends State<MemAnimPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    anim = tween.animate(animation);
  }

  // @override
  // void dispose() {
  //   animation.dispose();
  //   super.dispose();
  // }

  late AnimationController animation = AnimationController(duration: Duration(seconds: 2), vsync: this);
  late Tween<double> tween = Tween(begin: 0, end: 200);

  late Animation<double> anim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anim')),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(onPressed: () => animation.forward(), child: Text('start')),
            AnimatedBuilder(
              animation: anim,
              builder: (context, child) => Container(width: anim.value, height: anim.value, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
