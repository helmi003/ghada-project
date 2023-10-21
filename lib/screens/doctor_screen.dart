// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghada/screens/addOrRemoveRehabs_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/appbar.dart';
import 'package:ghada/widgets/loadingWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColor,
        appBar: appBar(context,AppLocalizations.of(context)!.homeScreen),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .where('role', isNotEqualTo: 'doctor')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return LoadingWidget();
            } else {
              List<DocumentSnapshot> users = snapshot.data!.docs;
              if (users.isEmpty) {
                return Center(
                    child: Text(
                  AppLocalizations.of(context)!.noData,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lightColor),
                ));
              }
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          color: silverColor.withOpacity(0.8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: users[index]['profilePic'] != null &&
                                      users[index]['profilePic'] != ''
                                  ? Image.network(
                                      users[index]['profilePic'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/user.png',
                                      width: 50,
                                      height: 50,
                                    ),
                            ),
                            title: Text(
                              "${users[index]['name']} ${users[index]['lastName']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: lightColor),
                            ),
                            subtitle: Text(
                              users[index]['email'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: lightColor),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right,
                              size: 50,
                              color: lightColor,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addOrRemoveRehabs(
                                          users[index].data() as Map<String, dynamic>,users[index].id)));
                            },
                          ),
                        ),
                      ));
            }
          },
        ));
  }
}
