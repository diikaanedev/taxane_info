import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/25-novembre/mortalite-infatile/admin_mortalite_infatile.dart';
import 'package:taxane/widget/25-novembre/mortalite-maternel/admin_mortalite_maternel.dart';
import 'package:taxane/widget/25-novembre/violence-base-genre/admin_violence_base_genre.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/champs/admin-champs.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/commercilalition/admin-commercialiation.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/materiel/admin-materiel.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/production/admin-production.dart';
import 'package:taxane/widget/menu-left-home.dart';

late _VingtCinqNovembreState vingtCinqNovembreState;

class VingtCinqNovembre extends StatefulWidget {
  const VingtCinqNovembre({Key? key}) : super(key: key);

  @override
  _VingtCinqNovembreState createState() {
    vingtCinqNovembreState = _VingtCinqNovembreState();
    return vingtCinqNovembreState;
  }
}

class _VingtCinqNovembreState extends State<VingtCinqNovembre> {
  late Size size;
  late String villageSelected;

  String liens = "domestique";
  String degats = "blessure";
  String decisionJudiciaire = "ammende";

  DateTime dateDesFaits = DateTime.now();

  bool chargement = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      villageSelected = value.get("village");
    });
  }

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
          Positioned(
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
                          length: 1,
                          child: Scaffold(
                            appBar: AppBar(
                              elevation: .0,
                              leading: Container(),
                              backgroundColor: blanc,
                              toolbarHeight: constraints.maxHeight * .07,
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
                                          '25 NOVEMBRE',
                                          style: TextStyle(
                                              color: vert,
                                              fontSize:
                                                  constraints.maxHeight * .02,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth * .01,
                                        ),
                                        Icon(
                                          Icons.baby_changing_station_rounded,
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
                                Stack(
                                  children: [
                                    Container(
                                      height: constraints.maxHeight,
                                      width: constraints.maxWidth,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Container(
                                            height: constraints.maxHeight * .25,
                                            child: Row(
                                              children: [
                                                // Spacer(),
                                                Spacer(),
                                                StreamBuilder<DocumentSnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot.data!
                                                                .get("role") ==
                                                            2) {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                adminViolenceBaseGenreRole2(
                                                                    context:
                                                                        context,
                                                                    idVillage:
                                                                        snapshot
                                                                            .data!
                                                                            .get("village")),
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Violence basée sur le genre',
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
                                                          );
                                                        } else {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                adminViolenceBaseGenre(
                                                                    context:
                                                                        context),
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Violence basée sur le genre',
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
                                                          );
                                                        }
                                                      } else {
                                                        return GestureDetector(
                                                          onTap: () => null,
                                                          child: Container(
                                                            width: constraints
                                                                    .maxWidth *
                                                                .3,
                                                            child: Center(
                                                              child: Text(
                                                                'Violence basée sur le genre',
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
                                                        );
                                                      }
                                                    }),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: constraints.maxHeight * .25,
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                StreamBuilder<DocumentSnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot.data!
                                                                .get('role') ==
                                                            1) {
                                                          return GestureDetector(
                                                            onTap: () => adminMortaliteMaternel(context: context),
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Mortalite Maternel ',
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
                                                                color: vert,
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                adminMortaliteMaternelRole2(
                                                                    context:
                                                                        context,
                                                                    idVillage:
                                                                        snapshot
                                                                            .data!
                                                                            .get('village')),
                                                            child: Container(
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .3,
                                                              child: Center(
                                                                child: Text(
                                                                  'Mortalite Maternel ',
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
                                                                color: vert,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        return GestureDetector(
                                                          onTap: () => null,
                                                          child: Container(
                                                            width: constraints
                                                                    .maxWidth *
                                                                .3,
                                                            child: Center(
                                                              child: Text(
                                                                'Mortalite Maternel ',
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
                                                              color: vert,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                Spacer(),
                                                StreamBuilder<DocumentSnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot.data!
                                                                .get("role") ==
                                                            1) {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                adminMortaliteInfatile(
                                                                    context:
                                                                        context),
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
                                                                color: rouge,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Mortalite Infantile',
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
                                                          );
                                                        } else {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                adminMortaliteInfatileRole2(
                                                                    context:
                                                                        context,
                                                                    idVillage:
                                                                        snapshot
                                                                            .data!
                                                                            .get('village')),
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
                                                                color: rouge,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Mortalite Infantile',
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
                                                          );
                                                        }
                                                      } else {
                                                        return GestureDetector(
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
                                                              color: rouge,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Mortalite Infantile',
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
                                                        );
                                                      }
                                                    }),
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
                        color: blanc, borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                decoration: BoxDecoration(
                    color: blanc, borderRadius: BorderRadius.circular(8)),
              )),
          MenuLeftHome(
            choice: 6,
          )
        ],
      ),
    );
  }
}
