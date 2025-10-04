import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, this.color, this.padding, this.header, this.footer, required this.children});

  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Widget? header;
  final Widget? footer;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: color),
        if (footer is Widget || footer is Widget)
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ?header,
                Expanded(
                  child: ListView(physics: BouncingScrollPhysics(), padding: padding, children: children),
                ),
                ?footer,
              ],
            ),
          )
        else
          ListView(physics: BouncingScrollPhysics(), padding: padding, children: children),
      ],
    );
  }
}
