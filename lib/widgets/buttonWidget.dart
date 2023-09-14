// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool isLoading;
  ButtonWidget(this.onTap, this.label, this.isLoading);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 60,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: lightColor,
                )
              : Text(
                  label,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lightColor),
                ),
        ),
        decoration: BoxDecoration(
            color: warmBlueColor, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
