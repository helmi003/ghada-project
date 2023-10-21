// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

PreferredSizeWidget appBar(BuildContext context, String text) {
  return AppBar(
      backgroundColor: warmBlueColor,
      title: Text(text),
      centerTitle: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      elevation: 0);
}
