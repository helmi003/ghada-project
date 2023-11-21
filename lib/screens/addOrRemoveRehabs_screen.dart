// ignore_for_file: camel_case_types, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/addRehabToPatient.dart';
import 'package:ghada/widgets/removeRehabFromPatient.dart';
import 'package:ghada/widgets/backAppbar.dart';
import 'package:ghada/widgets/loadingWidget.dart';
import 'package:ghada/widgets/reductionWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class addOrRemoveRehabs extends StatefulWidget {
  Map<String, dynamic> patient;
  String patientId;
  addOrRemoveRehabs(this.patient, this.patientId);

  @override
  State<addOrRemoveRehabs> createState() => _addOrRemoveRehabsState();
}

class _addOrRemoveRehabsState extends State<addOrRemoveRehabs> {
  bool isLoading = false;
  TextEditingController controller = TextEditingController(text: 0.toString());
  int repeated = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColor,
        appBar: backAppBar(context,
            "${AppLocalizations.of(context)!.rehabsOf} ${widget.patient['name']}"),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('rehabs').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingWidget();
            } else {
              var data = snapshot.data!.docs;
              return isLoading
                  ? LoadingWidget()
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: GridView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          List list = widget.patient['rehabs'];
                          return ReductionWidget(
                              data[index]['name'],
                              true,
                              !isRehabIdPresent(list, data[index].id),
                              isRehabIdPresent(list, data[index].id),
                              () {}, () async {
                            showDialog(
                              context: context,
                              builder: (context) => AddRehabToPatient(
                                  AppLocalizations.of(context)!.add,
                                  "${AppLocalizations.of(context)!.rehabTo} ${widget.patient['name']}",
                                  () async {
                                if (controller.text != "") {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  list.add({
                                    "rehabId": data[index].id,
                                    "repeated": int.parse(controller.text)
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.patientId)
                                      .update({'rehabs': list});
                                  Navigator.of(context).pop();
                                  setState(() {
                                    controller.text=0.toString();
                                    isLoading = false;
                                  });
                                }
                              }, controller),
                            );
                          }, () async {
                            showDialog(
                              context: context,
                              builder: (context) => RemoveRehabFromPatient(
                                  AppLocalizations.of(context)!.remove,
                                  "${AppLocalizations.of(context)!.removeRehabFrom} ${widget.patient['name']}",
                                  () async {
                                setState(() {
                                  isLoading = true;
                                });
                                list.removeWhere((element) =>
                                    element['rehabId'] == data[index].id);
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.patientId)
                                    .update({'rehabs': list});
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = false;
                                });
                              }),
                            );
                          },
                              isRehabIdPresent(list, data[index].id)
                                  ? repeatedRehabs(list, data[index].id)
                                  : -1);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                      ),
                    );
            }
          },
        ));
  }

  bool isRehabIdPresent(List<dynamic> rehabs, String rehabId) {
    for (var rehab in rehabs) {
      if (rehab['rehabId'] == rehabId) {
        return true;
      }
    }
    return false;
  }

  int repeatedRehabs(List<dynamic> rehabs, String rehabId) {
    for (var rehab in rehabs) {
      if (rehab['rehabId'] == rehabId) {
        return rehab['repeated'];
      }
    }
    return -1;
  }
}
