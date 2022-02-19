import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

addChargeOperationTransformation(
    {required BuildContext context, required String idOperation}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
        TextEditingController quantite = TextEditingController();
        TextEditingController prix_unitaire = TextEditingController();
        return AlertDialog(
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
                      'Formulaire d\'ajout de de charge',
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
                          labelText: 'Code charge',
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
                          labelText: 'Nom Charge',
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
                      controller: quantite,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'quantite',
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
                      controller: prix_unitaire,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'prix unitaire',
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
                    FirebaseFirestore.instance.collection("charges").add({
                      "code": code.text,
                      "nom": nom.text,
                      "quantite": quantite.text,
                      "opperationID": idOperation,
                      "prix_unitaire": prix_unitaire.text,
                      "prix_total": (int.parse(prix_unitaire.text) *
                              int.parse(quantite.text))
                          .toString(),
                      "date": DateTime.now()
                    }).then((value) async {
                      int montant = 0;
                      await FirebaseFirestore.instance
                          .collection("operation-transformation")
                          .doc(idOperation)
                          .get()
                          .then((value) {
                        montant = int.parse(value.get("compte-exploitation"));
                      });
                      FirebaseFirestore.instance
                          .collection("operation-transformation")
                          .doc(idOperation)
                          .update({
                        "compte-exploitation": (montant -
                            (int.parse(prix_unitaire.text) *
                                int.parse(quantite.text))).toString()
                      }).then((value) => Navigator.pop(context));
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
