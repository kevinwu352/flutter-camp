import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/features/onboard/onboard_page.dart';
import '/features/auth/login_page.dart';

import '/features/home/home_page.dart';
import '/features/live/live_page.dart';
import '/features/profile/profile_page.dart';

import '/features/settings/settings_page.dart';
import '/features/settings/language_page.dart';
import '/features/settings/theme_page.dart';

import '/features/message/message_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.shell});
  final StatefulNavigationShell shell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => shell.goBranch(value),
        selectedIndex: shell.currentIndex,
        indicatorColor: Colors.amber,
        labelTextStyle: WidgetStateTextStyle.resolveWith(
          (states) => TextStyle(color: states.contains(WidgetState.selected) ? Colors.amber : Colors.black),
        ),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), selectedIcon: Icon(Icons.star), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.live_tv), selectedIcon: Icon(Icons.star), label: 'Live'),
          NavigationDestination(icon: Icon(Icons.person), selectedIcon: Icon(Icons.star), label: 'Profile'),
        ],
      ),
      body: shell,
    );
  }
}

abstract final class Routes {
  static const onboard = '/onboard';
  static const login = '/login';

  static const home = '/home';
  static const live = '/live';
  static const profile = '/profile';

  static const settings = '/settings';
  static const settingsLanguage = '$settings/$_settingsLanguage';
  static const _settingsLanguage = 'language';
  static const settingsTheme = '$settings/$_settingsTheme';
  static const _settingsTheme = 'theme';

  static const message = '/message';

  // static String bookingWithId(int id) => '$booking/$id';
}

GoRouter router(bool showOnboard, bool showLogin) => GoRouter(
  initialLocation: showOnboard
      ? Routes.onboard
      : showLogin
      ? Routes.login
      : Routes.home,
  routes: [
    GoRoute(path: Routes.onboard, builder: (context, state) => OnboardPage()),
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainPage(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.home, builder: (context, state) => HomePage())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.live, builder: (context, state) => LivePage())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.profile, builder: (context, state) => ProfilePage())],
        ),
      ],
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => SettingsPage(),
      routes: [
        GoRoute(path: Routes._settingsLanguage, builder: (context, state) => LanguagePage()),
        GoRoute(path: Routes._settingsTheme, builder: (context, state) => ThemePage()),
      ],
    ),
    GoRoute(
      path: Routes.message,
      builder: (context, state) => MessagePage.create(network: context.read()),
    ),
  ],
);
