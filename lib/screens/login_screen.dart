// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/home_screen.dart';
import 'package:ghada/screens/register_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/buttonWidget.dart';
import 'package:ghada/widgets/passwordFieldWidget.dart';
import 'package:ghada/widgets/textFieldWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  void showHide() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool isLoading = false;
  String errorMsg = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/logo-name.png',
              height: 175,
              width: 150,
            ),
            SizedBox(height: 20),
            TextFieldWidget(emailController, 'Email'),
            SizedBox(height: 20),
            PasswordFieldWidget(passwordController, 'Password'),
            Expanded(child: SizedBox()),
            ButtonWidget(() {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }, 'Log In', false),
            SizedBox(height: 10),
            Center(
              child: RichText(
                text: TextSpan(
                    text: "You don't have an account? ",
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(
                            color: lightColor, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                      )
                    ],
                    style: TextStyle(
                      fontSize: 16,
                      color: lightColor,
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
