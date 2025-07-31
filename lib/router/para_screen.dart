import 'package:flutter/material.dart';

// 知道有几个参数时，用路径参数，Widget 内部接收参数用 String?
// GoRoute(
//   path: '/users/:name/:age',
//   builder: (context, state) => const UserScreen(id: state.pathParameters['userId']),
// )
// 不知有几个参数时，用 Query
// GoRoute(
//   path: '/users',
//   builder: (context, state) => const UsersScreen(filter: state.uri.queryParameters['filter']),
// )
// 复杂对象，用额外参数
// context.go('/123', extra: User());
// final String extraString = GoRouterState.of(context).extra! as User;

class ParaScreen extends StatelessWidget {
  const ParaScreen({super.key, required this.name, required this.age});

  final String? name;
  final String? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HOME')),
      body: Text('name: $name $age'),
    );
  }
}
