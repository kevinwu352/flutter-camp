import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({
    super.key,
    this.color,
    this.padding,
    this.header,
    this.footer,
    required this.children,
  });

  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Widget? header;
  final Widget? footer;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (footer is Widget || footer is Widget) {
      if (color is Color) {
        return Container(
          color: color,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ?header,
                Expanded(
                  child: SingleChildScrollView(
                    padding: padding,
                    child: Column(children: children),
                  ),
                ),
                ?footer,
              ],
            ),
          ),
        );
      } else {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ?header,
              Expanded(
                child: SingleChildScrollView(
                  padding: padding,
                  child: Column(children: children),
                ),
              ),
              ?footer,
            ],
          ),
        );
      }
    } else {
      if (color is Color) {
        return Container(
          color: color,
          child: SingleChildScrollView(
            padding: padding,
            child: SafeArea(child: Column(children: children)),
          ),
        );
      } else {
        return SingleChildScrollView(
          padding: padding,
          child: SafeArea(child: Column(children: children)),
        );
      }
    }
  }
}
