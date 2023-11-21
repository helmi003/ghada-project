// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReductionWidget extends StatelessWidget {
  final String label;
  final bool role;
  final bool added;
  final bool removed;
  final VoidCallback onTap;
  final VoidCallback addRehab;
  final VoidCallback removeRehab;
  final int repeated;

  ReductionWidget(this.label, this.role, this.added, this.removed, this.onTap,
      this.addRehab, this.removeRehab, this.repeated);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: onTap,
            child: Container(
              width: 200,
              height: 300,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  label,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lightColor),
                ),
              ),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(20)),
            )),
        role && removed
            ? Positioned(
                top: 5,
                left: 5,
                child: GestureDetector(
                  onTap: removeRehab,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: redColor),
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.remove,
                        color: redColor,
                        size: 30,
                      )),
                ),
              )
            : SizedBox(),
        role && added
            ? Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: addRehab,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: greenColor),
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9, right: 9),
                        child: Text('+',
                            style: TextStyle(color: greenColor, fontSize: 30)),
                      )),
                ),
              )
            : SizedBox(),
        repeated > -1
            ? Positioned(
                bottom: 0,
                child: Container(
                    width: 168,
                    height: 50,
                    decoration: BoxDecoration(
                        color: warmBlueColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: AppLocalizations.of(context)!.repeated,
                            children: [
                              TextSpan(
                                  text: repeated.toString(), style: TextStyle(color: redColor)),
                              TextSpan(
                                text: AppLocalizations.of(context)!.times,
                              )
                            ],
                            style: TextStyle(
                                fontSize: 14,
                                color: lightColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    )),
              )
            : SizedBox()
      ],
    );
  }
}
