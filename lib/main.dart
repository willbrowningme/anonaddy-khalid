import 'package:anonaddy/screens/home_screen.dart';
import 'package:anonaddy/utilities/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnonAddy',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // darkTheme: darkTheme,
      home: HomeScreen(),
    );
  }
}
