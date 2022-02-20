import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/comptabilite/gestion-des-budget/mise-en-place/admin_mise_en_place_budgetaire.dart';
import 'package:taxane/widget/comptabilite/gestion-journal-banque/admin_journal_banques.dart';
import 'package:taxane/widget/comptabilite/gestion-journal-caisse/admin_journal_caisse.dart';
import 'package:taxane/widget/menu-left-home.dart';

late _ComptabiliteState comptabiliteState;

class Comptabilite extends StatefulWidget {
  const Comptabilite({Key? key}) : super(key: key);

  @override
  _ComptabiliteState createState() {
    comptabiliteState = _ComptabiliteState();
    return comptabiliteState;
  }
}

class _ComptabiliteState extends State<Comptabilite> {
  late Size size;
  String typeEntresSortie = "entrees";
  DateTime date = DateTime.now();

  DateTime initialPeriod = DateTime.now();
  DateTime finalPeriod = DateTime.now();
  String choixExecution = "debit";
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: .0,
      ),
      backgroundColor: vert,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshotU) {
                return !snapshotU.hasData
                    ? Text('')
                    : Positioned(
                        top: size.height * .015,
                        left: size.width * .2,
                        child: Container(
                          width: size.width * .79,
                          height: size.height * .97,
                          child: LayoutBuilder(
                            builder: (context, constraints) => Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DefaultTabController(
                                    length: 2,
                                    child: Scaffold(
                                      appBar: AppBar(
                                        elevation: .0,
                                        leading: Container(),
                                        backgroundColor: blanc,
                                        toolbarHeight:
                                            constraints.maxHeight * .07,
                                        bottom: TabBar(
                                          indicatorColor: vert,
                                          tabs: [
                                            Tab(
                                                icon: Container(
                                              width: constraints.maxWidth * .3,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    'Gestion des Journaux',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            .02,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .03,
                                                  ),
                                                  Icon(
                                                    CupertinoIcons
                                                        .person_3_fill,
                                                    color: vert,
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            )),
                                            Tab(
                                                icon: Container(
                                              width: constraints.maxWidth * .3,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    'Gestion des budgets ',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            .02,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .03,
                                                  ),
                                                  Icon(
                                                    CupertinoIcons
                                                        .person_3_fill,
                                                    color: vert,
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                      body: TabBarView(
                                        children: [
                                          // Gestions de Journaux
                                          Stack(
                                            children: [
                                              Container(
                                                height: constraints.maxHeight,
                                                width: constraints.maxWidth,
                                                child: Column(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .25,
                                                      child: Row(
                                                        children: [
                                                          // Spacer(),
                                                          Spacer(),
                                                          GestureDetector(
                                                            onTap: () => adminJournalCaisse(
                                                                context:
                                                                    context,
                                                                idRegroupement:
                                                                    snapshotU
                                                                        .data!
                                                                        .get(
                                                                            "regroupement")),
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Gestion des Journal de Caisse',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          constraints.maxHeight *
                                                                              .02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color:
                                                                          blanc),
                                                                ),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: jaune,
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          GestureDetector(
                                                            onTap: () => adminJournalBanques(
                                                                context:
                                                                    context,
                                                                idRegroupement:
                                                                    snapshotU
                                                                        .data!
                                                                        .get(
                                                                            "regroupement")),
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Gestion journal de Banque ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          constraints.maxHeight *
                                                                              .02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color:
                                                                          blanc),
                                                                ),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: rouge,
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          //Gestion des Budgets
                                          Stack(
                                            children: [
                                              Container(
                                                height: constraints.maxHeight,
                                                width: constraints.maxWidth,
                                                child: Column(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .25,
                                                      child: Row(
                                                        children: [
                                                          // Spacer(),

                                                          Spacer(),
                                                          GestureDetector(
                                                            onTap: () =>
                                                                adminMiseEnPlaceBudgeratire(
                                                                    context:
                                                                        context),
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Mise en place Budget ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          constraints.maxHeight *
                                                                              .02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color:
                                                                          blanc),
                                                                ),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: rouge,
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),

                                                          GestureDetector(
                                                            onTap: () => null,
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: jaune,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Gestion des prets et cotisations',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          constraints.maxHeight *
                                                                              .02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color:
                                                                          blanc),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              decoration: BoxDecoration(
                                  color: blanc,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: blanc,
                              borderRadius: BorderRadius.circular(8)),
                        ));
              }),
          MenuLeftHome(
            choice: 3,
          )
        ],
      ),
    );
  }
}
