// ignore_for_file: prefer_const_constructors, equal_keys_in_map

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/Tab_screen.dart';
import 'package:ghada/screens/authentication/register_screen.dart';
import 'package:ghada/screens/doctor_screen.dart';
import 'package:ghada/screens/patient_screen.dart';
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
        PatientScreen.routeName: (ctx) => PatientScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == TabScreen.routeName) {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return TabScreen(role: args);
            },
          );
        }
      },
    );
  }
}
