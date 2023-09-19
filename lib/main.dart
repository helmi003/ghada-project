// ignore_for_file: prefer_const_constructors, equal_keys_in_map

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/Tab_screen.dart';
import 'package:ghada/screens/authentication/register_screen.dart';
import 'package:ghada/screens/home_screen.dart';
import 'package:ghada/screens/authentication/login_screen.dart';
import 'package:ghada/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: SplashScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        TabScreen.routeName: (ctx) => TabScreen(),
      },
    );
  }
}
