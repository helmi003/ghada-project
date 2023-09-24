// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class ReductionWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  ReductionWidget(this.label,this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 80,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            label,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: lightColor),
          ),
        ),
        decoration: BoxDecoration(
            color: warmBlueColor, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
