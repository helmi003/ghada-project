// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReductionDetailsScreen extends StatefulWidget {
  const ReductionDetailsScreen({super.key});
  static const routeName = "/ReductionDetailsScreen";

  @override
  State<ReductionDetailsScreen> createState() => _ReductionDetailsScreenState();
}

class _ReductionDetailsScreenState extends State<ReductionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 450,
              child: WebView(
                backgroundColor: bgColor,
                initialUrl: "https://app.vectary.com/p/0s424nRCVGOuzLvEKHPoaP",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
