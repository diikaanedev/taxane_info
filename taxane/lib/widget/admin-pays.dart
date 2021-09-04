import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-add-pays.dart';

adminPays({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pays').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: size.height * .3,
                width: size.width * .6,
                child: Center(child: CircularProgressIndicator()));
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
                          'Code Pays',
                          style: TextStyle(
                              color: vert, fontWeight: FontWeight.bold),
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
                          'Nom Pays',
                          style: TextStyle(
                              color: vert, fontWeight: FontWeight.bold),
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
                              color: vert, fontWeight: FontWeight.bold),
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
                              color: vert, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                      ],
                    )),
              ]),
            ];

            listes.addAll(snapshot.data!.docs.map((e) {
              Timestamp timestamp = e.get('date');
              DateTime date = new DateTime.fromMicrosecondsSinceEpoch(
                  timestamp.millisecondsSinceEpoch * 1000);
              return TableRow(children: [
                Container(
                    height: size.height * .05,
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          e.get('code'),
                          style: TextStyle(
                              color: vert, fontWeight: FontWeight.w300),
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
                          e.get('nom'),
                          style: TextStyle(
                              color: vert, fontWeight: FontWeight.w300),
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
                              color: vert, fontWeight: FontWeight.w300),
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
                          onTap: () =>
                              dialogEditPays(context: context, id: e.id),
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
                              dialogDeletePays(context: context, id: e.id),
                          child: Icon(
                            Icons.delete,
                            color: rouge,
                          ),
                        ),
                        Spacer(),
                      ],
                    )),
              ]);
            }));

            return AlertDialog(
              title: Container(
                width: size.width * .7,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .01,
                    ),
                    Text('Gestion des Pays'),
                    Spacer(),
                    GestureDetector(
                      onTap: () => dialogAddPays(context: context),
                      child: Container(
                        width: size.width * .1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Ajouter un pays',
                              style: TextStyle(
                                  fontSize: size.height * .015, color: blanc),
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
                    )
                  ],
                ),
              ),
              content: Container(
                height: size.height * .9,
                width: size.width * .7,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Table(
                      border: TableBorder.all(color: vert),
                      children: listes,
                    ),
                  ],
                ),
              ),
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
