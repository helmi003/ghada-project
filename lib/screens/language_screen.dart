// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghada/service/languageProvider.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/backAppbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

enum SingingCharacter { english, french, arabic }

class _LanguagesScreenState extends State<LanguagesScreen> {
  Locale? loc;
  SingingCharacter? lang;
  SharedPreferences? prefs;
  getLangauges() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getLangauges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale loc = Provider.of<LanguageProvider>(context).selectedLocale;
    lang = loc == Locale('en')
        ? SingingCharacter.english
        : loc == Locale('fr')
            ? SingingCharacter.french
            : SingingCharacter.arabic;
    return Scaffold(
      backgroundColor: lightColor,
      appBar:
          backAppBar(context, AppLocalizations.of(context)!.preferedLanguage),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: loc == Locale('en')
                  ? primaryColor
                  : silverColor.withOpacity(0.5),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/english.png',
                  width: 60,
                ),
                title: Text(
                  AppLocalizations.of(context)!.english,
                  style: TextStyle(
                      color: warmBlueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                trailing: Radio<SingingCharacter>(
                  fillColor:
                      MaterialStateColor.resolveWith((states) => warmBlueColor),
                  value: SingingCharacter.english,
                  groupValue: lang,
                  onChanged: (SingingCharacter? value) async {
                    setState(() {
                      lang = value;
                      context.read<LanguageProvider>().setLanguage(Locale('en'));
                      prefs!.setString('language', 'en');
                    });
                  },
                ),
              ),
            ),
            Card(
              color: loc == Locale('fr')
                  ? primaryColor
                  : silverColor.withOpacity(0.5),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/french.png',
                  width: 60,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    AppLocalizations.of(context)!.french,
                    style: TextStyle(
                        color: warmBlueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                trailing: Radio<SingingCharacter>(
                  fillColor:
                      MaterialStateColor.resolveWith((states) => warmBlueColor),
                  value: SingingCharacter.french,
                  groupValue: lang,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      lang = value;
                      context.read<LanguageProvider>().setLanguage(Locale('fr'));
                      prefs!.setString('language', 'fr');
                    });
                  },
                ),
              ),
            ),
            Card(
              color: loc == Locale('ar')
                  ? primaryColor
                  : silverColor.withOpacity(0.5),
              child: ListTile(
                  leading: Image.asset(
                    'assets/images/arabic.png',
                    width: 60,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      AppLocalizations.of(context)!.arabic,
                      style: TextStyle(
                          color: warmBlueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  trailing: Radio<SingingCharacter>(
                    fillColor:
                        MaterialStateColor.resolveWith((states) => warmBlueColor),
                    value: SingingCharacter.arabic,
                    groupValue: lang,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        lang = value;
                        context.read<LanguageProvider>().setLanguage(Locale('ar'));
                        prefs!.setString('language', 'ar');
                      });
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
