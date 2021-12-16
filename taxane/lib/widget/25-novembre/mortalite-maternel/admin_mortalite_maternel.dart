import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/25-novembre/mortalite-infatile/dialog_mortalite_infatile.dart';
import 'package:taxane/widget/25-novembre/mortalite-maternel/dialog_mortalite_maternel.dart';
import 'package:taxane/widget/25-novembre/violence-base-genre/dialog_violence_base_genre.dart';

adminMortaliteMaternel({required BuildContext context}) async {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: size.height * 8,
            width: size.width * .75,
            child: Column(
              children: [
                Container(
                  height: size.height * .04,
                  width: size.width * .75,
                  child: Row(
                    children: [
                      Text('Gestions des Mortalite Maternel'),
                      Spacer(),
                      GestureDetector(
                        onTap: () => null,
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
                                '   Ajouter une opération   ',
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
                              .collection("mortalite-maternel")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              List<TableRow> listes = [
                                TableRow(children: [
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.format_list_numbered,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Code',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.globe,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Nom Complet',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.globe,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Cause',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.globe,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Periode en (mois)',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.date_range_rounded,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Date des Faits',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.settings,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Paramètres',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                ])
                              ];

                              for (var item in snapshot.data!.docs) {
                                if (true) {
                                  Timestamp timestamp = item.get('dateDesFaits');
                                  DateTime date =
                                      new DateTime.fromMicrosecondsSinceEpoch(
                                          timestamp.millisecondsSinceEpoch *
                                              1000);
                                  listes.add(TableRow(children: [
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              item.get('code'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                               item.get('prenom') + ' ' + item.get('nom'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                         Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                               item.get('cause'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                        Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                               item.get('periode'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              dateFormatter(date),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
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
                                              width: constraints.maxWidth * .01,
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
                                        border: TableBorder.all(color: vert),
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
        },
      ));
    },
  );
}

adminMortaliteMaternelRole2(
    {required BuildContext context, required String idVillage}) async {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: size.height * 8,
            width: size.width * .75,
            child: Column(
              children: [
                Container(
                  height: size.height * .04,
                  width: size.width * .75,
                  child: Row(
                    children: [
                      Text('Gestions des Mortalites Maternel'),
                      Spacer(),
                      GestureDetector(
                        onTap: () => addOperationMortaliteMaternel(context: context, idVillage: idVillage),
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
                                '   Ajouter une opération   ',
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
                              .collection("mortalite-maternel")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                               List<TableRow> listes = [
                                TableRow(children: [
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.format_list_numbered,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Code',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.globe,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Nom Complet',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.globe,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Cause',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.globe,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .005,
                                          ),
                                          Text(
                                            'Periode',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.date_range_rounded,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Date des Faits',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.settings,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          ),
                                          Text(
                                            'Paramètres',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                ])
                              ];

                              for (var item in snapshot.data!.docs) {
                                if (item.get("village") == idVillage) {
                                  Timestamp timestamp = item.get('dateDesFaits');
                                  DateTime date =
                                      new DateTime.fromMicrosecondsSinceEpoch(
                                          timestamp.millisecondsSinceEpoch *
                                              1000);
                                  listes.add(TableRow(children: [
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              item.get('code'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                               item.get('prenom') + ' ' + item.get('nom'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                         Container(
                                        // height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                               item.get('cause'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                        Container(
                                        // height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                               item.get('periode'),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              dateFormatter(date),
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
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
                                              width: constraints.maxWidth * .01,
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
                                        border: TableBorder.all(color: vert),
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
        },
      ));
    },
  );
}
