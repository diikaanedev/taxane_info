import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/agriculture-hortoculture.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/champs/dialog-champs.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/culture/admin-culture.dart';

adminAgriculture({
  required BuildContext context,
}) {
  Size size = MediaQuery.of(context).size;

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                                Text('Gestion des Champs'),
                                Spacer(),
                                Container(
                                  // width: size.width * .15,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("villages")
                                          .snapshots(),
                                      builder: (context, snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : DropdownButton<String>(
                                                value:
                                                    agricultureHortocultureState
                                                        .villageSelected,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    agricultureHortocultureState
                                                        .setState(() {
                                                      agricultureHortocultureState
                                                              .villageSelected =
                                                          newValue!;
                                                    });
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
                                  onTap: () => addChamps(
                                      context: context,
                                      idVillage: agricultureHortocultureState
                                          .villageSelected),
                                  child: Container(
                                    width: size.width * .1,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Ajouter une champs',
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
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .01,
                                ),
                                GestureDetector(
                                  onTap: () => adminCulture(context: context),
                                  child: Container(
                                    width: size.width * .1,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Gestion culture',
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
                                        color: rouge,
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Container(
                            height: size.height * .7,
                            width: size.width * .7,
                            child: LayoutBuilder(
                              builder: (context, constraints) => StreamBuilder<
                                      QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("champs")
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
                                                    'Code Champs',
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
                                                    'Surface Champs en m²',
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
                                                    "${e.get('surface')}",
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
                                                    onTap: () => null,
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
                                                    onTap: () => null,
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
                                  }),
                            ),
                          ),
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
          ));
}

adminAgricultureRole2(
    {required BuildContext context, required String villageId}) {
  Size size = MediaQuery.of(context).size;

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                                Text('Gestion des Champs'),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => addChamps(
                                      context: context, idVillage: villageId),
                                  child: Container(
                                    width: size.width * .1,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Ajouter une champs',
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
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .01,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Container(
                            height: size.height * .7,
                            width: size.width * .7,
                            child: LayoutBuilder(
                              builder: (context, constraints) => StreamBuilder<
                                      QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("champs")
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
                                                    'Code Champs',
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
                                                    'Surface Champs en m²',
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

                                      for (var item in snapshot.data!.docs) {
                                        if (item.get("village") == villageId) {
                                          Timestamp timestamp = item.get('date');
                                          DateTime date = new DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                              timestamp.millisecondsSinceEpoch *
                                                  1000);
                                          listes.add(TableRow(children: [
                                            Container(
                                                height:
                                                    constraints.maxHeight * .05,
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
                                                height:
                                                    constraints.maxHeight * .05,
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      "${item.get('surface')}",
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
                                                      onTap: () => null,
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
                                                      onTap: () => null,
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
                                  }),
                            ),
                          ),
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
          ));
}
