import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/comptabilite.dart';
import 'package:taxane/utils/color-by-dii.dart';

addMiseEnPlaceBudgetaire({
  required BuildContext context,
}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
        TextEditingController description = TextEditingController();
        TextEditingController coutTotal = TextEditingController();
        return AlertDialog(
          content: Container(
            height: size.height * .8,
            width: size.width * .5,
            child: StatefulBuilder(builder: (context, setState) {
              return Column(
                children: [
                  Spacer(),
                  Container(
                    height: size.height * .1,
                    child: Center(
                      child: Text(
                        'Formulaire de mise en place budget',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: noir,
                            fontSize: size.height * .03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    height: size.height * .05,
                    width: size.width * .4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
                        cursorColor: vert,
                        controller: code,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Code',
                            icon: Icon(CupertinoIcons.globe)),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: vert),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    height: size.height * .05,
                    width: size.width * .4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
                        cursorColor: vert,
                        controller: nom,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Nom',
                            icon: Icon(CupertinoIcons.map)),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: vert),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    height: size.height * .05,
                    width: size.width * .4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
                        cursorColor: vert,
                        controller: description,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Description',
                            icon: Icon(CupertinoIcons.map)),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: vert),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    height: size.height * .05,
                    width: size.width * .4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
                        cursorColor: vert,
                        controller: coutTotal,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'cout total',
                            icon: Icon(CupertinoIcons.map)),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: vert),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    height: size.height * .05,
                    width: size.width * .4,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Text(
                              ' Période : ',
                              style: TextStyle(
                                color: noir,
                                fontSize: size.height * .02,
                              ),
                            ),
                            SizedBox(
                              child: GestureDetector(
                                onTap: () async {
                                  showDatePicker(
                                          context: context,
                                          initialDate:
                                              comptabiliteState.initialPeriod,
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2030))
                                      .then((value) => setState(() {
                                            comptabiliteState.setState(() {
                                              comptabiliteState.initialPeriod =
                                                  value!;
                                            });
                                          }));
                                },
                                child: Container(
                                    height: size.height * .03,
                                    decoration: BoxDecoration(
                                        color: vert,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                        child: Text('   Date Initiale   ',
                                            style: TextStyle(
                                                color: blanc,
                                                fontSize: size.width * .01)))),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                '${comptabiliteState.initialPeriod.day}-${comptabiliteState.initialPeriod.month}-${comptabiliteState.initialPeriod.year}'),
                            Spacer(),
                            SizedBox(
                              child: GestureDetector(
                                onTap: () async {
                                  showDatePicker(
                                          context: context,
                                          initialDate:
                                              comptabiliteState.finalPeriod,
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          firstDate:
                                              comptabiliteState.initialPeriod,
                                          lastDate: DateTime(2030))
                                      .then((value) => setState(() {
                                            comptabiliteState.setState(() {
                                              comptabiliteState.finalPeriod =
                                                  value!;
                                            });
                                          }));
                                },
                                child: Container(
                                    height: size.height * .03,
                                    decoration: BoxDecoration(
                                        color: vert,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                        child: Text('   Date Finale   ',
                                            style: TextStyle(
                                                color: blanc,
                                                fontSize: size.width * .01)))),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                '${comptabiliteState.finalPeriod.day}-${comptabiliteState.finalPeriod.month}-${comptabiliteState.finalPeriod.year}'),
                            SizedBox(
                              width: 16,
                            ),
                            Spacer(),
                          ],
                        )),
                    decoration: BoxDecoration(
                        // border: Border.all(color: vert),
                        // borderRadius: BorderRadius.circular(8)
                        ),
                  ),
                  SizedBox(
                    height: size.height * .1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FirebaseFirestore.instance.collection("budgets").add({
                        "code": code.text,
                        "nom": nom.text,
                        "description": description.text,
                        "coutTotal": coutTotal.text,
                        "dateDebut" : comptabiliteState.initialPeriod,
                        "dateFin" : comptabiliteState.finalPeriod, 
                        "date": DateTime.now()
                      }).then((value) async {
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      height: size.height * .05,
                      width: size.width * .2,
                      child: Center(
                        child: Text(
                          'Ajouter',
                          style: TextStyle(
                              color: jaune, fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: jaune),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Spacer(),
                ],
              );
            }),
          ),
          actions: [
            // ignore: deprecated_member_use
            RaisedButton(
                color: rouge,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "   Fermer   ",
                  style: TextStyle(
                      fontSize: size.height * .015,
                      fontWeight: FontWeight.bold,
                      color: blanc),
                ))
          ],
        );
      });
}
