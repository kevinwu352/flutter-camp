import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});
  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radio')),
      body: RadioGroup<SingingCharacter>(
        groupValue: _character,
        onChanged: (SingingCharacter? value) {
          setState(() {
            _character = value;
          });
        },
        child: const Column(
          children: <Widget>[
            ListTile(
              title: Text('Lafayette'),
              leading: Radio<SingingCharacter>(value: SingingCharacter.lafayette),
            ),
            ListTile(
              title: Text('Thomas Jefferson'),
              leading: Radio<SingingCharacter>(value: SingingCharacter.jefferson),
            ),
          ],
        ),
      ),
    );
  }
}
