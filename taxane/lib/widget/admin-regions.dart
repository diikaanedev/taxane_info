import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-region.dart';

adminRegion({required BuildContext context, required String idPays}) async {
  Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('regions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: size.height * .3,
                width: size.width * .6,
                child: Center(child: CircularProgressIndicator()));
          } else {
            return AlertDialog(
              content: StatefulBuilder(builder: (context, setState) {
                return Container(
                    height: size.height * .9,
                    width: size.width * .7,
                    child: Container(
                        height: size.height * .9,
                        width: size.width * .7,
                        child: Column(
                          children: [
                            Container(
                              width: size.width * .7,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * .01,
                                  ),
                                  Text('Gestion des Régions'),
                                  Spacer(),
                                  Container(
                                    // width: size.width * .15,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("pays")
                                            .snapshots(),
                                        builder: (context, snap) {
                                          return !snap.hasData
                                              ? Container()
                                              : DropdownButton<String>(
                                                  value:
                                                      administrationFoncierState
                                                          .paysSelected,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      administrationFoncierState
                                                              .paysSelected =
                                                          newValue!;
                                                    });
                                                  },
                                                  items: snap.data!.docs
                                                      .map((e) => DropdownMenuItem(
                                                          value: e.id,
                                                          child: Text(
                                                              "${e.get("code")}-${e.get("nom")}")))
                                                      .toList());
                                        }),
                                    decoration: BoxDecoration(),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () => dialogAddRegion(
                                        context: context,
                                        id: administrationFoncierState
                                            .paysSelected),
                                    child: Container(
                                      width: size.width * .1,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Ajouter une region',
                                            style: TextStyle(
                                                fontSize: size.height * .015,
                                                color: blanc),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: vert,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * .01,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            Container(
                                height: size.height * .8,
                                width: size.width * .7,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('regions')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                        height: 50,
                                        width: 50,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    } else {
                                      List<TableRow> listes = [
                                        TableRow(children: [
                                          Container(
                                              height: size.height * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.format_list_numbered,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * .01,
                                                  ),
                                                  Text(
                                                    'Code Région',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height: size.height * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    CupertinoIcons.globe,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * .01,
                                                  ),
                                                  Text(
                                                    'Nom Région',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height: size.height * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.date_range_rounded,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * .01,
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
                                              height: size.height * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.settings,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * .01,
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

                                      for (var item in snapshot.data!.docs) {
                                        if (item.get("pays") ==
                                            administrationFoncierState
                                                .paysSelected) {
                                          Timestamp timestamp =
                                              item.get('date');
                                          DateTime date = new DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                              timestamp.millisecondsSinceEpoch *
                                                  1000);
                                          listes.add(TableRow(children: [
                                            Container(
                                                height: size.height * .05,
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      item.get('code'),
                                                      style: TextStyle(
                                                          color: vert,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                )),
                                            Container(
                                                height: size.height * .05,
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      item.get('nom'),
                                                      style: TextStyle(
                                                          color: vert,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                )),
                                            Container(
                                                height: size.height * .05,
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
                                                height: size.height * .05,
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    GestureDetector(
                                                      onTap: () => dialogEditRegion(
                                                          context: context,
                                                          id: administrationFoncierState
                                                              .paysSelected,
                                                          idRegion: item.id),
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: vert,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .01,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          dialogDeleteRegion(
                                                              context: context,
                                                              id: administrationFoncierState
                                                                  .paysSelected,
                                                              idRegion:
                                                                  item.id),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: rouge,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                )),
                                          ]));
                                        }
                                      }

                                      return LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Container(
                                            height: constraints.maxHeight,
                                            width: size.width,
                                            child: ListView(
                                              physics: BouncingScrollPhysics(),
                                              children: [
                                                Table(
                                                  border: TableBorder.all(
                                                      color: vert),
                                                  children: listes,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                )),
                          ],
                        )));
              }),
              actions: [
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
          }
        }),
  );
}
