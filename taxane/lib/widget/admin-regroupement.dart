import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-regroupenment.dart';

adminRegouprement({required BuildContext context}) async {
  Size size = MediaQuery.of(context).size;
  await FirebaseFirestore.instance
      .collection("villages")
      .get()
      .then((value) => administrationFoncierState.setState(() {
            administrationFoncierState.villageSelected = value.docs.first.id;
          }));
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(content: StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: size.height * .9,
          width: size.width * .7,
          child: Column(
            children: [
              // Spacer(),
              Container(
                height: size.height * .04,
                child: Row(
                  children: [
                    Text('Gestion des Regroupement ou Associations'),
                    Spacer(),
                    Container(
                      /* width: size.width * .4, */
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("villages")
                              .snapshots(),
                          builder: (ctx, snap) => !snap.hasData
                              ? Container()
                              : DropdownButton<String>(
                                  value: administrationFoncierState
                                      .villageSelected,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      administrationFoncierState.setState(() {
                                        administrationFoncierState
                                            .villageSelected = newValue!;
                                      });
                                    });
                                  },
                                  items: snap.data!.docs
                                      .map((e) => DropdownMenuItem(
                                          value: e.id,
                                          child: Text(
                                              "${e.get("code")}-${e.get("nom")}")))
                                      .toList())),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => addRegroupement(
                          context: context,
                          idVillage:
                              administrationFoncierState.villageSelected),
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
                              '   Ajouter un Regroupement   ',
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
                width: size.width * .7,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("regroupements")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
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
                                      'Code Regroupement',
                                      style: TextStyle(
                                          color: vert,
                                          fontWeight: FontWeight.bold),
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
                                      'Nom Regroupement',
                                      style: TextStyle(
                                          color: vert,
                                          fontWeight: FontWeight.bold),
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
                                          fontWeight: FontWeight.bold),
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                  ],
                                )),
                          ])
                        ];

                        for (var item in snapshot.data!.docs) {
                          if (item.get("villages") ==
                              administrationFoncierState.villageSelected) {
                            Timestamp timestamp = item.get('date');
                            DateTime date =
                                new DateTime.fromMicrosecondsSinceEpoch(
                                    timestamp.millisecondsSinceEpoch * 1000);
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
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
                                        item.get('name'),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: vert,
                                            fontWeight: FontWeight.w300),
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
                                            fontWeight: FontWeight.w300),
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
                                        onTap: () => showRegroupement(
                                            context: context,
                                            idRegroupement: item.id),
                                        child: Icon(
                                          CupertinoIcons.eye_fill,
                                          color: jaune,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * .01,
                                      ),
                                      GestureDetector(
                                        onTap: () => null,
                                        child: Icon(
                                          Icons.edit,
                                          color: vert,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * .01,
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

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            return ListView(
                              children: [
                                Container(
                                  child: Table(
                                    children: listes,
                                    border:
                                        TableBorder.all(color: vert, width: .5),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }
                    }),
              ),
              Spacer(),
              Container(
                height: size.height * .04,
              ),
              Spacer(),
            ],
          ),
        );
      },
    )),
  );
}
