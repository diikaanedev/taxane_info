import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/comptabilite/gestion-des-budget/excecution/dialog-excecution-budgetaire.dart';

showExecutionBudgetaire(
    {required BuildContext context, required String idOperation}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              height: size.height * .9,
              width: size.width * .8,
              child: Column(
                children: [
                  Container(
                    /*  height: size.height * .07, */
                    width: size.width * .8,
                    child: Row(
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("/budgets")
                                .doc(idOperation)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return !snapshot.hasData
                                  ? Text('')
                                  : Text(
                                      'Execution du budget ${snapshot.data!.get("nom")}');
                            }),
                        Spacer(),
                        GestureDetector(
                          onTap: () => addExcecutionBudgetaire(
                              context: context, idOperation: idOperation),
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '   Ajouter une excecution   ',
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
                        // SizedBox(
                        //   width: 8,
                        // ),
                        // GestureDetector(
                        //   onTap: () => addProduitOperationTransformation(context: context, idOperation: idOperation),
                        //   child: Container(
                        //     width: size.width * .1,
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           height: 4,
                        //         ),
                        //         Text(
                        //           'Ajouter produit',
                        //           style: TextStyle(
                        //               fontSize: size.height * .015,
                        //               color: blanc),
                        //         ),
                        //         SizedBox(
                        //           height: 4,
                        //         ),
                        //       ],
                        //     ),
                        //     decoration: BoxDecoration(
                        //         color: rouge,
                        //         borderRadius: BorderRadius.circular(4)),
                        //   ),
                        // ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Container(
                      height: size.height * .8,
                      width: size.width * .8,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text('Débit'),
                                    Spacer(),
                                    Spacer(),
                                    Text('Crédit'),
                                    Spacer(),
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) =>
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection(
                                                    "excecution-budgetaire")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } else {
                                                List<TableRow> listes = [
                                                  TableRow(children: [
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .format_list_numbered,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Nom',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              CupertinoIcons
                                                                  .money_dollar_circle,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Description',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .date_range_rounded,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Cout Total',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              Icons.settings,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Paramètres',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                  ])
                                                ];

                                                listes.addAll(snapshot
                                                    .data!.docs
                                                    .where((element) =>
                                                        element.get(
                                                                "opperationID") ==
                                                            idOperation &&
                                                        element.get(
                                                                "choix-Excecution") ==
                                                            "debit")
                                                    .map((e) {
                                                  Timestamp timestamp =
                                                      e.get('date');
                                                  DateTime date = new DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                      timestamp
                                                              .millisecondsSinceEpoch *
                                                          1000);
                                                  return TableRow(children: [
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .05,
                                                      child: Center(
                                                        child: Text(
                                                          e.get('nom'),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: vert,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .05,
                                                      child: Center(
                                                        child: Text(
                                                          "${e.get('description')}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: vert,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Text(
                                                              e
                                                                  .get(
                                                                      "cout-total")
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            GestureDetector(
                                                              onTap: () => null,
                                                              child: Icon(
                                                                Icons
                                                                    .remove_red_eye_rounded,
                                                                color: jaune,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () => null,
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: vert,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
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
                                                          border:
                                                              TableBorder.all(
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
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) =>
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection(
                                                    "excecution-budgetaire")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } else {
                                                List<TableRow> listes = [
                                                  TableRow(children: [
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .format_list_numbered,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Nom',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              CupertinoIcons
                                                                  .money_dollar_circle,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Description',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .date_range_rounded,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Cout Total',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Icon(
                                                              Icons.settings,
                                                              color: vert,
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            Text(
                                                              'Paramètres',
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                  ])
                                                ];

                                                listes.addAll(snapshot
                                                    .data!.docs
                                                    .where((element) =>
                                                        element.get(
                                                                "opperationID") ==
                                                            idOperation &&
                                                        element.get(
                                                                "choix-Excecution") !=
                                                            "debit")
                                                    .map((e) {
                                                  Timestamp timestamp =
                                                      e.get('date');
                                                  DateTime date = new DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                      timestamp
                                                              .millisecondsSinceEpoch *
                                                          1000);
                                                  return TableRow(children: [
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .05,
                                                      child: Center(
                                                        child: Text(
                                                          e.get('nom'),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: vert,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .05,
                                                      child: Center(
                                                        child: Text(
                                                          "${e.get('description')}",
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              color: vert,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Text(
                                                              e
                                                                  .get(
                                                                      "cout-total")
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: vert,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        )),
                                                    Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            GestureDetector(
                                                              onTap: () => null,
                                                              child: Icon(
                                                                Icons
                                                                    .remove_red_eye_rounded,
                                                                color: jaune,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .01,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () => null,
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: vert,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: constraints
                                                                      .maxWidth *
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
                                                          border:
                                                              TableBorder.all(
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
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Center(
                                  child: StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("budgets")
                                          .doc(idOperation)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        return !snapshot.hasData
                                            ? Text('')
                                            : Text(
                                                "Le solde restant : ${snapshot.data!.get("coutTotal")} FCFA",
                                                style: TextStyle(
                                                    fontSize: size.width * .03,
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                      }),
                                ),
                              ))
                        ],
                      )),
                ],
              ),
            ),
          ));
}
