import 'package:flutter/material.dart';
import 'package:prueba_flutter_news_app/widgets/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
          textTheme: const TextTheme(
              labelSmall: TextStyle(color: Colors.white60),
              titleLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white70))),
      home: const HomePage(),
    );
  }
}
