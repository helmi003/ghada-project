// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String error;
  final String label;
  final bool obscureText;
  final VoidCallback showHide;
  PasswordFieldWidget(this.controller, this.label, this.error,this.obscureText,this.showHide);

  @override
  Widget build(BuildContext context) {
    

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "${AppLocalizations.of(context)!.the} $label ${AppLocalizations.of(context)!.isRequired}";
                }
                return null;
              },
              cursorColor: warmBlueColor,
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: showHide,
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: warmBlueColor,
                    )),
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                labelText: label,
                labelStyle: TextStyle(color: warmBlueColor, fontSize: 16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: darkColor, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: darkColor, width: 2),
                ),
              ),
              style: TextStyle(color: warmBlueColor, fontSize: 16)),
        ),
        error != ""
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 5,right: 40),
                    child: Text(
                      error,
                      style: TextStyle(
                        color: redColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
