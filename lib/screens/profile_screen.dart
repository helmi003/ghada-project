// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/authentication/login_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/buttonWidget.dart';
import 'package:ghada/widgets/loadingWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingWidget();
          } else {
            final user = snapshot.data!.data();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: warmBlueColor,
                            borderRadius: BorderRadius.circular(110)),
                        width: 220,
                        height: 220,
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: user!['profilePic'] != null &&
                                  user['profilePic'] != ''
                              ? Image.network(
                                  user['profilePic'],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return LoadingWidget();
                                    }
                                  },
                                )
                              : Image.asset(
                                  'assets/images/user.png',
                                  width: 200,
                                  height: 200,
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${user['name']} ${user['lastName']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: warmBlueColor),
                  ),
                  SizedBox(height: 20),
                  ButtonWidget(() async {
                    await auth.signOut();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('user');
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  }, AppLocalizations.of(context)!.logOut, false),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
