import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';

addMenage(
    {required BuildContext context,
    required String idConcession,
    }) {
  Size size = MediaQuery.of(context).size;
  TextEditingController code = TextEditingController();
                TextEditingController nomCM = TextEditingController();
                TextEditingController nombrePersonne = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
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
     
     Text("Formulaire d'ajout de ménage" , style: TextStyle(
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
                                  labelText: "Code Ménage",
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
                              controller: nomCM,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Nom Chef Ménage",
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
                              controller: nombrePersonne,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Nombre de Personne Ménage",
                                  icon: Icon(CupertinoIcons.number_square)),
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
                                .collection("menages")
                                .add({
                              "code": code.text,
                              "nom": nomCM.text,
                              "nombre_personne" : nombrePersonne.text,
                              "concessions" : idConcession,
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
                ),
              )
  );
}
