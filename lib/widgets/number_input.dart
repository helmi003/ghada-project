// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class NumberInput extends StatelessWidget {
  final TextEditingController controller;
  NumberInput(this.controller);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextFormField(
          keyboardType: TextInputType.number,
          cursorColor: lightColor,
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: lightColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: lightColor, width: 2),
            ),
          ),
          style: TextStyle(color: lightColor, fontSize: 16)),
    );
  }
}
