import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import 'test_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 开启布局边框
  // debugPaintSizeEnabled = true;
  await pathinit();

  final input = 'jkhaisdfihisfd';
  // var bytes = utf8.encode(input);
  // var digest = md5.convert(bytes);
  // final str = digest.toString();
  print(''.md5);
  print(input.md5);
  print(''.md5);

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
      home: TestPage(),
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
