// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  TextFieldWidget(this.controller,this.label);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {

    return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The ${widget.label} is required";
                    }
                    return null;
                  },
                  cursorColor: warmBlueColor,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    border: InputBorder.none,
                    labelText: widget.label,
                    labelStyle: TextStyle(color: darkColor, fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: lightColor,width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: lightColor,width: 2),
                    ),
                  ),
                  style: TextStyle(color: darkColor, fontSize: 16)),
            );
  }
}