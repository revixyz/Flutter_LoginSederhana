import 'package:flutter/material.dart';
import 'package:login_app/screens/news_screen.dart';
import 'login/login_page.dart';
import 'screens/berita.dart';
import 'screens/presensi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/presensi': (context) => Presensi(),
        '/berita': (context) => Berita(),
        '/news': (context) => NewsScreens(),
      },
    );
  }
}

