// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/Tab_screen.dart';
import 'package:ghada/screens/authentication/login_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.forward();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  getUser() async {
    User? firebaseUser = auth.currentUser;
    await firebaseUser?.reload();
    if (!mounted) return;
    firebaseUser = auth.currentUser;

    if (firebaseUser != null) {
      if (!mounted) return;
      setState(() {
        user = firebaseUser!;
        isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    getUser();
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        if (isloggedin) {
          DocumentSnapshot<Map<String, dynamic>> userSnapshot =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();
          if (userSnapshot.exists) {
            Map<String, dynamic> userData = userSnapshot.data()!;
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('user', json.encode(userData));
            Navigator.pushReplacementNamed(
              context,
              TabScreen.routeName,
              arguments: userData['role'],
            );
          } else {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
        print(isloggedin);
      } catch (e) {
        print(e.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBlueColor,
      body: ScaleTransition(
        scale: _animation,
        child: Center(
          child: Image.asset(
            'assets/images/logo-name.png',
            height: 250,
            width: 243,
          ),
        ),
      ),
    );
  }
}
