import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_camp/router/dad_screen.dart';
import 'package:flutter_camp/router/para_screen.dart';
import 'package:flutter_camp/router/home_screen.dart';
import 'package:flutter_camp/router/board_screen.dart';
import 'package:flutter_camp/router/login_screen.dart';
import 'package:flutter_camp/router/blah_screen.dart';

import 'package:flutter_camp/router/tab_screen.dart';

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

// final router = GoRouter(
//   initialLocation: '/login',
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => HomeScreen()),
//     GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
//     GoRoute(path: '/board', builder: (context, state) => BoardScreen()),
//     GoRoute(path: '/blah', builder: (context, state) => BlahScreen()),
//     GoRoute(
//       path: '/dad/:name',
//       // builder: (context, state) => DadScreen(),
//       // builder: (context, state) => DadScreen(
//       //   name: state.pathParameters['name'],
//       //   age: state.pathParameters['age'],
//       // ),
//       builder: (context, state) {
//         print("create dad");
//         return DadScreen(
//           name: state.pathParameters['name'],
//           // age: state.pathParameters['age'],
//         );
//       },
//       routes: [
//         GoRoute(
//           path: 'son',
//           // builder: (context, state) => SonScreen(),
//           // builder: (context, state) => SonScreen(
//           //   name: state.pathParameters['name'],
//           //   age: state.pathParameters['age'],
//           // ),
//           builder: (context, state) {
//             print('create son');
//             return SonScreen();
//           },
//         ),
//       ],
//     ),
//     GoRoute(
//       path: '/para/:name/:age',
//       builder: (context, state) => ParaScreen(
//         name: state.pathParameters['name'],
//         age: state.pathParameters['age'],
//       ),
//     ),
//   ],
// );

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // context.push("/books");
                context.go('/books');
              },
              child: const Text('Go to Books'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/movies');
              },
              child: const Text('Go to Movies'),
            ),
          ],
        ),
      ),
    );
  }
}

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/books/details');
            // context.go('/books/details');
          },
          child: const Text('Go to Book Details'),
        ),
      ),
    );
  }
}

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Details')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: const Center(child: Text('This is the book details page.')),
    );
  }
}

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.matches.forEach(print);
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: const Center(child: Text('This is the movies page.')),
    );
  }
}

// 配置路由
final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    // StatefulShellRoute.indexedStack(
    //   builder: (context, state, navigationShell) => SegScreen(),
    //   branches: [

    // ]),
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return Scaffold(
    //       appBar: AppBar(title: Text("hehe")),
    //       body: child,
    //     );
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/books',
    //       builder: (context, state) => const BooksPage(),
    //       routes: [
    //         GoRoute(
    //           path: 'details',
    //           builder: (context, state) => const BookDetailsPage(),
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       path: '/movies',
    //       builder: (context, state) => const MoviesPage(),
    //     ),
    //   ],
    // ),
  ],
);

// class SegScreen extends StatelessWidget {
//   const SegScreen({super.key, required this.shell});

//   final StatefulNavigationShell shell;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         // onDestinationSelected: (value) => setState(() => index = value),
//         onDestinationSelected: (value) => shell.goBranch(value),
//         selectedIndex: shell.currentIndex,
//         destinations: [
//           NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//           NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//       body: [TabHomeScreen(), TabProfileScreen()][shell.currentIndex],
//     );
//   }
// }
