import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'river_app2.g.dart';

@riverpod
class Tick extends _$Tick {
  @override
  int build() {
    print("tick build");
    final timer = Timer.periodic(Duration(seconds: 5), (_) {
      print("tick +++++");
      state++;
    });
    ref.onDispose(() {
      print("tick dispose");
      timer.cancel();
    });
    return 0;
  }
}

// 这里收到数据就会触发，但是下面的 Consumer 并不一定会触发，只有在 true/false 切换时，才会触发 Consumer
@riverpod
bool isDivisibleBy4(Ref ref) {
  final tick = ref.watch(tickProvider);
  print("got $tick");
  return tick % 4 == 0;
}

@riverpod
Future<int> joke2(Ref ref) async {
  print("load joke2");
  ref.onDispose(() {
    print("dispose joke2");
  });
  await Future.delayed(Duration(seconds: 3));
  return Random().nextInt(10000);
}

class RiverApp2 extends StatelessWidget {
  const RiverApp2({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RiverPage2a());
  }
}

class RiverPage2a extends StatefulWidget {
  const RiverPage2a({super.key});
  @override
  State<RiverPage2a> createState() => _RiverPage2aState();
}

class _RiverPage2aState extends State<RiverPage2a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("river-1")),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              print("con 111");
              // final val = ref.watch(tickProvider);
              // return ElevatedButton(onPressed: () {}, child: Text("$val"));
              return ElevatedButton(
                onPressed: () {
                  ref.invalidate(tickProvider);
                  // final val = ref.refresh(tickProvider);
                  // print(val);
                  // final val = ref.read(tickProvider);
                  // print(val);

                  // ref.invalidate(joke2Provider);
                  // final val = ref.refresh(tickProvider);
                  // print(val);
                },
                child: Text("reset"),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              print("con 222");
              final val = ref.watch(tickProvider);
              return Text("$val");

              // final val = ref.watch(joke2Provider);
              // if (val.hasValue) {
              //   return Text("${val.value!} ${val.isRefreshing ? 'ing' : '---'}");
              // } else {
              //   return CircularProgressIndicator();
              // }
            },
          ),
        ],
      ),
    );
  }
}
