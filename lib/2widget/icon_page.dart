import 'package:flutter/material.dart';

class IconPage extends StatelessWidget {
  const IconPage({super.key, required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = enabled ? () {} : null;

    final ison = false;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_drama),
            onPressed: onPressed,
            isSelected: ison,
            selectedIcon: Icon(Icons.settings),
            tooltip: "asdf",
            splashColor: Colors.red,
            highlightColor: Colors.green,
            hoverColor: Colors.blue,
          ),

          // Filled icon button
          IconButton.filled(
            onPressed: onPressed,
            icon: const Icon(Icons.filter_drama),
            isSelected: ison,
          ),

          // Filled tonal icon button
          IconButton.filledTonal(
            onPressed: onPressed,
            icon: const Icon(Icons.filter_drama),
            isSelected: ison,
          ),

          // Outlined icon button
          IconButton.outlined(
            onPressed: onPressed,
            icon: const Icon(Icons.filter_drama),
            isSelected: ison,
          ),
        ],
      ),
    );
  }
}
