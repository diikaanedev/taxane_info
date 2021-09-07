import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/admin-commune.dart';
import 'package:taxane/widget/admin-concession.dart';
import 'package:taxane/widget/admin-departement.dart';
import 'package:taxane/widget/admin-domaine.dart';
import 'package:taxane/widget/admin-menage.dart';
import 'package:taxane/widget/admin-regions.dart';
import 'package:taxane/widget/admin-regroupement.dart';
import 'package:taxane/widget/admin-village.dart';
import 'package:taxane/widget/menu-left-home.dart';

late _AdministrationFoncierState administrationFoncierState;

class AdministrationFoncier extends StatefulWidget {
  const AdministrationFoncier({Key? key}) : super(key: key);

  @override
  _AdministrationFoncierState createState() {
    administrationFoncierState = _AdministrationFoncierState();
    return administrationFoncierState;
  }
}

class _AdministrationFoncierState extends State<AdministrationFoncier> {
  late Size size;
  late String paysSelected;
  late String regionSlected;
  late String departementSelected;
  late String communeSelected;
  late String villageSelected;
  late String concessionSelected;

  String energie = "electricite";
  String eau = "robinet";
  String sexe = "homme";
  String niveauEtude = "befm";
  String matrimonial = "celibataire";
  bool chargement = false;
  late Uint8List fileLogo;
  String logoName = "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await FirebaseFirestore.instance.collection('pays').get().then((value) {
      setState(() {
        paysSelected = value.docs.first.id;
        chargement = true;
      });
      FirebaseFirestore.instance
          .collection("regions")
          .get()
          .then((value) {
        setState(() {
          regionSlected = value.docs.first.id;
        });

        FirebaseFirestore.instance.collection("departements").get().then((value) => setState((){
          departementSelected = value.docs.first.id;
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        elevation: .0,
      ),
      backgroundColor: vert,
      body: !chargement
          ? Container(
              height: size.height,
              width: size.width,
              color: blanc,
              child: Center(
                child: CircularProgressIndicator(
                  color: vert,
                ),
              ),
            )
          : Stack(
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
                                length: 2,
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
                                                'Administration',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            .02,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .03,
                                              ),
                                              Icon(
                                                CupertinoIcons.person_3_fill,
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
                                                'Foncier',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            .02,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .03,
                                              ),
                                              Icon(
                                                Icons.map,
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
                                                  height:
                                                      constraints.maxHeight *
                                                          .25,
                                                  child: Row(
                                                    children: [
                                                      // Spacer(),
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            adminRegion(
                                                                context:
                                                                    context , idPays: paysSelected),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Régions',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
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
                                                        onTap: () =>
                                                            adminDepartement(
                                                                context:
                                                                    context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Départements',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
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
                                                Container(
                                                  height:
                                                      constraints.maxHeight *
                                                          .25,
                                                  child: Row(
                                                    children: [
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            adminCommune(
                                                                context:
                                                                    context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des communes',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
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
                                                      ),
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            adminVillage(
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
                                                            color: jaune,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Villages / Quartiers',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
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

                                      // Foncier by dii
                                      Stack(
                                        children: [
                                          Container(
                                            height: constraints.maxHeight,
                                            width: constraints.maxWidth,
                                            child: Column(
                                              children: [
                                                Spacer(),
                                                // Container(
                                                //   height:
                                                //       constraints.maxHeight *
                                                //           .25,
                                                //   color: jaune,
                                                //   child: Row(
                                                //     children: [
                                                //       // Spacer(),
                                                //       Spacer(),

                                                //       Spacer(),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Spacer(),
                                                Container(
                                                  height:
                                                      constraints.maxHeight *
                                                          .25,
                                                  // color: vert,
                                                  child: Row(
                                                    children: [
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            adminRegouprement(
                                                                context:
                                                                    context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Regroupemments / Associations',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: vert,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            AdminConcession(
                                                                context:
                                                                    context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Concessions / Villa',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
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
                                                Container(
                                                  height:
                                                      constraints.maxHeight *
                                                          .25,
                                                  child: Row(
                                                    children: [
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            adminMenage(
                                                                context:
                                                                    context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Ménages',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: jaune,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () => adminDomaine(context: context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Domaines ou Lots',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxHeight *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: blanc),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: rouge,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
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
                          color: blanc, borderRadius: BorderRadius.circular(8)),
                    )),
                MenuLeftHome(
                  choice: 2,
                )
              ],
            ),
    );
  }
}
