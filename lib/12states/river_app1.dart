import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'river_app1.g.dart';

// final cityProvider = Provider((ref) => 'London');
@riverpod
String city(Ref ref) => 'London';

// final joke1Provider = FutureProvider.autoDispose((ref) async {
//   print("load joke1");
//   ref.onCancel(() => print("cancel joke1"));
//   ref.onDispose(() => print("dispose joke1"));
//   await Future.delayed(Duration(seconds: 3));
//   return Random().nextInt(10000);
// });
// @riverpod
@Riverpod(keepAlive: false)
Future<int> joke1(Ref ref) async {
  print("load joke1");
  ref.onCancel(() => print("cancel joke1"));
  ref.onDispose(() => print("dispose joke1"));
  await Future.delayed(Duration(seconds: 3));
  return Random().nextInt(10000);
}

class RiverApp1 extends StatelessWidget {
  const RiverApp1({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RiverPage1a());
  }
}

class RiverPage1a extends StatefulWidget {
  const RiverPage1a({super.key});
  @override
  State<RiverPage1a> createState() => _RiverPage1aState();
}

class _RiverPage1aState extends State<RiverPage1a> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(title: Text("river-1")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text("rebuild"),
          ),
          Consumer(
            builder: (context, ref, child) {
              final val = ref.watch(cityProvider);
              return Text(val);
            },
          ),
          // Consumer(
          //   builder: (context, ref, child) {
          //     print("consum reload");
          //     final val = ref.watch(joke1Provider);
          //     switch (val) {
          //       case AsyncValue(:final value?):
          //         // return Text("${value}");
          //         return ElevatedButton(
          //           onPressed: () {
          //             ref.invalidate(joke1Provider);
          //             // setState(() {});
          //           },
          //           child: Text("$value ${val.isRefreshing ? "ing" : "---"}"),
          //         );
          //       case AsyncValue(error: != null):
          //         return Text('Error: ${val.error}');
          //       case AsyncValue():
          //         return const CircularProgressIndicator();
          //     }
          //   },
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RiverPage1b()));
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class RiverPage1b extends StatefulWidget {
  const RiverPage1b({super.key});
  @override
  State<RiverPage1b> createState() => _RiverPage1bState();
}

class _RiverPage1bState extends State<RiverPage1b> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("river-2")),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final val = ref.watch(joke1Provider);
              if (val.hasValue) {
                return ElevatedButton(
                  onPressed: () {
                    ref.invalidate(joke1Provider);
                  },
                  child: Text("${val.value!}"),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
