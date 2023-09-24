// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ghada/screens/bluetooth/SelectBondedDevicePage.dart';
import 'package:ghada/screens/reduction_detail.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/appbar.dart';
import 'package:ghada/widgets/errorMessage.dart';
import 'package:ghada/widgets/reductionWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "/HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: GridView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ReductionWidget('Rehabilitation ${index + 1}', () async {
                bool? isEnabled =
                    await FlutterBluetoothSerial.instance.isEnabled;
                print(isEnabled);
                if (!isEnabled!) {
                  showDialog(
                      context: context,
                      builder: (context) => ErrorMessage(
                          'Alert', 'You have to open Bluetooth first!'));
                } else {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );
                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReductionDetail(
                                'Rehabilitation ${index + 1}',
                                selectedDevice)));
                  } else {
                    print('Connect -> no device selected');
                  }
                }
              });
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
          ),
        ),
      ),
    );
  }
}
