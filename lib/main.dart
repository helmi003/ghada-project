// ignore_for_file: prefer_const_constructors, equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:ghada/screens/home_screen.dart';
import 'package:ghada/screens/login_screen.dart';
import 'package:ghada/screens/register_screen.dart';
import 'package:ghada/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghada project',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
    );
  }
}
