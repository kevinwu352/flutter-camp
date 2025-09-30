import 'package:flutter/material.dart';
import '/core/core.dart';

// required double maxCrossAxisExtent
// double mainAxisSpacing = 0.0
// double crossAxisSpacing = 0.0
// double childAspectRatio = 1.0
// List<Widget> children = const <Widget>[]

class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('--')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: GridView.extent(
        maxCrossAxisExtent: 50,
        children: [
          Container(color: ColorsExt.rand()),
          Container(color: ColorsExt.rand()),
          Container(color: ColorsExt.rand()),
        ],
      ),
    );
  }
}
