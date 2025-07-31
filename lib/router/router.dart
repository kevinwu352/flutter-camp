import 'package:flutter_camp/router/para_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_camp/router/child_screen.dart';
import 'package:flutter_camp/router/home_screen.dart';

// pop
// push / pushNamed
// go / goNamed
// replace / replaceNamed
// pushReplacement / pushReplacementNamed

// GoRoute(
//   name: 'song',
//   path: 'songs/:songId',
//   builder: /* ... */,
// )
// 直接用 name
// context.goNamed('song', pathParameters: {'songId': 123});
// 用 name 查找 location
// context.go(context.namedLocation('song', pathParameters: {'songId': 123}));

// 等结果
// onTap: () async {
//   final bool? result = await context.push<bool>('/page2');
//   if(result ?? false)...
// }
// 返回结果
// onTap: () => context.pop(true)

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/child', builder: (context, state) => ChildScreen()),
    GoRoute(
      path: '/para/:name/:age',
      builder: (context, state) => ParaScreen(
        name: state.pathParameters['name'],
        age: state.pathParameters['age'],
      ),
    ),
  ],
);
