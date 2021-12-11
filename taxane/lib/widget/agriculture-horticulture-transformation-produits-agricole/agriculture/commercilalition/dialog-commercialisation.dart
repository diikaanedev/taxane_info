import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxane/screen/agriculture-hortoculture.dart';
import 'package:taxane/utils/color-by-dii.dart';

addCommercialisation(
    {required BuildContext context, required String idProduction}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController quantite = TextEditingController();
        TextEditingController matriculeMOS = TextEditingController();
        TextEditingController valeur = TextEditingController();
        TextEditingController reliquat = TextEditingController();
        TextEditingController numeroQuitance = TextEditingController();
        return AlertDialog(
          content: Container(
            height: size.height * .8,
            width: size.width * .5,
            child: Column(
              children: [
                Container(
                  height: size.height * .07,
                  child: Center(
                    child: Text(
                      'Formulaire d\'ajout de commercialisation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: noir,
                          fontSize: size.height * .03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
                          labelText: 'Code Commercialisation',
                          icon: Icon(CupertinoIcons.globe)),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: size.height * .01,
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
                          labelText: 'Quantité Produit en (kg)',
                          icon: Icon(CupertinoIcons.map)),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  height: size.height * .05,
                  width: size.width * .4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      cursorColor: vert,
                      controller: valeur,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Valeur du (k) en (FCFA) ',
                          icon: Icon(CupertinoIcons.map)),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  height: size.height * .05,
                  width: size.width * .4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      cursorColor: vert,
                      controller: matriculeMOS,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Matricule Opérateur Stockeur ',
                          icon: Icon(CupertinoIcons.map)),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                StatefulBuilder(
                  builder: (context, setState) => Container(
                    height: size.height * .05,
                    width: size.width * .4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: () async {
                          await showDatePicker(
                                  context: context,
                                  initialDate: agricultureHortocultureState
                                      .dateLivraison,
                                  initialDatePickerMode: DatePickerMode.day,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030))
                              .then((value) => setState(() {
                                    agricultureHortocultureState.dateLivraison =
                                        value!;
                                  }));
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                                width: size.width * .4,
                                child: Text(
                                    'Date de Livraison : ${agricultureHortocultureState.dateLivraison.day.toString()}/${agricultureHortocultureState.dateLivraison.month.toString()}/${agricultureHortocultureState.dateLivraison.year.toString()}')),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: vert),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                StatefulBuilder(
                  builder: (context, setState) => Container(
                    height: size.height * .05,
                    width: size.width * .4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: () async {
                          await showDatePicker(
                                  context: context,
                                  initialDate:
                                      agricultureHortocultureState.datePaiement,
                                  initialDatePickerMode: DatePickerMode.day,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030))
                              .then((value) => setState(() {
                                    agricultureHortocultureState.datePaiement =
                                        value!;
                                  }));
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                                width: size.width * .4,
                                child: Text(
                                    'Date de Paiement : ${agricultureHortocultureState.datePaiement.day.toString()}/${agricultureHortocultureState.datePaiement.month.toString()}/${agricultureHortocultureState.datePaiement.year.toString()}')),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: vert),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  height: size.height * .05,
                  width: size.width * .4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      cursorColor: vert,
                      controller: reliquat,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Reliquat en (FCFA) ',
                          icon: Icon(CupertinoIcons.map)),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  height: size.height * .05,
                  width: size.width * .4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      cursorColor: vert,
                      controller: numeroQuitance,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Numéro Quitance',
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
                GestureDetector(
                  onTap: () async {
                    FirebaseFirestore.instance
                        .collection('operateur-stockeur')
                        .get()
                        .then((value) async {
                      String idMembre = 'nothing';

                      print(matriculeMOS.text.toLowerCase().trim());
                      for (var item in value.docs) {
                        if (item.get("code").toString().toLowerCase().trim() ==
                            matriculeMOS.text.toLowerCase().trim()) {
                          idMembre = item.get('code');
                        }
                      }

                      if (idMembre != 'nothing') {
                        FirebaseFirestore.instance
                            .collection("productions")
                            .doc(idProduction)
                            .get()
                            .then((value) {
                          if (double.parse(value.get("quantite").toString()) >=
                              double.parse(quantite.text)) {
                            print("heree");
                            FirebaseFirestore.instance
                                .collection("commercialisations")
                                .add({
                              "code": code.text,
                              "operateur-stockeur": idMembre,
                              "valeur": valeur.text,
                              "quitance": numeroQuitance.text,
                              "quantite": quantite.text,
                              "reliquat": reliquat.text,
                              "produit": value.get("nomProduit"),
                              "idProduit": value.get("idProduit"),
                              "dateLivraison": agricultureHortocultureState
                                  .dateLivraison
                                  .toString(),
                              "datePaiement": agricultureHortocultureState
                                  .datePaiement
                                  .toString(),
                              "productionID": idProduction,
                              "date": DateTime.now()
                            }).then((_) async {
                              await FirebaseFirestore.instance
                                  .collection("productions")
                                  .doc(idProduction)
                                  .update({
                                "quantite": (double.parse(
                                            value.get("quantite").toString()) -
                                        double.parse(quantite.text))
                                    .toString(),
                              });
                              Navigator.pop(context);
                            });
                          } else {
                            print(
                                "double.parse(value.get(quantite).toString()) : ${double.parse(value.get("quantite").toString())}");
                            print(
                                "double.parse(quantite.text)) : ${double.parse(quantite.text)}");
                          }
                        });
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
                Spacer(),
              ],
            ),
          ),
        );
      });
}
