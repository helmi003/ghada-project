// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/screens/reduction_detail.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/appbar.dart';
import 'package:ghada/widgets/reductionWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "/HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:20,vertical: 5),
          child: GridView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ReductionWidget('Rehabilitation ${index + 1}', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReductionDetail('Rehabilitation ${index + 1}')));
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
