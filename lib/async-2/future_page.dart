import 'package:flutter/material.dart';

// FutureBuilder
// StreamBuilder

// Future 要早于 build 方案创建
// State.initState, State.didUpdateWidget, or State.didChangeDependencies

// 要细细研究 snapshot.connectionState 的几种状态？

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  Future<String> getFuture() async {
    await Future.delayed(Duration(seconds: 2));
    return "abc";
  }

  Stream<int> getStream() async* {
    var i = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Async"),
      ),
      body:
          // StreamBuilder(
          //   stream: getStream(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Column(
          //         children: [
          //           Text(snapshot.data.toString()),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {});
          //             },
          //             child: Text("refresh"),
          //           ),
          //         ],
          //       );
          //     } else if (snapshot.hasError) {
          //       return Text(snapshot.error.toString());
          //     }
          //     return CircularProgressIndicator();
          //   },
          // ),
          FutureBuilder(
            future: getFuture(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Column(
                children: [
                  Text(snapshot.data.toString()),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      // 本来这里该刷新的，为何没？
                      // 如果检查 hasData，第一次获取数据以后它就有数据了，所以判断一直是真
                      // 如果检查 state == waiting，这状态会变
                    },
                    child: Text("refresh"),
                  ),
                ],
              );
            },
          ),
    );
  }
}
