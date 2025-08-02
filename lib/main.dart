import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_camp/home_page.dart';

import 'package:flutter_camp/router/router_page.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   localizationsDelegates: AppLocalizations.localizationsDelegates,
    //   supportedLocales: AppLocalizations.supportedLocales,
    //   locale: Locale("en"),
    //   title: "Flutter Camp",
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(
    //       seedColor: Colors.red,
    //       brightness: Brightness.light,
    //     ),
    //   ),
    //   home: KeyPage(),
    // );
    return MaterialApp.router(routerConfig: router);
  }
}
