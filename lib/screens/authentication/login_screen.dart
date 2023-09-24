// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/Tab_screen.dart';
import 'package:ghada/screens/authentication/register_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/buttonWidget.dart';
import 'package:ghada/widgets/errorMessage.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  String emailError = "";
  String passwordError = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 76,
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo-name.png',
                  height: 175,
                  width: 150,
                ),
                SizedBox(height: 20),
                TextFieldWidget(emailController, 'Email', emailError),
                SizedBox(height: emailError != "" ? 5 : 20),
                PasswordFieldWidget(
                    passwordController, 'Password', passwordError),
                Expanded(child: SizedBox()),
                ButtonWidget(login, 'Log In', isLoading),
                SizedBox(height: 10),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: "You don't have an account? ",
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                color: warmBlueColor,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
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
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      if (emailController.text.isEmpty) {
        setState(() {
          emailError = "This field is empty";
          passwordError = "";
        });
      } else if (!EmailValidator.validate(emailController.text)) {
        setState(() {
          emailError = "This is an incorrect email";
          passwordError = "";
        });
      } else if (passwordController.text.isEmpty) {
        setState(() {
          passwordError = "This field is empty";
          emailError = "";
        });
      } else {
        setState(() {
          isLoading = true;
        });
        await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacementNamed(context, TabScreen.routeName);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return ErrorMessage(
                'Error', "The email or password is badly formatted!");
          });
    }
  }
}
