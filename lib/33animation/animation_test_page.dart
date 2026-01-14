import 'package:flutter/material.dart';

class AnimationTestPage extends StatefulWidget {
  const AnimationTestPage({super.key});

  @override
  State<AnimationTestPage> createState() => _AnimationTestPageState();
}

class _AnimationTestPageState extends State<AnimationTestPage> with SingleTickerProviderStateMixin {
  late final animation = AnimationController(duration: Duration(seconds: 3), vsync: this);
  late final tween = IntTween(begin: 0, end: 29);
  late final anim = animation.drive(tween);

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Test')),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              animation.repeat();
              // animation.forward();
            },
            child: Text('repeat'),
          ),
          TextButton(
            onPressed: () {
              animation.value = 0.5;
              // animation.stop();
              // animation.reset();
            },
            child: Text('0.5'),
          ),
          TextButton(
            onPressed: () {
              // animation.repeat();
              animation.forward();
              // animation.forward(from: 0.25);

              // animation.animateTo(0.8);
              // animation.animateBack(0.2);
              // animation.reverse();
            },
            child: Text('again'),
          ),

          AnimatedBuilder(
            animation: anim,
            builder: (context, child) =>
                Image.asset('assets/loading/spinner_${anim.value}.png', width: 144, height: 144, gaplessPlayback: true),
          ),
        ],
      ),
    );
  }
}
