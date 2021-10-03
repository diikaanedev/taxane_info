import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/elevages/animaux/admin-aminaux.dart';
import 'package:taxane/widget/elevages/troupeaux/admin-troupeaux.dart';

adminVariationEffectif({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
    TextEditingController code =
                TextEditingController();  
  return showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      height: size.height * .7,
      width: size.width * .6,
      child: Column(
        children: [
            Container(
                    width: size.width * .7,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * .01,
                        ),
                        Text('Gestion de Variation de l’effectif '),
                        Spacer(),

                                            Container(
                      height: size.height * .04,
                      width: size.width * .3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: code,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Code animal',
                              icon: Icon(CupertinoIcons.globe)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                       
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                   Container(
                    height: size.height * .6,
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
                                            'Code Betes',
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
                                            'Nom Trapeaux',
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

                              snapshot.data!.docs.map((e) {
                                if (code.text.isEmpty) {
                                   Timestamp timestamp = e.get('date');
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
                                ]));
                                } else {
                                  
                                }
                              });

                              listes.addAll(snapshot.data!.docs.map((e) {
                                Timestamp timestamp = e.get('date');
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