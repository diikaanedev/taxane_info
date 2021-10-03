import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/champs/admin-champs.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/commercilalition/admin-commercialiation.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/materiel/admin-materiel.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/production/admin-production.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/transformation/livraison/admin-livraison.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/transformation/operation-transformation/admin-operation-transformation.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/transformation/point-de-vente/admin-pt-de-vente.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/transformation/recouvrement/admin-recouvrement.dart';
import 'package:taxane/widget/menu-left-home.dart';
late _AgricultureHortocultureState agricultureHortocultureState ;
class AgricultureHortoculture extends StatefulWidget {
  const AgricultureHortoculture({Key? key}) : super(key: key);

  @override
  _AgricultureHortocultureState createState() {
    agricultureHortocultureState = _AgricultureHortocultureState();
    return agricultureHortocultureState;
  }
}

class _AgricultureHortocultureState extends State<AgricultureHortoculture> {
  late Size size;
  late String villageSelected;
  late String produit ;
  late String idproduit ;
  DateTime dateLivraison = DateTime.now(); 
  DateTime datePaiement = DateTime.now(); 
  bool chargement = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
   
        FirebaseFirestore.instance.collection("villages").get().then((value) => setState((){
          villageSelected = value.docs.first.id;
        }));

         FirebaseFirestore.instance.collection("cultures").get().then((value) => setState((){
          idproduit = value.docs.first.id;
          produit = value.docs.first.get('nom');
        }));

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
                                                'Agriculture',
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
                                       
                                        /*  Tab(
                                            icon: Container(
                                          width: constraints.maxWidth * .3,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                'Horticulture',
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
                                        )), */
 Tab(
                                            icon: Container(
                                          width: constraints.maxWidth * .3,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                'Transformation Produit Agricole ',
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
                                                            adminAgriculture(context: context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Champs',
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
                                                        onTap: () =>adminMateriel(context: context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Matériels',
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
                                                        onTap: () =>adminProduction(context: context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Productions',
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
                                                        onTap: () =>adminCommercialisation(context: context),
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
                                                              'Gestion des Commercialisations',
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
                                      // horticulture
                                     /*   Stack(
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
                                                            null,
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Champs',
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
                                                        onTap: () =>null,
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Matériels',
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
                                                        onTap: () =>null,
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Gestion des Productions',
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
                                                        onTap: () =>null,
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
                                                              'Gestion des Commercialisations',
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
                                      ), */
                                      // Transformation agricuture
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
                                                            adminOperationTransformation(context: context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Cout opération de transformation ',
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
                                                        onTap: () =>adminPointDeVente(context: context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Création point de vente ',
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
                                                        onTap: () =>adminLivraison(context: context),
                                                        child: Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .3,
                                                          child: Center(
                                                            child: Text(
                                                              'Livraison produit ',
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
                                                        onTap: () =>adminRecouvrement(context: context),
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
                                                              'Recouvrement ',
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
                  choice: 4,
                )
        ],
      ),
    );
  }
}
