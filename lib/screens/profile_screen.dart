// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/authentication/login_screen.dart';
import 'package:ghada/service/userService.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/buttonWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: ButtonWidget(() async {
        await auth.signOut();
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }, 'Log Out', false)),
    );
  }
}
