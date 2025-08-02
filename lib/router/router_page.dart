import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> root_key = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> home_key = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> favorite_key = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> profile_key = GlobalKey<NavigatorState>();

void dumpnav({required GlobalKey<NavigatorState> key, required String prefix}) {
  final context = key.currentContext;
  if (context is BuildContext) {
    print("$prefix:");
    GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.matches.forEach(print);
  }
}

void dumpall() {
  print("________________________________________");
  dumpnav(key: root_key, prefix: "root");
  dumpnav(key: home_key, prefix: "home");
  dumpnav(key: favorite_key, prefix: "favorite");
  dumpnav(key: profile_key, prefix: "profile");
}

// ================================================================================

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOGIN")),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => dumpall(),
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("login"),
          ElevatedButton(
            onPressed: () => context.push("/settings"),
            child: Text("push settings"),
          ),
          ElevatedButton(
            onPressed: () {
              context.go("/favorite");
              // context.go("/detail");
              // context.go("/home/sub");
            },
            child: Text("go"),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SETTINGS")),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => dumpall(),
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("settings")],
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
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorite'),
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
    return Scaffold(
      appBar: AppBar(title: Text("HOME")),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => dumpall(),
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("home"),
          ElevatedButton(
            onPressed: () => context.push("/detail"),
            child: Text("push detail"),
          ),
          ElevatedButton(
            onPressed: () => context.push("/home/sub"),
            child: Text("push sub"),
          ),
          ElevatedButton(
            onPressed: () {
              context.push("/settings");
            },
            child: Text("push settings"),
          ),
          ElevatedButton(
            onPressed: () => context.go("/profile"),
            child: Text("go profile"),
          ),
        ],
      ),
    );
  }
}

class SubScreen extends StatelessWidget {
  const SubScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SUB")),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => dumpall(),
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("sub")],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DETAIL")),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => dumpall(),
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("detail")],
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FAVORITE")),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => dumpall(),
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("favorite")],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PROFILE")),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => dumpall(),
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("profile"),
          ElevatedButton(
            onPressed: () => context.push("/detail"),
            child: Text("push detail"),
          ),
          ElevatedButton(
            onPressed: () => context.push("/home/sub"),
            child: Text("push sub"),
          ),
          ElevatedButton(
            onPressed: () {
              context.push("/settings");
            },
            child: Text("push settings"),
          ),
          ElevatedButton(
            onPressed: () => context.go("/login"),
            child: Text("logout"),
          ),
        ],
      ),
    );
  }
}

// ================================================================================

final GoRouter router = GoRouter(
  initialLocation: "/login",
  navigatorKey: root_key,
  routes: [
    GoRoute(path: "/login", builder: (context, state) => LoginScreen()),
    GoRoute(path: "/settings", builder: (context, state) => SettingsScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainScreen(shell: shell),
      branches: [
        StatefulShellBranch(
          navigatorKey: home_key,
          routes: [
            GoRoute(
              path: "/home",
              builder: (context, state) => HomeScreen(),
              routes: [
                GoRoute(path: "sub", builder: (context, state) => SubScreen()),
              ],
            ),
            GoRoute(
              path: "/detail",
              builder: (context, state) => DetailScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: favorite_key,
          routes: [
            GoRoute(
              path: "/favorite",
              builder: (context, state) => FavoriteScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: profile_key,
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
