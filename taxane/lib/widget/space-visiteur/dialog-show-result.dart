import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/utils/requette.dart';
import 'package:taxane/widget/table-row-header.dart';

showResultRegionProduit({
  required BuildContext context,
  required String idRegion,
  required String idCulture,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("regions")
                      .doc(idRegion)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("cultures")
                                            .doc(idCulture)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur la region de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Département",
                                                    "Produit",
                                                    "Quantité",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("departements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element
                                                              .get("regions") ==
                                                          idRegion)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberProduitsRegion(
                                                                      idCulture:
                                                                          idCulture,
                                                                      idDept:
                                                                          e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("cultures")
                                                                              .doc(idCulture)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idCulture,
                                                                                    onTap: () => showResultDepartementProduit(context: context, idDept: e.id, idCulture: idCulture),
                                                                                    id: idRegion,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .23,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultDepartementProduit({
  required BuildContext context,
  required String idDept,
  required String idCulture,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("departements")
                      .doc(idDept)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("cultures")
                                            .doc(idCulture)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur le département de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Communes",
                                                    "Produit",
                                                    "Quantité",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        // color: rouge,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("communes")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "departements") ==
                                                          idDept)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberProduitsDepartement(
                                                                      idCommune:
                                                                          e.id,
                                                                      idCulture:
                                                                          idCulture),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("cultures")
                                                                              .doc(idCulture)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idCulture,
                                                                                    onTap: () => showResultCommuneProduit(context: context, idCommune: e.id, idCulture: idCulture),
                                                                                    id: idDept,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .23,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultCommuneProduit({
  required BuildContext context,
  required String idCommune,
  required String idCulture,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("communes")
                      .doc(idCommune)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("cultures")
                                            .doc(idCulture)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur la commune de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Villages",
                                                    "Produit",
                                                    "Quantité",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        // color: rouge,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("villages")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "communes") ==
                                                          idCommune)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberProduitsCommunes(
                                                                      idVillage:
                                                                          e.id,
                                                                      idCulture:
                                                                          idCulture),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("cultures")
                                                                              .doc(idCulture)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idCulture,
                                                                                    onTap: () => showResultVillageProduit(context: context, idVillage: e.id, idCulture: idCulture),
                                                                                    id: idCommune,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .23,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultVillageProduit({
  required BuildContext context,
  required String idVillage,
  required String idCulture,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("villages")
                      .doc(idVillage)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("cultures")
                                            .doc(idCulture)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur le village de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Regroupements",
                                                    "Produit",
                                                    "Quantité",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        // color: rouge,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("regroupements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "villages") ==
                                                          idVillage)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberProduitsVillage(
                                                                      idRegroupement:
                                                                          e.id,
                                                                      idVillage:
                                                                          idVillage,
                                                                      idCulture:
                                                                          idCulture),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("cultures")
                                                                              .doc(idCulture)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idCulture,
                                                                                    onTap: () => null,
                                                                                    id: idVillage,
                                                                                    titles: [
                                                                                      e.get('name'),
                                                                                      snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .23,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultCommunesProduit({
  required BuildContext context,
  required String idCommune,
  required String idCulture,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("communes")
                      .doc(idCommune)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("cultures")
                                            .doc(idCulture)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur  ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Communes",
                                                    "Produit",
                                                    "Quantité",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        // color: rouge,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("communes")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "departements") ==
                                                          idCommune)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: Future
                                                                      .value(
                                                                          90),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("cultures")
                                                                              .doc(idCulture)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idCulture,
                                                                                    onTap: () => null,
                                                                                    id: idCommune,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .23,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultRegionMateriel({
  required BuildContext context,
  required String idRegion,
  required String idMateriel,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("regions")
                      .doc(idRegion)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Nombre de ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("materiels")
                                            .doc(idMateriel)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur la région de  ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Département",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .8,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("departements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element
                                                              .get("regions") ==
                                                          idRegion)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberMaterielRegion(
                                                                      idMateriel:
                                                                          idMateriel,
                                                                      idDept:
                                                                          e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("materiels")
                                                                              .doc(idMateriel)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idMateriel,
                                                                                    onTap: () => showResultDepartementMateriel(context: context, idDepartement: e.id, idMateriel: idMateriel),
                                                                                    id: idRegion,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultDepartementMateriel({
  required BuildContext context,
  required String idDepartement,
  required String idMateriel,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("departements")
                      .doc(idDepartement)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Nombre de ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("materiels")
                                            .doc(idMateriel)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur le département de  ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Communes",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .93,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("communes")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "departements") ==
                                                          idDepartement)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberMaterielDepartement(
                                                                      idCommune:
                                                                          e.id,
                                                                      idMateriel:
                                                                          idMateriel),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("materiels")
                                                                              .doc(idMateriel)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idMateriel,
                                                                                    onTap: () => showResultCommunesMateriel(context: context, idCommune: e.id, idMateriel: idMateriel),
                                                                                    id: idDepartement,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultCommunesMateriel({
  required BuildContext context,
  required String idCommune,
  required String idMateriel,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("communes")
                      .doc(idCommune)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Nombre de ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("materiels")
                                            .doc(idMateriel)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur la commune de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Villages",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .93,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("villages")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "communes") ==
                                                          idCommune)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberMaterielCommune(
                                                                      idVillage:
                                                                          e.id,
                                                                      idMateriel:
                                                                          idMateriel),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("materiels")
                                                                              .doc(idMateriel)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idMateriel,
                                                                                    onTap: () => showResultVillageMateriel(context: context, idVillage: e.id, idMateriel: idMateriel),
                                                                                    id: idCommune,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultVillageMateriel({
  required BuildContext context,
  required String idVillage,
  required String idMateriel,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("villages")
                      .doc(idVillage)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Nombre de ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("materiels")
                                            .doc(idMateriel)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur le village de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Regroupements",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .93,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("regroupements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "villages") ==
                                                          idVillage)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberMaterielVillage(
                                                                      idVillage:
                                                                          idVillage,
                                                                      idMateriel:
                                                                          idMateriel,
                                                                      idRegroupement:
                                                                          e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("materiels")
                                                                              .doc(idMateriel)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idMateriel,
                                                                                    onTap: () => null,
                                                                                    id: idVillage,
                                                                                    titles: [
                                                                                      e.get("name"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultRegionEspece({
  required BuildContext context,
  required String idRegion,
  required String idEspece,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("regions")
                      .doc(idRegion)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("animaux")
                                            .doc(idEspece)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur  la région de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Département",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .8,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("departements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element
                                                              .get("regions") ==
                                                          idRegion)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberEspecspeRegion(
                                                                      idEspece:
                                                                          idEspece,
                                                                      idDept:
                                                                          e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("animaux")
                                                                              .doc(idEspece)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idEspece,
                                                                                    onTap: () => showResultDepartementEspece(context: context, idDept: e.id, idEspece: idEspece),
                                                                                    id: idRegion,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultDepartementEspece({
  required BuildContext context,
  required String idDept,
  required String idEspece,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("departements")
                      .doc(idDept)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("animaux")
                                            .doc(idEspece)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur  le département de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Communes",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("communes")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "departements") ==
                                                          idDept)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberEspecspeDepartement(
                                                                      idCommune:
                                                                          e.id,
                                                                      idEspece:
                                                                          idEspece),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("animaux")
                                                                              .doc(idEspece)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idEspece,
                                                                                    onTap: () => showResultCommuneEspece(context: context, idCommune: e.id, idEspece: idEspece),
                                                                                    id: idDept,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultCommuneEspece({
  required BuildContext context,
  required String idCommune,
  required String idEspece,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("communes")
                      .doc(idCommune)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("animaux")
                                            .doc(idEspece)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur  la commune de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Villages",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("villages")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "communes") ==
                                                          idCommune)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberEspecspeCommune(
                                                                      idVillage:
                                                                          e.id,
                                                                      idEspece:
                                                                          idEspece),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("animaux")
                                                                              .doc(idEspece)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idEspece,
                                                                                    onTap: () => showResultVillageEspece(context: context, idVillage: e.id, idEspece: idEspece),
                                                                                    id: idCommune,
                                                                                    titles: [
                                                                                      e.get("nom"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultVillageEspece({
  required BuildContext context,
  required String idVillage,
  required String idEspece,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("villages")
                      .doc(idVillage)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique du ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("animaux")
                                            .doc(idEspece)
                                            .snapshots(),
                                        builder: (context, snapshotCulture) {
                                          return !snapshotCulture.hasData
                                              ? Text('')
                                              : Text(
                                                  " ${snapshotCulture.data!.get("nom")}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                        }),
                                    Text(
                                      " sur  le village de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Regroupements",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("regroupements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "villages") ==
                                                          idVillage)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberEspecspeVillage(
                                                                      idVillage:
                                                                          idVillage,
                                                                      idEspece:
                                                                          idEspece,
                                                                      idRegroupement:
                                                                          e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder<
                                                                              DocumentSnapshot>(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection("animaux")
                                                                              .doc(idEspece)
                                                                              .snapshots(),
                                                                          builder: (context, snapshot) {
                                                                            return !snapshot.hasData
                                                                                ? Text('')
                                                                                : getRowTable(
                                                                                    context: context,
                                                                                    idCulture: idEspece,
                                                                                    onTap: () => null,
                                                                                    id: idVillage,
                                                                                    titles: [
                                                                                      e.get("name"),
                                                                                      // snapshot.data!.get('nom'),
                                                                                      valueFuture.data.toString(),
                                                                                    ],
                                                                                    heigth: constraints.maxHeight * .07,
                                                                                    width: constraints.maxWidth * .35,
                                                                                    choixColor: 12,
                                                                                    constraints: constraints);
                                                                          });
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultRegionMortalite({
  required BuildContext context,
  required String idRegion,
  required String idType,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("regions")
                      .doc(idRegion)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique de la Mortalité ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      idType,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " sur ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Département",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .8,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("departements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element
                                                              .get("regions") ==
                                                          idRegion)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberMortaliteRegions(
                                                                      idDept:
                                                                          e.id,
                                                                      type: idType ==
                                                                              "Infantile"
                                                                          ? "mortalite-infantile"
                                                                          : "mortalite-maternel"),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return getRowTable(
                                                                          context:
                                                                              context,
                                                                          idCulture:
                                                                              idType,
                                                                          onTap: () => showResultDepartementMortalite(
                                                                              context:
                                                                                  context,
                                                                              idDept: e
                                                                                  .id,
                                                                              idType:
                                                                                  idType),
                                                                          id:
                                                                              idRegion,
                                                                          titles: [
                                                                            e.get("nom"),
                                                                            valueFuture.data.toString(),
                                                                          ],
                                                                          heigth: constraints.maxHeight *
                                                                              .07,
                                                                          width: constraints.maxWidth *
                                                                              .345,
                                                                          choixColor:
                                                                              12,
                                                                          constraints:
                                                                              constraints);
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultDepartementMortalite({
  required BuildContext context,
  required String idDept,
  required String idType,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("departements")
                      .doc(idDept)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique de la Mortalité ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      idType,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " sur le de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Communes",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("communes")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "departements") ==
                                                          idDept)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberMortaliteDepartements(
                                                                      idCommune:
                                                                          e.id,
                                                                      type: idType ==
                                                                              "Infantile"
                                                                          ? "mortalite-infantile"
                                                                          : "mortalite-maternel"),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return getRowTable(
                                                                          context:
                                                                              context,
                                                                          idCulture:
                                                                              idType,
                                                                          onTap: () =>
                                                                              showResultCommunesMortalite(context: context, idCommune: e.id, idType: idType),
                                                                          id:
                                                                              idDept,
                                                                          titles: [
                                                                            e.get("nom"),
                                                                            valueFuture.data.toString(),
                                                                          ],
                                                                          heigth: constraints.maxHeight *
                                                                              .07,
                                                                          width: constraints.maxWidth *
                                                                              .345,
                                                                          choixColor:
                                                                              12,
                                                                          constraints:
                                                                              constraints);
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultCommunesMortalite({
  required BuildContext context,
  required String idCommune,
  required String idType,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("communes")
                      .doc(idCommune)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique de la Mortalité ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      idType,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " sur la commune de ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Villages",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("villages")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element.get(
                                                              "communes") ==
                                                          idCommune)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberMortaliteCommunes(
                                                                      idVilage:
                                                                          e.id,
                                                                      type: idType ==
                                                                              "Infantile"
                                                                          ? "mortalite-infantile"
                                                                          : "mortalite-maternel"),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return getRowTable(
                                                                          context:
                                                                              context,
                                                                          idCulture:
                                                                              idType,
                                                                          onTap: () =>
                                                                              null,
                                                                          id:
                                                                              idCommune,
                                                                          titles: [
                                                                            e.get("nom"),
                                                                            valueFuture.data.toString(),
                                                                          ],
                                                                          heigth: constraints.maxHeight *
                                                                              .07,
                                                                          width: constraints.maxWidth *
                                                                              .345,
                                                                          choixColor:
                                                                              12,
                                                                          constraints:
                                                                              constraints);
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultRegionViolence({
  required BuildContext context,
  required String idRegion,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("regions")
                      .doc(idRegion)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique de la violence faites aux femmes",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " sur ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Département",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("departements")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element
                                                              .get("regions") ==
                                                          idRegion)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberViolenceRegion(
                                                                      idDept:
                                                                          e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return getRowTable(
                                                                          context:
                                                                              context,
                                                                          idCulture:
                                                                              "",
                                                                          onTap: () =>
                                                                              showResultDepartementsViolence(context: context, idDept: e.id),
                                                                          id:
                                                                              idRegion,
                                                                          titles: [
                                                                            e.get("nom"),
                                                                            valueFuture.data.toString(),
                                                                          ],
                                                                          heigth: constraints.maxHeight *
                                                                              .07,
                                                                          width: constraints.maxWidth *
                                                                              .345,
                                                                          choixColor:
                                                                              12,
                                                                          constraints:
                                                                              constraints);
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultDepartementsViolence({
  required BuildContext context,
  required String idDept,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("departements")
                      .doc(idDept)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique de la violence faites aux femmes",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " sur le departement ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Communes",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("communes")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element
                                                              .get("departements") ==
                                                          idDept)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberViolenceDepartement(idCommune: e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return getRowTable(
                                                                          context:
                                                                              context,
                                                                          idCulture:
                                                                              "",
                                                                          onTap: () =>
                                                                              showResultCommunesViolence(context: context, idCommune: e.id),
                                                                          id:
                                                                              idDept,
                                                                          titles: [
                                                                            e.get("nom"),
                                                                            valueFuture.data.toString(),
                                                                          ],
                                                                          heigth: constraints.maxHeight *
                                                                              .07,
                                                                          width: constraints.maxWidth *
                                                                              .345,
                                                                          choixColor:
                                                                              12,
                                                                          constraints:
                                                                              constraints);
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}

showResultCommunesViolence({
  required BuildContext context,
  required String idCommune,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blanc,
          contentPadding: EdgeInsets.all(0),
          content: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("communes")
                      .doc(idCommune)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Text(
                                      "Statistique de la violence faites aux femmes",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " sur la commune ${snapshot.data!.get("nom")}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                width: MediaQuery.of(context).size.width * .8,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * .07,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom:
                                                    BorderSide(color: gris))),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * .8,
                                              child: getHeader(
                                                  context: context,
                                                  titles: [
                                                    "Villages",
                                                    "Nombres",
                                                    "Voir"
                                                  ],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  constraints: constraints),
                                            ),
                                            Spacer(),
                                            Icon(Icons.download),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .9,
                                        width: constraints.maxWidth,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("villages")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('');
                                              } else {
                                                return ListView(
                                                  children: snapshot.data!.docs
                                                      .where((element) =>
                                                          element
                                                              .get("communes") ==
                                                          idCommune)
                                                      .toList()
                                                      .map(
                                                        (e) => Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          width: constraints
                                                              .maxWidth,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: constraints
                                                                          .maxWidth *
                                                                      .03),
                                                              FutureBuilder(
                                                                  future: getNumberViolenceCommune(idVillage: e.id),
                                                                  builder: (context,
                                                                      valueFuture) {
                                                                    if (!valueFuture
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return getRowTable(
                                                                          context:
                                                                              context,
                                                                          idCulture:
                                                                              "",
                                                                          onTap: () =>
                                                                              null,
                                                                          id:
                                                                              idCommune,
                                                                          titles: [
                                                                            e.get("nom"),
                                                                            valueFuture.data.toString(),
                                                                          ],
                                                                          heigth: constraints.maxHeight *
                                                                              .07,
                                                                          width: constraints.maxWidth *
                                                                              .345,
                                                                          choixColor:
                                                                              12,
                                                                          constraints:
                                                                              constraints);
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  );
                                }),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                              )
                            ],
                          );
                  })));
    },
  );
}
