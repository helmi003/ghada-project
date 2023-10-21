// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetCamera extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onPressed2;
  BottomSheetCamera(this.onPressed,this.onPressed2);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(AppLocalizations.of(context)!.choosePhoto,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: lightColor)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.camera_alt,
                    color: primaryColor,
                  ),
                  label: Text(AppLocalizations.of(context)!.camera,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: lightColor))),
              TextButton.icon(
                  onPressed: onPressed2,
                  icon: Icon(
                    Icons.image,
                    color: primaryColor,
                  ),
                  label: Text(AppLocalizations.of(context)!.gallery,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: lightColor))),
            ],
          )
        ],
      ),
    );
  }
}
