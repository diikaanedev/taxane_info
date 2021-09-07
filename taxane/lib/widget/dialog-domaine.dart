import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

addDomaine({
  required BuildContext context , 
  required String idVillage
}) {
Size size = MediaQuery.of(context).size;
  


  return showDialog(
    context: context,
    builder: (context) {
         TextEditingController code = TextEditingController();
                TextEditingController surface = TextEditingController();
                TextEditingController longitude = TextEditingController();
                TextEditingController latitude = TextEditingController();
                TextEditingController titre = TextEditingController();
                TextEditingController usage = TextEditingController();
                TextEditingController cni = TextEditingController();
                  return  AlertDialog(
                  content: Container(
                    height: size.height * .9,
                    width: size.width * .7,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Spacer(),
                                
                                Text("Formulaire d'ajout de domaine" , style: TextStyle(
                                  fontSize: 20 , 
                                  fontWeight: FontWeight.bold
                                ),)
                                ,
                                Spacer(),
                              ],
                            ),
                        )),

                        Expanded(
                          flex:4,
                          child: Container(
                            child: Column(
                              children: [
Container(
                          height: size.height * .05,
                          width: size.width * .4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              cursorColor: vert,
                              controller: code,
                              decoration: InputDecoration(
                                  labelText: "Code du domaine",
                                  border: InputBorder.none,
                                  icon: Icon(CupertinoIcons.globe)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              cursorColor: vert,
                              controller: surface,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Surface du domaine en m²",
                                  icon: Icon(CupertinoIcons.map)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ),

                        SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              cursorColor: vert,
                              controller: latitude,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Latitude du domaine",
                                  icon: Icon(CupertinoIcons.location)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ), 

                          SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              cursorColor: vert,
                              controller: longitude,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Longitude du domaine",
                                  icon: Icon(CupertinoIcons.location)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ), 

                          SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              cursorColor: vert,
                              controller: titre,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Titre du domaine",
                                  icon: Icon(CupertinoIcons.location)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ), 

                          SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              cursorColor: vert,
                              controller: usage,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Usage du domaine",
                                  icon: Icon(CupertinoIcons.person)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ), 

                         SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              cursorColor: vert,
                              controller: cni,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "CNI du propriétaire du domaine",
                                  icon: Icon(CupertinoIcons.person)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ), 
                       
                        SizedBox(
                          height: size.height * .05,
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("domaines")
                                .add({
                              "code": code.text,
                              "surface": surface.text,
                              "titre" : titre.text,
                              "usage" : usage.text,
                              "cni" : cni.text,
                              "villages" : idVillage,
                              "geoPoint" : GeoPoint(double.parse(latitude.text), double.parse(longitude.text)), 
                              "date": DateTime.now()
                            }).then((value) => Navigator.pop(context));
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .2,
                            child: Center(
                              child: Text(
                                'Ajouter',
                                style: TextStyle(
                                    color: jaune, fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: jaune),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                              ],
                            ),
                        )),
                      ],
                    ),
                  ),
                );
    }
              
  );

}