// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ghada/screens/bluetooth/SelectBondedDevicePage.dart';
import 'package:ghada/screens/rehab_detail.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/appbar.dart';
import 'package:ghada/widgets/errorMessage.dart';
import 'package:ghada/widgets/loadingWidget.dart';
import 'package:ghada/widgets/reductionWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});
  static const routeName = "/PatientScreen";

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  BluetoothDevice? selectedDevice;
  Map<String, dynamic> userData = {};
  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString('user');
    setState(() {
      userData = json.decode(encodedMap!);
      print(userData);
    });
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context),
      body: SafeArea(
        child: userData['rehabs']==null || userData['rehabs'].isEmpty
            ? Center(
                child: Text(
                'There is no data yet',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: lightColor),
              ))
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('rehabs')
                    .where(FieldPath.documentId, whereIn: userData['rehabs'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingWidget();
                  } else {
                    var data = snapshot.data!.docs;
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: GridView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ReductionWidget(
                              data[index]['name'], false, false, false,
                              () async {
                            bool? isEnabled =
                                await FlutterBluetoothSerial.instance.isEnabled;
                            print(isEnabled);
                            if (!isEnabled!) {
                              showDialog(
                                  context: context,
                                  builder: (context) => ErrorMessage('Alert',
                                      'You have to open Bluetooth first!'));
                            } else {
                              if (selectedDevice != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RehabDetail(
                                            data[index]['name'],
                                            data[index]['video'],
                                            selectedDevice!)));
                              } else {
                                selectedDevice =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SelectBondedDevicePage(
                                          checkAvailability: false);
                                    },
                                  ),
                                );
                                if (selectedDevice != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RehabDetail(
                                              data[index]['name'],
                                              data[index]['video'],
                                              selectedDevice!)));
                                }
                              }
                            }
                          }, () {}, () {});
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                      ),
                    );
                  }
                }),
      ),
    );
  }
}
