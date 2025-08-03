import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
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
    final list = ListView(
      physics: BouncingScrollPhysics(),
      padding: padding,
      children: children,
    );
    if (footer is Widget || footer is Widget) {
      if (color is Color) {
        return Container(
          color: color,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ?header,
                Expanded(child: list),
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
              Expanded(child: list),
              ?footer,
            ],
          ),
        );
      }
    } else {
      if (color is Color) {
        return Container(color: color, child: list);
      } else {
        return list;
      }
    }
  }
}
