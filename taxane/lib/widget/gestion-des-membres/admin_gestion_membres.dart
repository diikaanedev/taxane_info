import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/gestion-des-membres/dialog_gestion_membres.dart';

adminGestionMembres(
    {required BuildContext context, required String idRegroupement}) async {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: size.height * 8,
                width: size.width * .7,
                child: Column(
                  children: [
                    Container(
                      height: size.height * .04,
                      width: size.width * .7,
                      child: Row(
                        children: [
                          Text('Gestions des Membres'),
                          Spacer(),
                          GestureDetector(
                            onTap: () => addMembreGestionMembre(context: context, idRegroupement: idRegroupement),
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
                                    '   Ajouter un membres   ',
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
                                  .collection("membres")
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
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'CNI Membre',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Nom Membre',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                width:
                                                    constraints.maxWidth * .01,
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
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Icon(
                                                Icons.settings,
                                                color: vert,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .01,
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
                                    if (item.get("regroupements") ==
                                        idRegroupement) {
                                      Timestamp timestamp = item.get('date');
                                      DateTime date = new DateTime
                                              .fromMicrosecondsSinceEpoch(
                                          timestamp.millisecondsSinceEpoch *
                                              1000);
                                      listes.add(TableRow(children: [
                                        Container(
                                            height: constraints.maxHeight * .05,
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  item.get('cni'),
                                                  style: TextStyle(
                                                      color: vert,
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                   item.get('prenom') + ' ' +item.get('name'),
                                                  style: TextStyle(
                                                      color: vert,
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                  width: constraints.maxWidth *
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
                                            border:
                                                TableBorder.all(color: vert),
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
          ),
        );
      });
}
