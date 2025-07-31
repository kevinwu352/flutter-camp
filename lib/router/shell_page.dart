import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("login"),
          ElevatedButton(
            onPressed: () => context.go("/home"),
            child: Text("go home"),
          ),
        ],
      ),
    );
  }
}

// ================================================================================

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => shell.goBranch(value),
        selectedIndex: shell.currentIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: shell,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("home"),
        ElevatedButton(
          onPressed: () => context.push("/homi"),
          child: Text("go homi"),
        ),
      ],
    );
  }
}

class HomiScreen extends StatelessWidget {
  const HomiScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("homi")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("homi")],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("profile")],
    );
  }
}

// ================================================================================

final GoRouter shell_router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => LoginScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainScreen(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: "/home", builder: (context, state) => HomeScreen()),
            GoRoute(path: "/homi", builder: (context, state) => HomiScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/profile",
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
