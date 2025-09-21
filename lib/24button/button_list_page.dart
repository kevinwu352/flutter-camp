import 'package:flutter/material.dart';

class ButtonListPage extends StatelessWidget {
  const ButtonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buttons')),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
              IconButton.filled(onPressed: () {}, icon: Icon(Icons.settings)),
              IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.settings)),
              IconButton.outlined(onPressed: () {}, icon: Icon(Icons.settings)),
            ],
          ),

          Row(
            children: [
              TextButton(onPressed: () {}, child: Text('Text')),
              TextButton.icon(onPressed: () {}, label: Text('Text'), icon: Icon(Icons.settings)),
            ],
          ),

          Row(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Elevated')),
              ElevatedButton.icon(onPressed: () {}, label: Text('Elevated'), icon: Icon(Icons.settings)),
            ],
          ),

          Row(
            children: [
              FilledButton(onPressed: () {}, child: Text('Filled')),
              FilledButton.icon(onPressed: () {}, label: Text('Filled'), icon: Icon(Icons.settings)),
              FilledButton.tonal(onPressed: () {}, child: Text('Filled')),
              FilledButton.tonalIcon(onPressed: () {}, label: Text('Filled'), icon: Icon(Icons.settings)),
            ],
          ),

          Row(
            children: [
              OutlinedButton(onPressed: () {}, child: Text('Outlined')),
              OutlinedButton.icon(onPressed: () {}, label: Text('Outlined'), icon: Icon(Icons.settings)),
            ],
          ),
        ],
      ),
    );
  }
}
