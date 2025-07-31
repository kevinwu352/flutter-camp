import 'package:go_router/go_router.dart';

import 'package:flutter_camp/router/dad_screen.dart';
import 'package:flutter_camp/router/para_screen.dart';
import 'package:flutter_camp/router/home_screen.dart';
import 'package:flutter_camp/router/board_screen.dart';
import 'package:flutter_camp/router/login_screen.dart';
import 'package:flutter_camp/router/blah_screen.dart';

// 父路由只相当于一个 group，并不会在导航栈上创建多个页面
// push 子路由的时候，并不会创建父路由的实例
// 父路由有参数的时候，子路由要把参数带上

// pop
// push / pushNamed
// go / goNamed                             会替换掉原来的整个栈，有 push 动画
// replace / replaceNamed                   替换栈顶这个页面，无动画
// pushReplacement / pushReplacementNamed   替换栈顶这个页面，有 push 动画
// 调用时，路径末尾的 / 不影响

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

// 打印路由栈
// GoRouter.of(context).routerDelegate.currentConfiguration.matches.forEach(print);

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/board', builder: (context, state) => BoardScreen()),
    GoRoute(path: '/blah', builder: (context, state) => BlahScreen()),
    GoRoute(
      path: '/dad/:name',
      // builder: (context, state) => DadScreen(),
      // builder: (context, state) => DadScreen(
      //   name: state.pathParameters['name'],
      //   age: state.pathParameters['age'],
      // ),
      builder: (context, state) {
        print("create dad");
        return DadScreen(
          name: state.pathParameters['name'],
          // age: state.pathParameters['age'],
        );
      },
      routes: [
        GoRoute(
          path: 'son',
          // builder: (context, state) => SonScreen(),
          // builder: (context, state) => SonScreen(
          //   name: state.pathParameters['name'],
          //   age: state.pathParameters['age'],
          // ),
          builder: (context, state) {
            print('create son');
            return SonScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/para/:name/:age',
      builder: (context, state) => ParaScreen(
        name: state.pathParameters['name'],
        age: state.pathParameters['age'],
      ),
    ),
  ],
);
