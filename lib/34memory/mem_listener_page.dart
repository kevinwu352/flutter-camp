import 'package:flutter/material.dart';

// 貌似 addListener 并不影响对象的生命周期

class MemListenerPage extends StatefulWidget {
  const MemListenerPage({super.key, required this.vm});

  final MyViewModel vm;

  @override
  State<MemListenerPage> createState() => _MemListenerPageState();
}

class _MemListenerPageState extends State<MemListenerPage> {
  @override
  void initState() {
    super.initState();
    name.addListener(() {
      print('name changed $this');
    });
    name.addListener(cb1);

    widget.vm.bio.addListener(() => print('bio changed $this'));
    widget.vm.bio.addListener(cb2);
  }

  final name = ValueNotifier('abc');

  void cb1() {
    print('cb1 ${name.value}');
  }

  void cb2() {
    print('cb2 ${widget.vm.bio.value}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listener')),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                name.value = 'god';
                widget.vm.bio.value = 'hi there';
              },
              child: Text('start'),
            ),
            ListenableBuilder(listenable: name, builder: (context, child) => Text('name: ${name.value}')),
            ListenableBuilder(
              listenable: widget.vm.bio,
              builder: (context, child) => Text('bio: ${widget.vm.bio.value}'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyViewModel extends ChangeNotifier {
  final bio = ValueNotifier('hi');
}
