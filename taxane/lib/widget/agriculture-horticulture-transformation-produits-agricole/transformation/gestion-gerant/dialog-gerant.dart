import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

addGerant({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) {
      TextEditingController code =
                TextEditingController();
            TextEditingController nom =
                TextEditingController();
                TextEditingController prenom =
                TextEditingController();
                TextEditingController cni =
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
                          'Formulaire d\'ajout de Gérants',
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
                              labelText: 'Code Gérantsr',
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
                              labelText: 'Nom Gérants',
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
                          controller: prenom,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Prenom Gérants',
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
                          controller: cni,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'CNI Gérants',
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
                        FirebaseFirestore.instance.collection("gerants").add({
                          "code" : code.text,
                          "nom" : nom.text,
                          "prenom" : prenom.text,
                          "cni" : cni.text,
                          "date" : DateTime.now()
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