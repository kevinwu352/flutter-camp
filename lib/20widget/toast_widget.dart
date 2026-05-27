import 'package:flutter/material.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget({
    super.key,
    this.duration = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 250),
    this.child,
  });
  final Duration duration;
  final Duration transitionDuration;
  final Widget? child;

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: widget.transitionDuration)..forward();
    Future.delayed(widget.duration - widget.transitionDuration, animation.reverse);
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
}

class _TextToastWidget extends StatelessWidget {
  const _TextToastWidget({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.black.withValues(alpha: 0.65),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        // 左右 margin 在文字很长时才有用，文字会换行，且和屏幕边界有距离
        margin: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.sizeOf(context).height * 0.125),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

extension BuildContextToastExt on BuildContext {
  void showTextToast(
    String text, {
    Duration duration = const Duration(seconds: 3),
    Duration transitionDuration = const Duration(milliseconds: 250),
  }) {
    final state = Overlay.of(this);
    final toast = OverlayEntry(
      builder: (_) => ToastWidget(
        transitionDuration: transitionDuration,
        duration: duration,
        child: _TextToastWidget(text: text),
      ),
    );
    state.insert(toast);
    Future.delayed(duration, toast.remove);
  }
}
