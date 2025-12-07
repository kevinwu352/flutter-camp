import 'package:flutter/material.dart';

// 像 iOS 那样 present 一个页面
//
// GoRoute(
//   path: '/board',
//   pageBuilder: (context, state) => SlideUpPage(child: OnboardPage()),
// )
//
// context.push('/board');

// 别用这个，用 showModalBottomSheet

class SlideUpPage<T> extends Page<T> {
  const SlideUpPage({super.key, required this.child});
  final Widget child;
  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
        position: animation.drive(
          Tween(begin: Offset(0, 1), end: Offset(0, 0)).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      ),
    );
  }
}
