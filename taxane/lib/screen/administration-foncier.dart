import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/menu-left-home.dart';
import 'package:taxane/widget/menu-role/administrationrole1.dart';
import 'package:taxane/widget/menu-role/administrationrole2.dart';
import 'package:taxane/widget/menu-role/foncierrole1.dart';
import 'package:taxane/widget/menu-role/foncierrole2.dart';

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

  String domaineHydrolique = "hydrolique";
  DateTime dateInnauguration = DateTime.now();

  String energie = "electricite";
  String eau = "robinet";
  String sexe = "homme";
  String niveauEtude = "befm";
  String matrimonial = "celibataire";
  String typeEvenement  = "reunion";
  bool chargement = true;
  late Uint8List fileLogo;
  String logoName = "";

  DateTime initialPeriod = DateTime.now();
  DateTime initialFinal = DateTime.now();

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
      FirebaseFirestore.instance.collection("regions").get().then((value) {
        setState(() {
          regionSlected = value.docs.first.id;
        });

        FirebaseFirestore.instance
            .collection("departements")
            .get()
            .then((value) => setState(() {
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
                                            child:
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
                                                      return !snapshot.hasData
                                                          ? Text("")
                                                          : snapshot.data!.get(
                                                                      "role") ==
                                                                  1
                                                              ? getMenuAd(
                                                                  constraints:
                                                                      constraints,
                                                                  context:
                                                                      context)
                                                              : snapshot.data!.get(
                                                                          'role') ==
                                                                      2
                                                                  ? getMenuAdRole2(
                                                                      constraints:
                                                                          constraints,
                                                                      context:
                                                                          context , idRegroupement: snapshot.data!.get(
                                                                          'regroupement'))
                                                                  : Container();
                                                    }),
                                          )
                                        ],
                                      ),

                                      // Foncier by dii
                                      Stack(
                                        children: [
                                          Container(
                                            height: constraints.maxHeight,
                                            width: constraints.maxWidth,
                                            child: StreamBuilder<DocumentSnapshot>(
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
                                                      return !snapshot.hasData
                                                          ? Text("")
                                                          : snapshot.data!.get(
                                                                      "role") ==
                                                                  1
                                                              ? foncierRole1(
                                                                  constraints:
                                                                      constraints,
                                                                  context:
                                                                      context)
                                                              : snapshot.data!.get(
                                                                          'role') ==
                                                                      2
                                                                  ? foncierRole2(
                                                                      constraints:
                                                                          constraints,
                                                                      context:
                                                                          context , idVillage: snapshot.data!.get(
                                                                      "village") )
                                                                  : Container();
                                                    }),
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
