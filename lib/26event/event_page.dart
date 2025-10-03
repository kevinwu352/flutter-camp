import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Listener(
        onPointerDown: (event) => print('most'),
        child: Listener(
          onPointerDown: (event) => print('top'),
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) => print('out'),
            // child: Container(width: 400, height: 400, color: Colors.teal),
            // child: AbsorbPointer(child: Container(width: 400, height: 400, color: Colors.teal)),
            child: IgnorePointer(child: Container(width: 400, height: 400, color: Colors.teal)),
          ),
        ),
      ),
    );
  }
}
