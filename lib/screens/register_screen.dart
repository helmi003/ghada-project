// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/login_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/bottomSheet.dart';
import 'package:ghada/widgets/buttonWidget.dart';
import 'package:ghada/widgets/passwordFieldWidget.dart';
import 'package:ghada/widgets/textFieldWidget.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = "/RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  String errorMsg = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  File? _photo;
  String photo = "";
  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16)),
                        ),
                        backgroundColor: lightColor,
                        context: context,
                        builder: ((builder) => BottomSheetCamera(() {
                              takephoto(
                                ImageSource.camera,
                              );
                            }, () {
                              takephoto(
                                ImageSource.gallery,
                              );
                            })));
                  },
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: _photo != null
                            ? Container(
                                constraints: BoxConstraints(
                                    maxHeight: 200, maxWidth: 200),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    _photo!,
                                  ),
                                )))
                            : Image.asset(
                                'assets/images/user.png',
                                width: 200,
                                height: 200,
                              )),
                  ),
                ),
                _photo != null
                    ? Positioned(
                        bottom: -10,
                        right: 80,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _photo = null;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: redColor,
                              size: 30,
                            )))
                    : Container()
              ],
            ),
            TextFieldWidget(nameController, 'Name'),
            TextFieldWidget(lastNameController, 'Last name'),
            TextFieldWidget(emailController, 'Email'),
            PasswordFieldWidget(passwordController, 'Password'),
            Expanded(
              child: SizedBox(),
            ),
            ButtonWidget(() {}, 'Register', false),
            SizedBox(height: 10),
            Center(
              child: RichText(
                text: TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                            color: lightColor, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
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

  takephoto(ImageSource source) async {
    final pick = await imagePicker.pickImage(source: source);
    if (pick != null) {
      setState(() {
        _photo = File(pick.path);
      });
    }
  }
}
