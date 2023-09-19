// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/screens/home_screen.dart';
import 'package:ghada/screens/profile_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabScreen extends StatefulWidget {
  TabScreen({super.key});
  static const routeName = "/TabScreen";

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int currentIndex = 0;

  final List<Widget> children = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: children[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        decoration: BoxDecoration(
          color: warmBlueColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: GNav(
            backgroundColor: warmBlueColor,
            color: lightColor,
            activeColor: lightColor,
            tabBackgroundColor: lightColor.withOpacity(0.4),
            padding: EdgeInsets.all(10),
            iconSize:30,
            textSize: 30,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            gap: 8,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ]),
      ),
    );
  }
}
