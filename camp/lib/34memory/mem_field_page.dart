import 'package:flutter/material.dart';

// 文档说需要 dispose，但不调 dispose 也能正常释放
// 所以，哪种情况会导致释放不掉？

class MemFieldPage extends StatefulWidget {
  const MemFieldPage({super.key});

  @override
  State<MemFieldPage> createState() => _MemFieldPageState();
}

class _MemFieldPageState extends State<MemFieldPage> {
  TextEditingController controller = TextEditingController(text: 'abc');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Field')),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                //
              },
              child: Text('start'),
            ),
            TextField(controller: controller),
          ],
        ),
      ),
    );
  }
}
