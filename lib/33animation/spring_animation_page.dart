import 'package:flutter/material.dart';

class SpringAnimationPage extends StatefulWidget {
  const SpringAnimationPage({super.key});

  @override
  State<SpringAnimationPage> createState() => _SpringAnimationPageState();
}

class _SpringAnimationPageState extends State<SpringAnimationPage> with SingleTickerProviderStateMixin {
  late final animation = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final tween1 = Tween(begin: 0.0, end: 400.0).chain(CurveTween(curve: Curves.bounceOut));
  late final tween2 = Tween(begin: 0.0, end: 1.0);

  var _top = 0.0;

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Spring Animation')),
      body: Center(
        child: Stack(
          children: [
            // AnimatedBuilder(
            //   animation: animation,
            //   builder: (context, child) {
            //     return Positioned(
            //       left: 70,
            //       top: tween1.evaluate(animation),
            //       child: Opacity(
            //         opacity: tween2.evaluate(animation),
            //         child: Container(color: Colors.red, width: 100, height: 40),
            //       ),
            //     );
            //   },
            // ),
            AnimatedPositioned(
              top: _top,
              duration: Duration(milliseconds: 300),
              curve: Curves.elasticOut,
              child: Container(color: Colors.red, width: 100, height: 40),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // animation.reset();
          // animation.forward();
          setState(() => _top = 400);
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}
