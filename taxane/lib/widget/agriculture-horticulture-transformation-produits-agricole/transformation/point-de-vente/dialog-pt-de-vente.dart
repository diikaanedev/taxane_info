import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

addPtDeVente({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) {
      TextEditingController code =
                TextEditingController();
            TextEditingController adresse =
                TextEditingController();
                TextEditingController mat_gerant =
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
                          'Formulaire d\'ajout de Point de Vente',
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
                              labelText: 'Code point de vente',
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
                          controller: adresse,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'adresse point de vente',
                              icon: Icon(CupertinoIcons.map)),
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
                          controller: mat_gerant,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'matricule gérants',
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

                        FirebaseFirestore.instance.collection("gerants").get().then((value) {
                          String idGerant = 'nothing';
                          String nameGerant = '';
                             
                              print(mat_gerant.text.toLowerCase().trim());
                              for (var item in value.docs) {
                                  if (item.get("code").toString().toLowerCase().trim() == mat_gerant.text.toLowerCase().trim()) {
                                 idGerant = item.get('code');
                                 nameGerant = item.get('prenom') + ' ' + item.get('nom') ;
                               } 
                              }
                           
                            if (idGerant !='nothing') {
                               FirebaseFirestore.instance.collection("point-de-ventes").add({
                                  "code" : code.text,
                                  "adresse" : adresse.text,
                                  "idgerant" : idGerant,
                                  "gerant" : nameGerant,
                                  "date": DateTime.now()
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
                // ignore: deprecated_member_use
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