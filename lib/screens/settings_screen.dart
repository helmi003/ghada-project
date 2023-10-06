// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ghada/screens/language_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/appbar.dart';
import 'package:ghada/widgets/settingsWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, AppLocalizations.of(context)!.settings),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SettingsContent(
              Icons.language, AppLocalizations.of(context)!.changeLanguage, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LanguagesScreen()));
          }),
        ),
        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/laboratoire logo.jpeg',
                width: 100,
              ),
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 60,
            ),
          ],
        ),
        SizedBox(height: 10)
      ]),
    );
  }
}
