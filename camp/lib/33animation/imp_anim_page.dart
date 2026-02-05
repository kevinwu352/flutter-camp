import 'package:flutter/material.dart';

class ImpAnimPage extends StatefulWidget {
  const ImpAnimPage({super.key});

  @override
  State<ImpAnimPage> createState() => _ImpAnimPageState();
}

class _ImpAnimPageState extends State<ImpAnimPage> {
  var offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Implicit Animation')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => offset = Offset(2, 0));
        },
        child: Icon(Icons.run_circle),
      ),
      // AnimatedSlide 收到松约束，尺寸 50，且 Inspector 里面看到它的边框是正常的
      body: AnimatedSlide(offset: offset, duration: Duration(milliseconds: 500), child: FlutterLogo(size: 50)),
    );
  }
}
