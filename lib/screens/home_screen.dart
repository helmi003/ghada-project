// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/screens/reduction_detail.dart';
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
        child: Stack(
          children: [
            Positioned(
                bottom: 10,
                right: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/laboratoire logo.jpeg',
                    width: 100,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20,vertical: 5),
              child: GridView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ReductionWidget('Reduction ${index + 1}', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReductionDetail('Reduction ${index + 1}')));
                  });
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
