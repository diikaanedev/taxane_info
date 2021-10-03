import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/elevages/betes/dialog-bete.dart';

adminBete({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      height: size.height * .6,
      width: size.width * .5,
      child: Column(
        children: [
            Container(
                    width: size.width * .6,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * .01,
                        ),
                        Text('Gestion des Bêtes'),
                        Spacer(),
                        GestureDetector(
                          onTap: () => addBete(context: context),
                          child: Container(
                            /* width: size.width * .1, */
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '  Ajouter une espece animal  ',
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
                        SizedBox(
                          width: size.width * .01,
                        ),
                       /*  GestureDetector(
                          onTap: () => null,
                          child: Container(
                            /* width: size.width * .1, */
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '   Gestion des animaux   ',
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
                        ), */
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Container(
                    height: size.height * .5,
                    width: size.width * .7,
                    child: LayoutBuilder(
                      builder: (context, constraints) => StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("betes")
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
                                            'Code Animal',
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
                                            'Matricule Troupeaux',
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
                                            'Date',
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

                              listes.addAll(snapshot.data!.docs.map((e) {
                                Timestamp timestamp = e.get('dateNaiss');
                                DateTime date =
                                    new DateTime.fromMicrosecondsSinceEpoch(
                                        timestamp.millisecondsSinceEpoch *
                                            1000);
                                return TableRow(children: [
                                  Container(
                                      height: constraints.maxHeight * .05,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Text(
                                            e.get('code'),
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
                                            "${e.get('troupeaux')}",
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
                                ]);
                              }).toList());

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
                          }),
                    ),
                  ),
               
        ],
      ),
    ),
  ));
}