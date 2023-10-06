// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class SettingsContent extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback OnPressed;
  const SettingsContent(this.icon, this.text, this.OnPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: silverColor.withOpacity(0.8),
      child: ListTile(
        onTap: OnPressed,
        leading: Icon(icon, size: 35, color: lightColor),
        title: Text(text,
            style: TextStyle(
                color: lightColor, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
