// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: warmBlueColor,
      ),
    );
  }
}
