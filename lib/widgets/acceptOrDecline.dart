// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class AcceptOrDecline extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;
  AcceptOrDecline(this.title, this.message,this.onTap);

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
      content: Text(message,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: lightColor)),
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
            child: Text('Yes',
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
            child: Text('No',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: lightColor)))
      ],
    );
  }
}
