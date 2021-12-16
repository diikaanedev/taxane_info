import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/card-menu-home.dart';
import 'package:taxane/widget/dialog-regroupenment.dart';
import 'package:taxane/widget/field-data.dart';
import 'package:taxane/widget/menu-left-home.dart';

class HomeLaptop extends StatefulWidget {
  const HomeLaptop({Key? key}) : super(key: key);

  @override
  _HomeLaptopState createState() => _HomeLaptopState();
}

class _HomeLaptopState extends State<HomeLaptop> {
  late Size size;
  String valueData = "Agriculture";
  late String regroupement;

  String localite = "Sénégal";
  int y = int.parse(DateFormat('y').format(DateTime.now()));
  int yL = int.parse(DateFormat('y').format(DateTime.now())) - 1;
  int yP = int.parse(DateFormat('y').format(DateTime.now())) + 1;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
          print(user.get("nom"));
      setState(() {
        regroupement = user.get('regroupement');
      });
      if (user.get('role') == 2) {
        FirebaseFirestore.instance
            .collection("villages")
            .doc(user.get('village'))
            .get()
            .then((village) => setState(() {
                  localite = village.get('nom');
                }));
      }
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
                  builder: (context, constraints) => Stack(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                            color: blanc,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(
                          // right: constraints.maxWidth * .01,
                          top: constraints.maxHeight * .01,
                          child: Container(
                            height: constraints.maxHeight * .05,
                            width: constraints.maxWidth,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                ),
                                Text(
                                  'Localité ',
                                  style: TextStyle(
                                      color: gris3,
                                      fontSize: constraints.maxHeight * .03),
                                ),
                                Text(
                                  '$localite',
                                  style: TextStyle(
                                      color: gris3,
                                      decoration: TextDecoration.underline,
                                      fontSize: constraints.maxHeight * .03),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                ),
                                Container(
                                  width: constraints.maxWidth * .001,
                                  color: vert,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                ),
                                DropdownButton<String>(
                                  style: TextStyle(
                                      fontSize: constraints.maxHeight * .02,
                                      fontWeight: FontWeight.bold,
                                      color: noir),
                                  underline: Container(),
                                  icon: Icon(
                                    CupertinoIcons.chevron_down_circle_fill,
                                    color: vert,
                                  ),
                                  items: <String>[
                                    '$yL',
                                    '$y',
                                    '$yP',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  value: y.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      y = int.parse(value!);
                                      yL = y - 1;
                                      yP = y + 1;
                                    });
                                  },
                                ),
                                Spacer(),
                                Container(
                                  /* width: constraints.maxWidth * .1, */
                                  child: Center(
                                    child: Text(
                                      '   Ajouter utilisateur   ',
                                      style: TextStyle(color: blanc),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: vert,
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                )
                              ],
                            ),
                          )),
                      Positioned(
                          top: constraints.maxHeight * .07,
                          child: Container(
                            height: constraints.maxHeight * .65,
                            width: constraints.maxWidth,
                            child: Column(
                              children: [
                                Spacer(),
                                Container(
                                  height: constraints.maxHeight * .12,
                                  // color: gris3,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) => Row(
                                      children: [
                                        SizedBox(
                                          width: constraints.maxWidth * .03,
                                        ),
                                        Container(
                                          width: constraints.maxWidth * .28,
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("regroupements")
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                return snapshot.hasData
                                                    ? CardMenuHome(
                                                        title:
                                                            'Nombre d\'associations',
                                                        icon:
                                                            CupertinoIcons.snow,
                                                        nombre: snapshot
                                                            .data!.docs.length
                                                            .toString(),
                                                      )
                                                    : Container(
                                                        height: 25,
                                                        width: 25,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator()));
                                              }),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: constraints.maxWidth * .28,
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("regroupements")
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                return snapshot.hasData
                                                    ? CardMenuHome(
                                                        title: 'Nombre Message',
                                                        icon:
                                                            CupertinoIcons.mail,
                                                        nombre: "10",
                                                      )
                                                    : Container(
                                                        height: 25,
                                                        width: 25,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator()));
                                              }),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: constraints.maxWidth * .28,
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("membres")
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return CardMenuHome(
                                                    title: 'Nombre Utilisateur',
                                                    icon: CupertinoIcons
                                                        .person_circle,
                                                    nombre: snapshot
                                                        .data!.docs.length
                                                        .toString(),
                                                  );
                                                } else {
                                                  return Container(
                                                      height: 25,
                                                      width: 25,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator()));
                                                }
                                              }),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: constraints.maxHeight * .5,
                                  width: constraints.maxWidth * .95,
                                  child: LayoutBuilder(
                                    builder:
                                        (context, constraints) =>
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .snapshots(),
                                                builder: (context, snapUser) {
                                                  if (!snapUser.hasData) {
                                                    return Text('');
                                                  } else {
                                                    if (snapUser.data!
                                                            .get("role") ==
                                                        1) {
                                                      return StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "regroupements")
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshotRegroupement) {
                                                            if (!snapshotRegroupement
                                                                .hasData) {
                                                              return Text("");
                                                            } else {
                                                              List<TableRow>
                                                                  listes = [
                                                                TableRow(
                                                                    children: [
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                'Code ',
                                                                                style: TextStyle(color: vert, fontSize: 12, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                'Nom Regroupement',
                                                                                style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                style: TextStyle(color: vert, fontSize: 12, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                    ])
                                                              ];

                                                              for (QueryDocumentSnapshot item
                                                                  in snapshotRegroupement
                                                                      .data!
                                                                      .docs) {
                                                                Timestamp
                                                                    timestamp =
                                                                    item.get(
                                                                        'date');
                                                                DateTime date =
                                                                    new DateTime
                                                                        .fromMicrosecondsSinceEpoch(timestamp
                                                                            .millisecondsSinceEpoch *
                                                                        1000);
                                                                if (true) {
                                                                  listes.add(
                                                                      TableRow(
                                                                          children: [
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Text(
                                                                                  item.get('code'),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.w300),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            )),
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Text(
                                                                                  item.get('name'),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 10, color: vert, fontWeight: FontWeight.w300),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            )),
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Text(
                                                                                  dateFormatter(date),
                                                                                  style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.w300),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            )),
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                GestureDetector(
                                                                                  onTap: () => null,
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
                                                                      ]));
                                                                }
                                                              }
                                                              return Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        constraints.maxHeight *
                                                                            .03,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      'Tableau des Associations',
                                                                      style: TextStyle(
                                                                          color:
                                                                              noir,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        constraints.maxHeight *
                                                                            .03,
                                                                  ),
                                                                  Container(
                                                                    height:
                                                                        constraints.maxHeight *
                                                                            .5,
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        Table(
                                                                          border:
                                                                              TableBorder.all(color: vert),
                                                                          children:
                                                                              listes,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            }
                                                          });
                                                    } else {
                                                      return StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "membres")
                                                                  .snapshots(),
                                                          builder: (context,
                                                              snapshotMembre) {
                                                            if (!snapshotMembre
                                                                .hasData) {
                                                              return Text('');
                                                            } else {
                                                              List<TableRow>
                                                                  listes = [
                                                                TableRow(
                                                                    children: [
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                'Code ',
                                                                                style: TextStyle(color: vert, fontSize: 12, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                'Nom ',
                                                                                style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                'Sexe',
                                                                                style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          height: constraints.maxHeight *
                                                                              .1,
                                                                          child:
                                                                              Row(
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
                                                                                style: TextStyle(color: vert, fontSize: 12, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          )),
                                                                    ])
                                                              ];

                                                              for (QueryDocumentSnapshot item
                                                                  in snapshotMembre
                                                                      .data!
                                                                      .docs) {
                                                                if (item.get(
                                                                        "regroupements") ==
                                                                    snapUser
                                                                        .data!
                                                                        .get(
                                                                            'regroupement')) {
                                                                  listes.add(
                                                                      TableRow(
                                                                          children: [
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Text(
                                                                                  item.get('matricule'),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.w300),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            )),
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Text(
                                                                                  "${item.get('prenom')} ${item.get('name')}",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 10, color: vert, fontWeight: FontWeight.w300),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            )),
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Text(
                                                                                  item.get('sexe'),
                                                                                  style: TextStyle(fontSize: 12, color: vert, fontWeight: FontWeight.w300),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            )),
                                                                        Container(
                                                                            height: size.height *
                                                                                .05,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                GestureDetector(
                                                                                  onTap: () => null,
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
                                                                      ]));
                                                                }
                                                              }
                                                              return Column(
                                                                children: [
                                                                  Text(
                                                                    "Liste des membres",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16,
                                                                        color:
                                                                            noir),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        constraints.maxHeight *
                                                                            .03,
                                                                  ),
                                                                  Container(
                                                                    height:
                                                                        constraints.maxHeight *
                                                                            .45,
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        Table(
                                                                          border:
                                                                              TableBorder.all(color: vert),
                                                                          children:
                                                                              listes,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                          });
                                                    }
                                                  }
                                                }),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            height: constraints.maxHeight * .3,
                            width: constraints.maxWidth,
                            child: Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight * .05,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth * .02,
                                      ),
                                      Text(
                                        'Détails Productions',
                                        style: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * .025,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      DropdownButton<String>(
                                        items: <String>[
                                          'Agriculture',
                                          'Élevage',
                                          'Horticulture',
                                          'Foncier',
                                          '25 NOVEMBRE'
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: valueData,
                                        onChanged: (value) {
                                          setState(() {
                                            valueData = value!;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .02,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: constraints.maxHeight * .2,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert,
                                          mois: 'Janvier',
                                          taille: .6,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Février',
                                          taille: .4,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Mars',
                                            taille: .5),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert2,
                                            mois: 'AVril',
                                            taille: .4),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert,
                                          mois: 'Mai',
                                          taille: .6,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Juin',
                                            taille: .3),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Juilliet',
                                          taille: .6,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Aout',
                                            taille: .7),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Septembre',
                                          taille: .4,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Octobre',
                                            taille: .6),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Novembre',
                                          taille: .7,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Décembre',
                                            taille: .6),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: blanc2,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )),
                          )),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: blanc, borderRadius: BorderRadius.circular(8)),
              )),
          MenuLeftHome(
            choice: 1,
          )
        ],
      ),
    );
  }
}
