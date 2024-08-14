import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Color(0xff1A122F),
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
            ),
            bodySmall: TextStyle(
              color: Color(0xffD5D5D5),
              fontSize: 10,
            ),
            displaySmall: TextStyle(
              color: Color(0xff4D4D4D),
            )),
        cardColor: const Color(0xff583B9D),
        focusColor: const Color(0xffAB9DCE),
      ),
      home: HomeScreen(),
    );
  }
}
