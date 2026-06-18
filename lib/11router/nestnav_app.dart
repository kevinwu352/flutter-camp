import 'package:flutter/material.dart';

// root-nav 包含 home signup 两个页面
// signup 其实是一个子路由，nest-nav 包含 两个子页面
// 一般 Navigator.of(context) 获取就近的 Navigator 实例，并操作它
// 而 Navigator.of(context, rootNavigator: true) 明确要求获取主路由
// 最最最关键的点，看看 78 行传 true/false，会有两种 pop 结果，一种 pop 主路由，一种 pop 子路由

class NestnavApp extends StatelessWidget {
  const NestnavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp contains our top-level Navigator
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomePage(),
        '/signup': (BuildContext context) => const SignUpPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/signup");
          },
          child: const Text('Home Page'),
        ),
      ),
    );
  }
}

class CollectPersonalInfoPage extends StatelessWidget {
  const CollectPersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            // 这里是 nest-nav
            Navigator.of(context).pushNamed("signup/choose_credentials");
            // Navigator.of(context).pushReplacementNamed('signup/choose_credentials');
          },
          child: const Text('Collect Personal Info Page'),
        ),
      ),
    );
  }
}

class ChooseCredentialsPage extends StatelessWidget {
  const ChooseCredentialsPage({super.key, required this.onSignupComplete});

  final VoidCallback onSignupComplete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.pinkAccent,
      child: SafeArea(
        child: GestureDetector(
          // onTap: onSignupComplete,
          // 这里如果传 true，也是在 root-nav 上 pop，否则的话是在 nest-nav 上 pop
          onTap: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Collect Credentials Page'),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // SignUpPage builds its own Navigator which ends up being a nested
    // Navigator in our app.
    return Navigator(
      initialRoute: 'signup/personal_info',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'signup/personal_info':
            // Assume CollectPersonalInfoPage collects personal info and then
            // navigates to 'signup/choose_credentials'.
            builder = (BuildContext context) => const CollectPersonalInfoPage();
          case 'signup/choose_credentials':
            // Assume ChooseCredentialsPage collects new credentials and then
            // invokes 'onSignupComplete()'.
            builder = (BuildContext _) => ChooseCredentialsPage(
              onSignupComplete: () {
                // Referencing Navigator.of(context) from here refers to the
                // top level Navigator because SignUpPage is above the
                // nested Navigator that it created. Therefore, this pop()
                // will pop the entire "sign up" journey and return to the
                // "/" route, AKA HomePage.
                // 这里拿到的是 root-nav
                Navigator.of(context).pop();
              },
            );
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
