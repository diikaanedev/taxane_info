import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-commune.dart';
import 'package:taxane/widget/dialog-village.dart';

adminVillage({required BuildContext context}) async {
  Size size = MediaQuery.of(context).size;

  await FirebaseFirestore.instance
      .collection("pays")
      .doc(administrationFoncierState.paysSelected)
      .collection("regions")
      .doc(administrationFoncierState.regionSlected)
      .collection("departements")
      .doc(administrationFoncierState.departementSelected)
      .collection("communes")
      .doc(administrationFoncierState.communeSelected)
      .collection("villages")
      .get()
      .then((value) {
    if (value.docs.length > 0) {
      administrationFoncierState.setState(() {
        administrationFoncierState.villageSelected = value.docs.first.id;
      });
    } else {
      administrationFoncierState.setState(() {
        administrationFoncierState.villageSelected = '';
      });
    }
  });
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              content: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("pays")
                .doc(administrationFoncierState.paysSelected)
                .collection("regions")
                .doc(administrationFoncierState.regionSlected)
                .collection("departements")
                .doc(administrationFoncierState.departementSelected)
                .collection("communes")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return StatefulBuilder(builder: (context, setState) {
                  return Container(
                    height: size.height * .8,
                    width: size.width * .7,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * .04,
                          width: size.width * .7,
                          child: Row(
                            children: [
                              Text('Gestions des Villages/Quartiers'),
                              Spacer(),
                              Container(
                                // width: size.width * .15,
                                child: DropdownButton<String>(
                                    value: administrationFoncierState
                                        .communeSelected,
                                    onChanged: (String? newValue) {
                                      print("villages communeSelected");
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState
                                              .communeSelected = newValue!;
                                        });
                                      });
                                    },
                                    items: snapshot.data!.docs
                                        .map((e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(
                                                "${e.get("code")}-${e.get("nom")}")))
                                        .toList()),
                                decoration: BoxDecoration(),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => dialogAddVillage(
                                    context: context,
                                    idPays:
                                        administrationFoncierState.paysSelected,
                                    idRegion: administrationFoncierState
                                        .regionSlected,
                                    idDepartement: administrationFoncierState
                                        .departementSelected,
                                    idCommune: administrationFoncierState
                                        .communeSelected),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: vert,
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                          child: Text(
                                        '   Ajouter une village/quartier   ',
                                        style: TextStyle(color: blanc),
                                      )),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: size.height * .7,
                          width: size.width,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("pays")
                                      .doc(administrationFoncierState
                                          .paysSelected)
                                      .collection("regions")
                                      .doc(administrationFoncierState
                                          .regionSlected)
                                      .collection("departements")
                                      .doc(administrationFoncierState
                                          .departementSelected)
                                      .collection("communes")
                                      .doc(administrationFoncierState
                                          .communeSelected)
                                      .collection("villages")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else {
                                      List<TableRow> listes = [
                                        TableRow(children: [
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.format_list_numbered,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Code Village/Quartier',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    CupertinoIcons.globe,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Nom Village/Quartier',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.date_range_rounded,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Date',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.settings,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Paramètres',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                        ])
                                      ];

                                      // snapshot.data!.get("regions") as List;
                                      listes
                                          .addAll(snapshot.data!.docs.map((e) {
                                        Timestamp timestamp = e.get('date');
                                        DateTime date = new DateTime
                                                .fromMicrosecondsSinceEpoch(
                                            timestamp.millisecondsSinceEpoch *
                                                1000);
                                        return TableRow(children: [
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    e.get('code'),
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    e.get('nom'),
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    dateFormatter(date),
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () => dialogEditVillage(
                                                        context: context,
                                                        idPays: administrationFoncierState
                                                            .paysSelected,
                                                        idRegion:
                                                            administrationFoncierState
                                                                .regionSlected,
                                                        idDepartement:
                                                            administrationFoncierState
                                                                .departementSelected,
                                                        idCommune:
                                                            administrationFoncierState
                                                                .communeSelected,
                                                        idVillage: e.id),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: vert,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => dialogDeleteCommune(
                                                        context: context,
                                                        idPays:
                                                            administrationFoncierState
                                                                .paysSelected,
                                                        idRegion:
                                                            administrationFoncierState
                                                                .regionSlected,
                                                        idDepartement:
                                                            administrationFoncierState
                                                                .departementSelected,
                                                        idCommune: e.id),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: rouge,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                        ]);
                                      }).toList());
                                      return Container(
                                        height: constraints.maxHeight,
                                        width: constraints.maxWidth,
                                        child: ListView(
                                          children: [
                                            Container(
                                              child: Table(
                                                border: TableBorder.all(
                                                    color: vert),
                                                children: listes,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  });
                            },
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: size.height * .04,
                          width: size.width * .7,
                          child: Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                    height: size.height * .04,
                                    color: rouge,
                                    child: Center(
                                      child: Text(
                                        '   Fermer   ',
                                        style: TextStyle(color: blanc),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
              }
            },
          )));
}