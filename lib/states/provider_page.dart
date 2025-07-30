import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 这是在顶层使用
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ProxyProvider<UserService, GreetService>(update: (context, value, previous) => GreetService(us: value)),
//         ChangeNotifierProvider(create: (context) => Counter()),
//         Provider<Counter>(create: (_) => Counter()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
// 这是在后续子节点上使用
// home: ChangeNotifierProvider(
//   create: (context) => Counter(),
//   child: ProviderPage(),
// )

// ChangeNotifier 是 mixin class，但官方例子用的是 extends，也能用 with
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
        onPressed: () => context.read<Counter>().increase(),
        child: Icon(Icons.light),
      ),
      body: Consumer<Counter>(
        builder: (context, value, child) => Text("value: ${value.value}"),
      ),
    );
  }
}
