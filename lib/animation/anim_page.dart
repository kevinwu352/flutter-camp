import 'dart:math';
import 'package:flutter/material.dart';

class AnimPage extends StatefulWidget {
  const AnimPage({super.key});
  @override
  State<AnimPage> createState() => _AnimPageState();
}

class _AnimPageState extends State<AnimPage>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );
  // late Animation<Offset> _values;
  late final _animation = Tween<double>(
    begin: 50.0,
    end: 200.0,
  ).animate(_controller);

  // late final animation = Tween(begin: 20.0, end: 300.0).animate(_controller)
  //   ..addListener(() {
  //     setState(() => {});
  //   }); // 下面使用这个动画值的时候，用的是普通控件，所以要调用 setState

  bool _playing = false;
  void _toggle() {
    // if (_playing) {
    //   _playing = false;
    //   _controller.stop();
    // } else {
    //   _controller.forward().whenComplete(() => _controller.reverse());
    //   _playing = true;
    // }
    _controller.forward();
    // setState(() {});
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
        // child: RotationTransition(
        //   turns: _turns,
        //   child: Container(
        //     width: 200,
        //     height: 200,
        //     child: Image.asset('assets/images/jessica.jpg', fit: BoxFit.cover),
        //   ),
        // ),
        // child: SlideTransition(
        //   position: _values,
        //   child: const Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: FlutterLogo(size: 50.0),
        //   ),
        // ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              color: Colors.blue,
            );
          },
        ),
        // child: Image.asset(
        //   "assets/images/jessica.jpg",
        //   width: animation.value,
        //   height: animation.value,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: Icon(_playing ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
