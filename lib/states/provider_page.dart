import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// home: ChangeNotifierProvider(
//   create: (context) => Counter(),
//   child: ProviderPage(),
// ),
// 官方例子里是把 MyApp 包起来
// runApp(
//   ChangeNotifierProvider(
//     create: (context) => Counter(),
//     child: const MyApp(),
//   ),
// );

// ChangeNotifier 是 mixin，但官方例子用的是 extends
// 也能用 with
class Counter with ChangeNotifier {
  int value = 0;
  void increase() {
    value++;
    notifyListeners();
  }
}

class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("COUNTER")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Provider.of<Counter>(context, listen: false).increase();
          context.read<Counter>().increase();
        },
        child: Icon(Icons.light),
      ),
      body: Consumer<Counter>(
        builder: (context, value, child) {
          return Text("value: ${value.value}");
        },
      ),
    );
  }
}
