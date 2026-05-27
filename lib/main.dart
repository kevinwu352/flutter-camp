import 'package:flutter/material.dart';
// import 'package:bot_toast/bot_toast.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import 'test_page.dart';
// import '/11router/router_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 开启布局边框
  // debugPaintSizeEnabled = true;
  await pathInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      title: 'Flutter Camp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
      ),
      themeMode: ThemeMode.light,
      // builder: BotToastInit(),
      // navigatorObservers: [BotToastNavigatorObserver()],
      home: RootPage(),
    );
    // return MaterialApp.router(routerConfig: router);
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Root')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestPage())),
        child: Icon(Icons.run_circle),
      ),
      body: Text('--'),
    );
  }
}
