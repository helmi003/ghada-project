// ignore_for_file: prefer_const_constructors, equal_keys_in_map, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghada/l10n/l10n.dart';
import 'package:ghada/screens/Tab_screen.dart';
import 'package:ghada/screens/authentication/register_screen.dart';
import 'package:ghada/screens/patient_screen.dart';
import 'package:ghada/screens/authentication/login_screen.dart';
import 'package:ghada/screens/rehab_test.dart';
import 'package:ghada/screens/splash_screen.dart';
import 'package:ghada/service/languageProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final languageProvider = LanguageProvider();
  runApp(
    ChangeNotifierProvider(
      create: (_) => languageProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedLocale = context.watch<LanguageProvider>().selectedLocale;
    return MaterialApp(
      title: 'Hand rehab',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: RehabTest('Hand rehab','moving_hand1.mp4'),
      routes: {
        PatientScreen.routeName: (ctx) => PatientScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == TabScreen.routeName) {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return TabScreen(role: args);
            },
          );
        }
        return null;
      },
      supportedLocales: L10n.all,
      locale: selectedLocale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}
