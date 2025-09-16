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
  Counter() {
    print('create counter');
  }
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
      body: Consumer<Counter>(builder: (context, value, child) => Text("value: ${value.value}")),
      // body: Text('abc'),
    );
  }
}

// Proxy 用法

// ChangeNotifierProvider(
//   create: (context) {
//     print("create my user");
//     return MyUser();
//   },
// ),
// ChangeNotifierProxyProvider<MyUser, MySettings>(
//   create: (context) {
//     print("create my settings");
//     return MySettings(user: context.read<MyUser>());
//   },
//   update: (context, value, previous) {
//     print("update my settings, ${value.name}, ${previous?.greet()}");
//     return (previous?..setUser(value)) ?? MySettings(user: value);
//   },
// ),
//
// 简写
// ChangeNotifierProvider(create: (context) => MyUser()),
// ChangeNotifierProxyProvider<MyUser, MySettings>(
//   create: (context) => MySettings(user: context.read<MyUser>()),
//   update: (context, value, previous) =>
//       (previous?..setUser(value)) ?? MySettings(user: value),
// ),

// 使用 Consumer<MySettings>
// flutter: create my settings
// flutter: create my user
// flutter: init my user
// flutter: init my settings
// flutter: update my settings, --, hello --
// flutter: set user
// 调用 context.read<MyUser>().name = "god";
// flutter: update my settings, god, hello god
// flutter: set user

class MyUser with ChangeNotifier {
  // MyUser() { print("init my user"); }
  var _name = "--";
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }
}

class MySettings with ChangeNotifier {
  MySettings({required MyUser user}) : _user = user;
  // { print("init my settings"); }
  MyUser _user;
  void setUser(MyUser user) {
    // print("set user");
    _user = user;
    notifyListeners();
  }

  String greet() {
    return "hello ${_user.name}";
  }
}
