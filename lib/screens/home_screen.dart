// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/screens/reduction_details_screen.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/reductionWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "/HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ReductionWidget('Reduction ${index + 1}', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReductionDetailsScreen()));
              });
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
          ),
        ),
      ),
    );
  }
}
