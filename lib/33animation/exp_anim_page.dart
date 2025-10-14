import 'package:flutter/material.dart';

class ExpAnimPage extends StatefulWidget {
  const ExpAnimPage({super.key});

  @override
  State<ExpAnimPage> createState() => _ExpAnimPageState();
}

class _ExpAnimPageState extends State<ExpAnimPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // animation.addListener(() => print('c, ${animation.value}'));
    // animation.addStatusListener((status) => print('c, $status'));
    // anim.addListener(() => print('a, ${anim.value}'));
    // anim.addStatusListener((status) => print('a, $status'));

    // 用法一，动画 -> 区间
    // anim = animation.drive(tween);

    // 用法二，区间 -> 动画
    // anim = tween.animate(animation);

    // 用法一，动画 -> 区间
    // 修改了动画曲线
    // final curvedTween = tween.chain(CurveTween(curve: Curves.easeInOut));
    // anim = animation.drive(curvedTween);

    // 用法二，区间 -> 动画
    // 修改了动画曲线
    final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
    anim = tween.animate(curvedAnimation);
  }

  // 定义 时间/曲线
  late AnimationController animation = AnimationController(duration: Duration(seconds: 2), vsync: this);
  // 定义 区间
  late Tween<Offset> tween = Tween(begin: Offset.zero, end: Offset(2, 0));

  // 最终界面上用的动画
  late Animation<Offset> anim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explicit Animation')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animation.forward();
        },
        child: Icon(Icons.run_circle),
      ),
      // SlideTransition 收到松约束，尺寸 50，但 Inspector 里面看到它的边框是黄色的，为何？
      body: SlideTransition(position: anim, child: FlutterLogo(size: 50.0)),
    );
  }
}
