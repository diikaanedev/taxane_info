import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/comptabilite/gestion-journal-banque/dialog_journal_anques.dart';

adminJournalBanques({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(content: StatefulBuilder(
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
                      Text(
                          'Journal de Banques du ${dateFormatter(DateTime.now())} ${DateTime.now().year}'),
                      Spacer(),
                      GestureDetector(
                        onTap: () =>
                            addOperationBanqueJournall(context: context),
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
                  height: size.height * .04,
                  width: size.width * .7,
                  decoration: BoxDecoration(border: Border.all(color: vert)),
                  child: Row(
                    children: [
                      Text('  Solde du Jour Précédant'),
                      Spacer(),
                      Container(
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                                child: Text(
                              '   155.000 FCFA  ',
                              style: TextStyle(color: vert),
                            )),
                            SizedBox(
                              height: 2,
                            ),
                            Spacer(),
                          ],
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
                              .collection("journalBanque")
                              .orderBy('dateOperation', descending: false)
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
                                            'Date',
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      )),
                                  Container(
                                      // height: constraints.maxHeight * .05,
                                      child: Center(
                                    child: Text(
                                      'numero référence',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: vert,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                            'Détails',
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
                                            'Entrées',
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
                                            'Sorties',
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
                                            'Solde',
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
                                Timestamp timestamp = item.get('dateOperation');
                                DateTime date =
                                    new DateTime.fromMicrosecondsSinceEpoch(
                                        timestamp.millisecondsSinceEpoch *
                                            1000);
                                if (true) {
                                  listes.add(TableRow(children: [
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              "${date.day}/${date.month}/${date.year}",
                                              style: TextStyle(
                                                  color: vert,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Spacer(),
                                          ],
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Center(
                                          child: Text(
                                            item.get("numeroReference"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        )),
                                    Container(
                                        // height: constraints.maxHeight * .05,
                                        child: Center(
                                      child: Text(
                                        item.get("detailTransaction"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: vert,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Center(
                                          child: Text(
                                            item.get("soldeEntre") == "entrees"
                                                ? item.get("montant") + " FCFA "
                                                : "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Center(
                                          child: Text(
                                            item.get("soldeEntre") == "sorties"
                                                ? item.get("montant") + " FCFA "
                                                : "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        )),
                                    Container(
                                        height: constraints.maxHeight * .05,
                                        child: Center(
                                          child: Text(
                                            "145.000 FCFA",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: vert,
                                                fontWeight: FontWeight.w300),
                                          ),
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
