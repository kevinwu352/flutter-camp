import 'package:flutter/material.dart';

class SpriteWidget extends StatefulWidget {
  const SpriteWidget({
    super.key,
    required this.frameCount,
    required this.frameFormat,
    required this.duration,
    this.progress,
    this.width,
    this.height,
  });
  final int frameCount;
  final String frameFormat;
  final Duration duration;
  final double? progress;
  final double? width;
  final double? height;

  @override
  State<SpriteWidget> createState() => _SpriteWidgetState();
}

class _SpriteWidgetState extends State<SpriteWidget> with SingleTickerProviderStateMixin {
  late final animation = AnimationController(duration: widget.duration, vsync: this);
  late final tween = IntTween(begin: 0, end: widget.frameCount - 1);
  late final anim = animation.drive(tween);

  void reload() {
    final progress = widget.progress;
    if (progress != null) {
      if (progress >= 0) {
        animation.value = progress;
      } else {
        animation.repeat();
      }
    } else {
      animation.reset();
    }
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  void didUpdateWidget(covariant SpriteWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    reload();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) => Image.asset(
        widget.frameFormat.replaceFirst('##', anim.value.toString()),
        width: widget.width,
        height: widget.height,
        gaplessPlayback: true,
      ),
    );
  }
}
