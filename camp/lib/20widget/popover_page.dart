import 'package:flutter/material.dart';

OverlayEntry? entry;

class PopAlertWidget extends StatefulWidget {
  const PopAlertWidget({super.key, this.child});
  final Widget? child;

  @override
  State<PopAlertWidget> createState() => _PopAlertWidgetState();
}

class _PopAlertWidgetState extends State<PopAlertWidget> with SingleTickerProviderStateMixin {
  late final animation = AnimationController(vsync: this, duration: Duration(milliseconds: 300))..forward();
  late final tween1 = Tween(begin: 60.0, end: 0.0).chain(CurveTween(curve: Curves.bounceOut));
  late final tween2 = Tween(begin: 0.0, end: 1.0);
  var show = true;

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Listener(
            onPointerDown: (event) {
              print('clicked');
              // entry?.remove();
              // entry = null;
              show = false;
              animation.duration = Duration(milliseconds: 150);
              animation.reverse();
              Future.delayed(Duration(milliseconds: 150), () {
                entry?.remove();
                entry = null;
              });
            },
            child: ColoredBox(color: Colors.black.withValues(alpha: 0.5)),
          ),
        ),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Transform.translate(
            offset: show ? Offset(0, tween1.evaluate(animation)) : Offset.zero,
            child: Opacity(opacity: tween2.evaluate(animation), child: child),
          ),
          child: widget.child,
        ),
      ],
    );
  }
}

class PopSheetWidget extends StatefulWidget {
  const PopSheetWidget({super.key, this.child});
  final Widget? child;

  @override
  State<PopSheetWidget> createState() => _PopSheetWidgetState();
}

class _PopSheetWidgetState extends State<PopSheetWidget> {
  var show = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setState(() => show = true));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: Listener(
            onPointerDown: (event) {
              print('clicked');
              // final state = Overlay.of(context);
              // print(state);
              // final ov = state.widget;
              // print(ov);
              setState(() {
                show = false;
                Future.delayed(Duration(milliseconds: 150), () {
                  entry?.remove();
                  entry = null;
                });
              });
            },
            child: ColoredBox(color: Colors.black.withValues(alpha: 0.5)),
          ),
        ),
        AnimatedSlide(
          offset: show ? Offset.zero : Offset(0, 1),
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 150),
          child: widget.child,
        ),
      ],
    );
  }
}

extension BuildContextPopExt on BuildContext {
  void showPopAlert() {
    final state = Overlay.of(this);
    final toast = OverlayEntry(
      builder: (_) => PopAlertWidget(
        child: Container(
          color: Colors.red,
          padding: EdgeInsets.all(20),
          child: Text(
            'data',
            style: TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
    state.insert(toast);
    entry = toast;
    // Future.delayed(duration, toast.remove);
  }

  void showPopSheet() {
    final state = Overlay.of(this);
    final toast = OverlayEntry(
      builder: (_) => PopSheetWidget(
        child: Container(
          color: Colors.red,
          padding: EdgeInsets.all(20),
          child: Text(
            'data',
            style: TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
    state.insert(toast);
    entry = toast;
    // Future.delayed(duration, toast.remove);
  }
}
