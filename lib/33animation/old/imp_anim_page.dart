import 'package:flutter/material.dart';

class ImpAnimPage extends StatefulWidget {
  const ImpAnimPage({super.key});
  @override
  State<ImpAnimPage> createState() => _ImpAnimPageState();
}

class _ImpAnimPageState extends State<ImpAnimPage> {
  double size = 100;
  double raidus = 25;
  Color color = Colors.yellow;
  void _animate() {
    setState(() {
      size = size == 100 ? 200 : 100;
      raidus = raidus == 25 ? 100 : 25;
      color = color == Colors.yellow ? Colors.greenAccent : Colors.yellow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated Container')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: size,
              height: size,
              curve: Curves.easeIn,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(raidus)),
              duration: Duration(seconds: 1),
              child: FlutterLogo(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _animate, child: Icon(Icons.refresh)),
    );
  }
}
