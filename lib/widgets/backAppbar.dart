// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

PreferredSizeWidget backAppBar(BuildContext context,String name) {
  return AppBar(
          backgroundColor: warmBlueColor,
          centerTitle: true,
          title: Text(name),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          elevation: 0);
}
