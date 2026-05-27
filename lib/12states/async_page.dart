import 'package:flutter/material.dart';

// Future 要早于 build 方法创建
// State.initState / State.didUpdateWidget / State.didChangeDependencies

// ================================================================================

// AsyncSnapshot

// none     future 为空，把初始值赋给 snapshot。如果 future 为空又不给初始值会卡死
// waiting  future 有值，把初始值赋给 snapshot，然后等结果
// done     future 有值，且完成了，根据成功与否决定 snapshot 里面的值
// active   stream 至少返回了一个值，且还未完成

// 如果 FutureBuilder 设有初始值，然后在 builder 回调里面访问 data 会有值，hasData=true
// 不管有没有初始值，不管最终成功与否，connectionState 是从 waiting -> done
// 切记：如果最终失败了，原来设的初始值本该算作有值的，会变成无值，也就是失败会清除原来的有值状态

// 如果 StreamBuilder 设有初始值，然后在 builder 回调里面访问 data 会有值，hasData=true
// 不管有没有初始值，connectionState 是从 waiting -> active

// ================================================================================

// 个人认为最佳检查顺序：
//   是否有值，有就显示
//   是否有错，有就显示
//   是否加载中，是就显示加载中
//   剩下的是无数据，显示 no data

class AsyncPage extends StatefulWidget {
  const AsyncPage({super.key});

  @override
  State<AsyncPage> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  Future<String> theFuture = Future.delayed(Duration(seconds: 5), () => 'asdf');
  // Future<String> theFuture = Future.delayed(Duration(seconds: 5), () => throw '1234');

  Future<String> getFuture() async {
    // await Future.delayed(Duration(seconds: 2));
    // return "abc";
    return Future.delayed(Duration(seconds: 2), () => 'abc');
  }

  Stream<int> getStream() async* {
    var i = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 3));
      yield i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Async")),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),

      // body: FutureBuilder(
      //   future: null,
      //   initialData: 'god',
      //   builder: (context, snapshot) {
      //     print(
      //       'state:${snapshot.connectionState} data:${snapshot.hasData}:${snapshot.data}, error:${snapshot.hasError}:${snapshot.error}',
      //     );
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasError) {
      //       return Text(snapshot.error.toString(), style: TextStyle(color: Colors.red));
      //     }
      //     return Column(
      //       children: [
      //         Text(snapshot.data.toString()),
      //         ElevatedButton(
      //           onPressed: () {
      //             setState(() {});
      //           },
      //           child: Text("refresh"),
      //         ),
      //       ],
      //     );
      //   },
      // ),
      body: StreamBuilder(
        stream: getStream(),
        // initialData: 101,
        builder: (context, snapshot) {
          print(
            'state:${snapshot.connectionState} data:${snapshot.hasData}:${snapshot.data}, error:${snapshot.hasError}:${snapshot.error}',
          );
          if (snapshot.hasData) {
            return Column(
              children: [
                Text(snapshot.data.toString()),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("refresh"),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
