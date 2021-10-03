import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

addTroupeaux({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) {
      TextEditingController code =
                TextEditingController();
            TextEditingController nom =
                TextEditingController();

                TextEditingController matricule_eleveur =
                TextEditingController();

                  TextEditingController lieux =
                TextEditingController();




    return  AlertDialog(
    content: Container(
      height: size.height * .8,
      width: size.width * .5,
      child: Column(
        children: [
           Spacer(),
                    Container(
                      height: size.height * .1,
                      child: Center(
                        child: Text(
                          'Formulaire d\'ajout d\'un troupeaux',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: noir,
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: code,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Code trapeaux',
                              icon: Icon(CupertinoIcons.globe)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: nom,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Nom troupeaux',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                       SizedBox
                       (
                      height: size.height * .05,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: matricule_eleveur,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Matricule eleveur',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                     SizedBox
                       (
                      height: size.height * .05,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: lieux,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Adresse ',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: size.height * .1,
                    ),
                    GestureDetector(
                      onTap: () async {

                         FirebaseFirestore.instance.collection('membres').get().then((value)  {
                             String idMembre = 'nothing';
                             
                              print(matricule_eleveur.text.toLowerCase().trim());
                              for (var item in value.docs) {
                                  if (item.get("matricule").toString().toLowerCase().trim() == matricule_eleveur.text.toLowerCase().trim()) {
                                 idMembre = item.get('matricule');
                               } 
                              }

                           
                            if (idMembre !='nothing') {

                                FirebaseFirestore.instance.collection("troupeaux").add({
                          "code" : code.text,
                          "nom" : nom.text,
                          "eleveur" : idMembre,
                          "adresse" : lieux.text,
                          "date" : DateTime.now()
                        }).then((value) => Navigator.pop(context));

                           
                            }
                           

                           });

                      
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
                    Spacer(),
        ],
      ),
    ),
     actions: [
                RaisedButton(
                    color: rouge,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "   Fermer   ",
                      style: TextStyle(
                          fontSize: size.height * .015,
                          fontWeight: FontWeight.bold,
                          color: blanc),
                    ))
              ],
  );
  });
}