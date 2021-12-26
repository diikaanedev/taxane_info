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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isCharging = false;
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
          ? ListView(
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
                          color: vert,
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
                  height: size.height * .01,
                ),
                Container(
                  height: size.height * .89,
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/part1.png"))),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/part2.png"))),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/part3.png"))),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/part1.png"))),
                              ),
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .12,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/part2.png"))),
                              ),
                              
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: constraints.maxHeight * .8,
                          color: gris3,
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
