// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class ErrorMessage extends StatelessWidget {
  final String title;
  final String errorMsg;
  ErrorMessage(this.title,this.errorMsg);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: redColor,
            fontWeight: FontWeight.bold,
          )),
      content: Text(errorMsg,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    );
  }
}
