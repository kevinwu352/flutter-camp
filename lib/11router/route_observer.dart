import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> kRouteOb = RouteObserver<ModalRoute<void>>();
// void main() {
//   runApp(MaterialApp(home: HomePage(), navigatorObservers: [kRouteOb]));
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  // 如果把订阅放到 initState 里会崩
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    kRouteOb.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    kRouteOb.unsubscribe(this);
    super.dispose();
  }

  // pop 后露出当前 route，多个路由 pop 不会触发，必须是露出
  // 这是 viewDidAppear，负向显示
  @override
  void didPopNext() {
    super.didPopNext();
    print('did pop next home');
  }

  // 新 route 盖住了当前，后续 push 不会触发，必须是盖住
  // 这是 viewDidDisappear
  @override
  void didPushNext() {
    super.didPushNext();
    print('did push next home');
  }

  // 初次显示时触发，相当于自己入栈，正向显示
  @override
  void didPush() {
    super.didPush();
    print('did push home');
  }

  // 自己被 pop 时触发
  @override
  void didPop() {
    super.didPop();
    print('did pop home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Observer')),
      body: Text('data'),
    );
  }
}
