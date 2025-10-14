import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _controller.addListener(() => print('c, ${_controller.value}'));
    _controller.addStatusListener((status) => print('c, $status'));

    _animation.addListener(() => print('a, ${_animation.value}'));
    _animation.addStatusListener((status) => print('a, $status'));
  }

  late final AnimationController _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  // ..repeat(reverse: true);

  // late final Animation<Offset> _animation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));

  late final Animation<Offset> _animation = Tween(begin: Offset.zero, end: Offset(2, 0)).animate(_controller);

  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() => offset = Offset(2, 2));
          _controller.forward();
        },
        child: Icon(Icons.run_circle),
      ),
      body: SlideTransition(position: _animation, child: FlutterLogo(size: 50.0)),
    );
  }
}
