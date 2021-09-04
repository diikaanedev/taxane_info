import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-regroupenment.dart';

adminRegouprement({required BuildContext context}) async {
  Size size = MediaQuery.of(context).size;

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
                      width: size.width * .4,
                      // child: ListView(
                      //   scrollDirection: Axis.horizontal,
                      //   children: [
                      //     Container(
                      //       child: Row(
                      //         children: [
                      //           Container(
                      //               height: size.height * .04,
                      //               child: Center(
                      //                   child: Text(
                      //                 'Pays :',
                      //                 style: TextStyle(
                      //                     fontWeight: FontWeight.bold,
                      //                     color: vert,
                      //                     decoration: TextDecoration.underline),
                      //               ))),
                      //           SizedBox(
                      //             width: 8,
                      //           ),
                      //           StreamBuilder<QuerySnapshot>(
                      //               stream: FirebaseFirestore.instance
                      //                   .collection('pays')
                      //                   .snapshots(),
                      //               builder: (context, snapshot) {
                      //                 if (!snapshot.hasData) {
                      //                   return Container();
                      //                 } else {
                      //                   return Container(
                      //                     // width: size.width * .15,
                      //                     child: DropdownButton<String>(
                      //                         value: administrationFoncierState
                      //                             .paysSelected,
                      //                         onChanged: (String? newValue) {
                      //                           setState(() {
                      //                             administrationFoncierState
                      //                                 .paysSelected = newValue!;
                      //                           });
                      //                           FirebaseFirestore.instance
                      //                               .collection("pays")
                      //                               .doc(
                      //                                   administrationFoncierState
                      //                                       .paysSelected)
                      //                               .collection("regions")
                      //                               .get()
                      //                               .then((value) {
                      //                             if (value.docs.length > 0) {
                      //                               setState(() {
                      //                                 administrationFoncierState
                      //                                         .regionSlected =
                      //                                     value.docs.first.id;
                      //                               });
                      //                             } else {
                      //                               setState(() {
                      //                                 administrationFoncierState
                      //                                     .regionSlected = "";
                      //                               });
                      //                             }
                      //                           });
                      //                         },
                      //                         items: snapshot.data!.docs
                      //                             .map((e) => DropdownMenuItem(
                      //                                 value: e.id,
                      //                                 child: Text(
                      //                                     "${e.get("code")}-${e.get("nom")}")))
                      //                             .toList()),
                      //                     decoration: BoxDecoration(),
                      //                   );
                      //                 }
                      //               }),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 16,
                      //     ),
                      //     if (administrationFoncierState.regionSlected != "")
                      //       Container(
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //                 height: size.height * .04,
                      //                 child: Center(
                      //                     child: Text(
                      //                   'Regions :',
                      //                   style: TextStyle(
                      //                       fontWeight: FontWeight.bold,
                      //                       color: vert,
                      //                       decoration:
                      //                           TextDecoration.underline),
                      //                 ))),
                      //             SizedBox(
                      //               width: 8,
                      //             ),
                      //             StreamBuilder<QuerySnapshot>(
                      //                 stream: FirebaseFirestore.instance
                      //                     .collection('pays')
                      //                     .doc(administrationFoncierState
                      //                         .paysSelected)
                      //                     .collection("regions")
                      //                     .snapshots(),
                      //                 builder: (context, snapshot) {
                      //                   if (!snapshot.hasData) {
                      //                     return Container();
                      //                   } else {
                      //                     return Container(
                      //                       // width: size.width * .15,
                      //                       child: DropdownButton<String>(
                      //                           value:
                      //                               administrationFoncierState
                      //                                   .regionSlected,
                      //                           onChanged: (String? newValue) {
                      //                             setState(() {
                      //                               administrationFoncierState
                      //                                       .regionSlected =
                      //                                   newValue!;
                      //                             });
                      //                             FirebaseFirestore.instance
                      //                                 .collection("pays")
                      //                                 .doc(
                      //                                     administrationFoncierState
                      //                                         .paysSelected)
                      //                                 .collection("regions")
                      //                                 .doc(
                      //                                     administrationFoncierState
                      //                                         .regionSlected)
                      //                                 .collection(
                      //                                     "departements")
                      //                                 .get()
                      //                                 .then((value) {
                      //                               if (value.docs.length > 0) {
                      //                                 setState(() {
                      //                                   administrationFoncierState
                      //                                           .departementSelected =
                      //                                       value.docs.first.id;
                      //                                 });
                      //                               } else {
                      //                                 setState(() {
                      //                                   administrationFoncierState
                      //                                       .departementSelected = "";
                      //                                 });
                      //                               }
                      //                             });
                      //                           },
                      //                           items: snapshot.data!.docs
                      //                               .map((e) => DropdownMenuItem(
                      //                                   value: e.id,
                      //                                   child: Text(
                      //                                       "${e.get("code")}-${e.get("nom")}")))
                      //                               .toList()),
                      //                       decoration: BoxDecoration(),
                      //                     );
                      //                   }
                      //                 })
                      //           ],
                      //         ),
                      //       ),
                      //     if (administrationFoncierState.departementSelected !=
                      //         "")
                      //       Container(
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //                 height: size.height * .04,
                      //                 child: Center(
                      //                     child: Text(
                      //                   'Departement :',
                      //                   style: TextStyle(
                      //                       fontWeight: FontWeight.bold,
                      //                       color: vert,
                      //                       decoration:
                      //                           TextDecoration.underline),
                      //                 ))),
                      //             SizedBox(
                      //               width: 8,
                      //             ),
                      //             StreamBuilder<QuerySnapshot>(
                      //                 stream: FirebaseFirestore.instance
                      //                     .collection('pays')
                      //                     .doc(administrationFoncierState
                      //                         .paysSelected)
                      //                     .collection("regions")
                      //                     .doc(administrationFoncierState
                      //                         .regionSlected)
                      //                     .collection("departements")
                      //                     .snapshots(),
                      //                 builder: (context, snapshot) {
                      //                   if (!snapshot.hasData) {
                      //                     return Container();
                      //                   } else {
                      //                     return Container(
                      //                       // width: size.width * .15,
                      //                       child: DropdownButton<String>(
                      //                           value:
                      //                               administrationFoncierState
                      //                                   .departementSelected,
                      //                           onChanged: (String? newValue) {
                      //                             setState(() {
                      //                               administrationFoncierState
                      //                                       .departementSelected =
                      //                                   newValue!;
                      //                             });
                      //                             FirebaseFirestore.instance
                      //                                 .collection("pays")
                      //                                 .doc(
                      //                                     administrationFoncierState
                      //                                         .paysSelected)
                      //                                 .collection("regions")
                      //                                 .doc(
                      //                                     administrationFoncierState
                      //                                         .regionSlected)
                      //                                 .collection(
                      //                                     "departements")
                      //                                 .doc(administrationFoncierState
                      //                                     .departementSelected)
                      //                                 .collection("communes")
                      //                                 .get()
                      //                                 .then((value) {
                      //                               if (value.docs.length > 0) {
                      //                                 setState(() {
                      //                                   administrationFoncierState
                      //                                           .departementSelected =
                      //                                       value.docs.first.id;
                      //                                 });
                      //                               } else {
                      //                                 setState(() {
                      //                                   administrationFoncierState
                      //                                       .departementSelected = "";
                      //                                 });
                      //                               }
                      //                             });
                      //                           },
                      //                           items: snapshot.data!.docs
                      //                               .map((e) => DropdownMenuItem(
                      //                                   value: e.id,
                      //                                   child: Text(
                      //                                       "${e.get("code")}-${e.get("nom")}")))
                      //                               .toList()),
                      //                       decoration: BoxDecoration(),
                      //                     );
                      //                   }
                      //                 })
                      //           ],
                      //         ),
                      //       ),
                      //   ],
                      // ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => addRegroupement(context: context),
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

                        // snapshot.data!.get("regions") as List;
                        listes.addAll(snapshot.data!.docs.map((e) {
                          Timestamp timestamp = e.get('date');
                          DateTime date =
                              new DateTime.fromMicrosecondsSinceEpoch(
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
                                      e.get('name'),
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
                                          idRegroupement: e.id),
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
                          ]);
                        }).toList());

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
