import 'dart:math';
import 'package:flutter/material.dart';

class ExpAnimPage extends StatefulWidget {
  const ExpAnimPage({super.key});
  @override
  State<ExpAnimPage> createState() => _ExpAnimPageState();
}

class _ExpAnimPageState extends State<ExpAnimPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _turns;
  bool _playing = false;
  void _toggle() {
    if (_playing) {
      _playing = false;
      _controller.stop();
    } else {
      _controller.forward().whenComplete(() => _controller.reverse());
      _playing = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _turns = Tween(
      begin: 0.0,
      end: pi / 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('显示动画')),
      body: Center(
        child: RotationTransition(
          turns: _turns,
          child: Container(
            width: 200,
            height: 200,
            child: Image.asset('assets/images/jessica.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: Icon(_playing ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
