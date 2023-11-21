// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghada/widgets/number_input.dart';

class AddRehabToPatient extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;
  final TextEditingController controller;
  AddRehabToPatient(this.title, this.message, this.onTap, this.controller);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: warmBlueColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(title,
          style: TextStyle(
            fontSize: 30,
            color: redColor,
            fontWeight: FontWeight.bold,
          )),
      content: Container(
        height: 150,
        child: Column(children: [
          Text(message,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: lightColor)),
          SizedBox(height: 20),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.numberOfRepeatation,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightColor)),
              NumberInput(controller),
            ],
          ),
        ]),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
            child: Text(AppLocalizations.of(context)!.yes,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: lightColor))),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
            child: Text(AppLocalizations.of(context)!.no,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: lightColor)))
      ],
    );
  }
}
