import 'package:flutter/material.dart';

class TooltipPage extends StatelessWidget {
  const TooltipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tooltip')),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        children: [
          // TooltipTheme 影响子，子可以是 Tooltip 或 IconButton.tooltip
          TooltipTheme(
            data: TooltipThemeData(
              decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.9), borderRadius: BorderRadius.zero),
            ),
            // child: Tooltip(
            //   message: 'Example tooltip',
            //   child: IconButton(iconSize: 36.0, icon: const Icon(Icons.touch_app), onPressed: () {}),
            // ),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.settings), tooltip: 'asdf22'),
          ),

          IconButton(onPressed: () {}, icon: Icon(Icons.settings), tooltip: 'asdf'),
        ],
      ),
    );
  }
}
