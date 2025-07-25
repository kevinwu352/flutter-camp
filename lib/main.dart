import 'package:flutter/material.dart';
import 'package:flutter_camp/home_page.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Camp",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      // home: RouteListPage(),
      initialRoute: "/",
      routes: {
        "/": (_) => HomePage(),
        "/list": (_) => RouteListPage(),
        "/detail": (_) => RouteDetailPage(),
      },
    );
  }
}
