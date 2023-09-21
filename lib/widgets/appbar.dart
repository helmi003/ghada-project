// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
      backgroundColor: lightColor,
      // centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Image.asset(
              'assets/images/laboratoire logo.jpeg',
              height: 60,
            ),
          
          Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
        ],
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      elevation: 0);
}
