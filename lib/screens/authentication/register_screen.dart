// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/Tab_screen.dart';
import 'package:ghada/screens/authentication/login_screen.dart';
import 'package:ghada/service/userService.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/bottomSheet.dart';
import 'package:ghada/widgets/buttonWidget.dart';
import 'package:ghada/widgets/errorMessage.dart';
import 'package:ghada/widgets/passwordFieldWidget.dart';
import 'package:ghada/widgets/textFieldWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = "/RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum SingingCharacter { homme, femme, enfant }

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  SingingCharacter? character = SingingCharacter.homme;
  bool isLoading = false;
  String errorMsg = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String lastNameError = "";
  String firstNameError = "";
  String emailError = "";
  String passwordError = "";
  String? gender;
  File? _photo;
  String photo = "";
  ImagePicker imagePicker = ImagePicker();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
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
                          borderRadius: BorderRadius.circular(100),
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
                                color: warmBlueColor,
                                size: 30,
                              )))
                      : Container()
                ],
              ),
              SizedBox(height: 20),
              TextFieldWidget(nameController, 'Name', firstNameError),
              SizedBox(height: firstNameError != "" ? 5 : 20),
              TextFieldWidget(lastNameController, 'Last name', lastNameError),
              SizedBox(height: lastNameError != "" ? 5 : 20),
              TextFieldWidget(emailController, 'Email', emailError),
              SizedBox(height: emailError != "" ? 5 : 20),
              PasswordFieldWidget(passwordController, 'Password', passwordError,
                  _obscureText, showHide),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: Row(
                  children: [
                    Text('Choose a type:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warmBlueColor)),
                  ],
                ),
              ),
              SelectRadioButton(),
              ButtonWidget(register, 'Register', isLoading),
              SizedBox(height: 10),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                              color: warmBlueColor,
                              fontWeight: FontWeight.bold),
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
                height: 10,
              )
            ],
          ),
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

  Widget SelectRadioButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Radio<SingingCharacter>(
                fillColor:
                    MaterialStateColor.resolveWith((states) => warmBlueColor),
                value: SingingCharacter.homme,
                groupValue: character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
              Text('Homme',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBlueColor)),
            ],
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                fillColor:
                    MaterialStateColor.resolveWith((states) => warmBlueColor),
                value: SingingCharacter.femme,
                groupValue: character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
              Text('Femme',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBlueColor)),
            ],
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                fillColor:
                    MaterialStateColor.resolveWith((states) => warmBlueColor),
                value: SingingCharacter.enfant,
                groupValue: character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
              Text('Enfant',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBlueColor)),
            ],
          ),
        ],
      ),
    );
  }

  void showHide() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  register() async {
    try {
      if (nameController.text.isEmpty) {
        setState(() {
          firstNameError = "This field is empty";
          lastNameError = "";
          emailError = "";
          passwordError = "";
        });
      } else if (lastNameController.text.isEmpty) {
        setState(() {
          lastNameError = "This field is empty";
          firstNameError = "";
          emailError = "";
          passwordError = "";
        });
      } else if (emailController.text.isEmpty) {
        setState(() {
          emailError = "This field is empty";
          firstNameError = "";
          lastNameError = "";
          passwordError = "";
        });
      } else if (!EmailValidator.validate(emailController.text)) {
        setState(() {
          emailError = "This is an incorrect email";
          firstNameError = "";
          lastNameError = "";
          passwordError = "";
        });
      } else if (passwordController.text.isEmpty) {
        setState(() {
          passwordError = "This field is empty";
          firstNameError = "";
          lastNameError = "";
          emailError = "";
        });
      } else {
        setState(() {
          isLoading = true;
        });
        await auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        gender = character!.name;
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await UserService().addUserData(
            uid,
            nameController.text,
            lastNameController.text,
            emailController.text,
            gender.toString(),
            photo);
        if (_photo != null) {
          final imgId = DateTime.now().millisecondsSinceEpoch.toString();
          Reference reference =
              FirebaseStorage.instance.ref().child("profile/$uid/$imgId");
          await reference.putFile(_photo!);
          photo = await reference.getDownloadURL();
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'profilePic': photo});
        }
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .get();
        if (userSnapshot.exists) {
          final prefs = await SharedPreferences.getInstance();
          Map<String, dynamic> userData = userSnapshot.data()!;
          prefs.setString('user', json.encode(userData));
          Navigator.pushReplacementNamed(
            context,
            TabScreen.routeName,
            arguments: userData['role'],
          );
        } else {
          showDialog(
              context: context,
              builder: (BuildContext buildContext) {
                return ErrorMessage('Error', "This user can't be found");
              });
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return ErrorMessage(
                'Error', "This email is already in use by another account!");
          });
    }
  }
}
