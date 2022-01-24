import 'package:taxane/utils/requette.dart';
import 'package:taxane/widget/table-row-header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

class EspaceVisiteurScreen extends StatefulWidget {
  const EspaceVisiteurScreen({Key? key}) : super(key: key);

  @override
  _EspaceVisiteurScreenState createState() => _EspaceVisiteurScreenState();
}

class _EspaceVisiteurScreenState extends State<EspaceVisiteurScreen> {
  late Size size;
  TextEditingController identifiant = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPartenaire = true;
  bool chargementConnexion = false;
  bool isCharging = false;
  late String cultureSelected;
  late String cultureSelectedName;
  late String materielSelected;
  late String materielSelectedName;
  String requetteSelected = "Choisir une secteur d\'activites";
  String produitSelected = "produits";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isCharging = false;
      });
    });
    getData();
  }

  getData() async {
    FirebaseFirestore.instance.collection("cultures").get().then((value) {
      setState(() {
        cultureSelected = value.docs.first.id;
      });
    });
    FirebaseFirestore.instance.collection("materiels").get().then((value) {
      setState(() {
        materielSelected = value.docs.first.id;
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
      backgroundColor: blanc,
      body: !isCharging
          ? Column(
              children: [
                Center(
                  child: Container(
                      width: size.width * .6,
                      height: size.height * .03,
                      // color: vert,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Center(
                          child: Text(
                            '© 2021 Leegey\'s, Inc. All rights reserved',
                            style: TextStyle(
                                fontSize: constraints.maxHeight * .4,
                                color: vert.withOpacity(.4)),
                          ),
                        );
                      })),
                ),
                Container(
                  height: size.height * .06,
                  width: size.width,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      children: [
                        Spacer(),
                        Container(
                          width: constraints.maxWidth * .7,
                          height: constraints.maxHeight,
                          color: noir.withOpacity(.8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * .05,
                              ),
                              Container(
                                // width: constraints.maxWidth * .05,
                                child: Center(
                                  child: Text('TAXAN-INFO',
                                      style: TextStyle(
                                          color: blanc,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              constraints.maxHeight * .45)),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * .04,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Container(
                                      width: constraints.maxWidth * .5,
                                      child: Text(
                                        "Collecte Traitement et Diffusion de l\'information",
                                        style: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * .3,
                                            fontWeight: FontWeight.w300,
                                            color: blanc),
                                      ),
                                    ),
                                    Container(
                                      width: constraints.maxWidth * .5,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Sous forme de ",
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight * .3,
                                                fontWeight: FontWeight.w300,
                                                color: blanc),
                                          ),
                                          Text(
                                            "DONNÉES STATISTIQUES ET D\'INDICATEUR DE SUIVI ",
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight * .35,
                                                fontWeight: FontWeight.bold,
                                                color: blanc),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    );
                  }),
                ),
                SizedBox(
                  height: size.height * .010,
                ),
                Spacer(),
                Container(
                  height: size.height * .9,
                  width: size.width,
                  // color: gris,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      children: [
                        Container(
                          height: constraints.maxHeight * .2,
                          child: Row(
                            children: [
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                height: constraints.maxHeight * .15,
                                child: Center(
                                  child: Text(
                                    "Partenaires 1",
                                    style: TextStyle(
                                        fontSize: constraints.maxHeight * .03,
                                        fontWeight: FontWeight.bold,
                                        color: blanc),
                                  ),
                                ),
                                color: Color(0xFF000000).withOpacity(.35),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                height: constraints.maxHeight * .15,
                                child: Center(
                                  child: Text(
                                    "Partenaires 2",
                                    style: TextStyle(
                                        fontSize: constraints.maxHeight * .03,
                                        fontWeight: FontWeight.bold,
                                        color: blanc),
                                  ),
                                ),
                                color: Color(0xFF000000).withOpacity(.35),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                height: constraints.maxHeight * .15,
                                child: Center(
                                  child: Text(
                                    "Partenaires 3",
                                    style: TextStyle(
                                        fontSize: constraints.maxHeight * .03,
                                        fontWeight: FontWeight.bold,
                                        color: blanc),
                                  ),
                                ),
                                color: Color(0xFF000000).withOpacity(.35),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                height: constraints.maxHeight * .15,
                                child: Center(
                                  child: Text(
                                    "Partenaires 4",
                                    style: TextStyle(
                                        fontSize: constraints.maxHeight * .03,
                                        fontWeight: FontWeight.bold,
                                        color: blanc),
                                  ),
                                ),
                                color: Color(0xFF000000).withOpacity(.35),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                height: constraints.maxHeight * .15,
                                child: Center(
                                  child: Text(
                                    "Partenaires 5",
                                    style: TextStyle(
                                        fontSize: constraints.maxHeight * .03,
                                        fontWeight: FontWeight.bold,
                                        color: blanc),
                                  ),
                                ),
                                color: Color(0xFF000000).withOpacity(.35),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: constraints.maxHeight * .8,
                          color: Color(0xFFEEEEEE).withOpacity(.35),
                          child: Column(
                            children: [
                              Spacer(),
                              Container(
                                height: constraints.maxHeight * .7,
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Container(
                                      width: constraints.maxWidth * .25,
                                      child: Container(
                                          width: constraints.maxWidth * .2,
                                          child: Column(
                                            children: [
                                              DropdownButton(
                                                  style: TextStyle(
                                                      fontSize: constraints
                                                              .maxHeight *
                                                          .02,
                                                      color:
                                                          noir.withOpacity(.8)),
                                                  value: requetteSelected,
                                                  items: [
                                                    "Choisir une secteur d\'activites",
                                                    "Agriculture",
                                                    "Elevage",
                                                    "Mortalite",
                                                    "Violence",
                                                  ]
                                                      .map((e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                              e.toUpperCase())))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      requetteSelected =
                                                          value.toString();
                                                    });
                                                  }),
                                              Spacer(),
                                              Container(
                                                height:
                                                    constraints.maxHeight * .05,
                                                width:
                                                    constraints.maxWidth * .2,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      constraints.maxHeight *
                                                          .005),
                                                  child: TextField(
                                                    cursorColor:
                                                        noir.withOpacity(.8),
                                                    controller: identifiant,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        label: Text(
                                                            '    Identifiant   ')),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: noir
                                                            .withOpacity(.8)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .02,
                                              ),
                                              Container(
                                                width:
                                                    constraints.maxWidth * .2,
                                                height:
                                                    constraints.maxHeight * .05,
                                                child: TextField(
                                                  cursorColor:
                                                      noir.withOpacity(.8),
                                                  controller: password,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      label: Text(
                                                          '    Mot de passe   ')),
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: noir
                                                            .withOpacity(.8)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .05,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    chargementConnexion = true;
                                                  });
                                                  await FirebaseAuth.instance
                                                      .signInWithEmailAndPassword(
                                                          email:
                                                              identifiant.text,
                                                          password:
                                                              password.text)
                                                      .then((value) {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(value.user!.uid)
                                                        .get()
                                                        .then((doc) async {
                                                      Navigator.popAndPushNamed(
                                                          context, "/home");
                                                    }).catchError((err) {
                                                      print("we haeve error");
                                                      setState(() {
                                                        chargementConnexion =
                                                            false;
                                                      });
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  width:
                                                      constraints.maxWidth * .1,
                                                  height:
                                                      constraints.maxHeight *
                                                          .05,
                                                  child: chargementConnexion
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            backgroundColor:
                                                                noir.withOpacity(
                                                                    .8),
                                                            color: blanc,
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Text(
                                                            'Connexion',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    constraints
                                                                            .maxHeight *
                                                                        .02,
                                                                color: blanc),
                                                          ),
                                                        ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: noir
                                                              .withOpacity(.8)),
                                                      color:
                                                          noir.withOpacity(.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                height:
                                                    constraints.maxHeight * .2,
                                                color: blanc,
                                                child: Column(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .07,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await launch(
                                                              "https://download1493.mediafire.com/sy2o22xjxcpg/y3gryvei5o5n6wp/Formulaires.zip");
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Container(
                                                              // width: constraints.maxWidth * .3,
                                                              child: Icon(
                                                                Icons.download,
                                                                color: noir
                                                                    .withOpacity(
                                                                        .8),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              'Télécharger\nle Formulaire d\'inscription',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: noir
                                                                      .withOpacity(
                                                                          .8)),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Spacer(),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: gris.withOpacity(.1),
                                              border: Border.all(
                                                  color: noir.withOpacity(.8)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: blanc,
                                                    offset: Offset(1, 1),
                                                    blurRadius: 2)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * .02,
                                    ),
                                    Container(
                                      width: constraints.maxWidth * .6,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    if (requetteSelected ==
                                                        "Agriculture")
                                                      produitSelected ==
                                                              "produits"
                                                          ? StreamBuilder<
                                                                  QuerySnapshot>(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "cultures")
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Text(
                                                                      "");
                                                                } else {
                                                                  return DropdownButton(
                                                                      style: TextStyle(
                                                                          fontSize: constraints.maxHeight *
                                                                              .02,
                                                                          color: noir.withOpacity(
                                                                              .8)),
                                                                      value:
                                                                          cultureSelected,
                                                                      items: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((e) => DropdownMenuItem(
                                                                              value: e.id,
                                                                              child: Text(e.get("nom").toString().toUpperCase())))
                                                                          .toList(),
                                                                      onChanged: (value) {
                                                                        setState(
                                                                            () {
                                                                          cultureSelected =
                                                                              value.toString();
                                                                        });
                                                                      });
                                                                }
                                                              })
                                                          : StreamBuilder<
                                                                  QuerySnapshot>(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "materiels")
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Text(
                                                                      "");
                                                                } else {
                                                                  return DropdownButton(
                                                                      style: TextStyle(
                                                                          fontSize: constraints.maxHeight *
                                                                              .02,
                                                                          color: noir.withOpacity(
                                                                              .8)),
                                                                      value:
                                                                          materielSelected,
                                                                      items: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .map((e) => DropdownMenuItem(
                                                                              value: e.id,
                                                                              child: Text(e.get("nom").toString().toUpperCase())))
                                                                          .toList(),
                                                                      onChanged: (value) {
                                                                        setState(
                                                                            () {
                                                                          materielSelected =
                                                                              value.toString();
                                                                        });
                                                                      });
                                                                }
                                                              })
                                                    else
                                                      Text(''),
                                                    Spacer(),
                                                    if (requetteSelected ==
                                                        "Agriculture")
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                produitSelected =
                                                                    "produits";
                                                              });
                                                            },
                                                            child: Container(
                                                              child: Text(
                                                                'Produits',
                                                                style: produitSelected ==
                                                                        "produits"
                                                                    ? TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            constraints.maxHeight *
                                                                                .02,
                                                                        color: rouge.withOpacity(
                                                                            .8))
                                                                    : TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            constraints.maxHeight *
                                                                                .015,
                                                                        color: rouge
                                                                            .withOpacity(.2)),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: constraints
                                                                    .maxWidth *
                                                                .05,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                produitSelected =
                                                                    "materiels";
                                                              });
                                                            },
                                                            child: Container(
                                                              child: Text(
                                                                'matériels',
                                                                style: produitSelected !=
                                                                        "produits"
                                                                    ? TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            constraints.maxHeight *
                                                                                .02,
                                                                        color: rouge.withOpacity(
                                                                            .8))
                                                                    : TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            constraints.maxHeight *
                                                                                .015,
                                                                        color: rouge
                                                                            .withOpacity(.2)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    else
                                                      Row(),
                                                    Spacer(),
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                              flex: 9,
                                              child: Container(
                                                // color: rouge,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          width: constraints
                                                                  .maxWidth *
                                                              .5,
                                                          child: getHeader(
                                                              context: context,
                                                              titles: [
                                                                "Régions",
                                                                "Produit",
                                                                "Quantité",
                                                                "Voir"
                                                              ],
                                                              width: constraints
                                                                      .maxWidth *
                                                                  .07,
                                                              constraints:
                                                                  constraints),
                                                        ),
                                                        Spacer(),
                                                        Icon(Icons.download)
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        height: .4,
                                                        color: Color(0xFF000000)
                                                            .withOpacity(.15),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          .57,
                                                      child: StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "regions")
                                                                  .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            List<TableRow>
                                                                listes = [];
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Text('');
                                                            } else {
                                                              return ListView(
                                                                children: [
                                                                  Column(
                                                                    children: snapshot
                                                                        .data!
                                                                        .docs
                                                                        .map((e) =>
                                                                            Container(
                                                                              height: constraints.maxHeight * .05,
                                                                              width: constraints.maxWidth,
                                                                              child: FutureBuilder(
                                                                                  future: getNumber(idRegion: e.id, idCulture: cultureSelected),
                                                                                  builder: (context, valueFuture) {
                                                                                    return  !valueFuture.hasData ? Center(child: Container(
                                                                                      height: 50,
                                                                                      width: 50,
                                                                                      child: CircularProgressIndicator())) : Row(
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: constraints.maxWidth * .06,
                                                                                        ),
                                                                                        getRowTable(
                                                                                            context: context,
                                                                                            titles: [
                                                                                              e.get("nom"),
                                                                                              cultureSelected,
                                                                                              valueFuture.data.toString(),
                                                                                            ],
                                                                                            heigth: constraints.maxHeight * .07,
                                                                                            width: constraints.maxWidth * .15,
                                                                                            choixColor: 12,
                                                                                            constraints: constraints),
                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                            ))
                                                                        .toList(),
                                                                  )
                                                                ],
                                                              );
                                                            }
                                                          }),
                                                    )
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: constraints.maxHeight * .07,
                                color: noir.withOpacity(.8),
                              ),
                              Spacer(),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ],
            )
          : Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Text(
                    "Le Portails taxan info vous est offert par",
                    style: TextStyle(
                        fontSize: size.height * .04,
                        color: vert,
                        fontFamily: "nadia-sofia",
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Container(
                    height: size.height * .4,
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: size.width * .25,
                                height: size.height * .3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/onufemme.png"),
                                )),
                              ),
                              Text(
                                'Onu Femme',
                                style: TextStyle(
                                    fontSize: size.height * .02,
                                    color: vert,
                                    // fontFamily: "nadia-sofia",
                                    letterSpacing: 2),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: size.width * .25,
                                height: size.height * .3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage("assets/images/blason.jpg"),
                                )),
                              ),
                              Text(
                                'Le Ministère de la Femme de la Famille et de la Petite Enfance',
                                style: TextStyle(
                                    fontSize: size.height * .02,
                                    color: vert,
                                    // fontFamily: "nadia-sofia",
                                    letterSpacing: 2),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .2,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: vert,
                      backgroundColor: blanc,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
