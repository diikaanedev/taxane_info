import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/screen/equipement-collectif.dart';
import 'package:taxane/utils/color-by-dii.dart';

addCaracterique({required BuildContext context, required String idVillage}) {
  return showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
        TextEditingController categorie = TextEditingController();
        TextEditingController finance = TextEditingController();
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Container(
            width: size.width * .5,
            child: Row(
              children: [
                Spacer(),
                Text('Gestion des equipement collectifs '),
                Spacer(),
              ],
            ),
          ),
          content: Container(
            height: size.height * .7,
            width: size.width * .5,
            // color: vert,
            child: Column(
              children: [
                Spacer(),
                Container(
                  height: size.height * .1,
                  child: Center(
                    child: Text(
                      'Formulaire d\'ajout d\'un caracteristique',
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
                          labelText: "matricule caracteristique",
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
                      controller: nom,
                      decoration: InputDecoration(
                          labelText: "nom caracteristique",
                          border: InputBorder.none,
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
                StatefulBuilder(builder: (context, setState) {
                  return Container(
                    height: size.height * .04,
                    width: size.width * .4,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.male),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Domaine Hydrolique / '),
                            DropdownButton<String>(
                                value:
                                    administrationFoncierState.domaineHydrolique,
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    administrationFoncierState.setState(() {
                                      administrationFoncierState
                                          .domaineHydrolique = newValue!;
                                    });
                                  });
                                },
                                items: [
                                  "hydrolique",
                                  "sante",
                                  "educations",
                                  "autres"
                                ]
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.toUpperCase())))
                                    .toList()),
                          ],
                        )),
                    decoration: BoxDecoration(
                        border: Border.all(color: vert),
                        borderRadius: BorderRadius.circular(8)),
                  );
                }),
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
                      controller: categorie,
                      decoration: InputDecoration(
                          labelText: "categorie caracteristique",
                          border: InputBorder.none,
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
                      controller: finance,
                      decoration: InputDecoration(
                          labelText: "finance caracteristique",
                          border: InputBorder.none,
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
                                  initialDate: DateTime.now(),
                                  initialDatePickerMode: DatePickerMode.day,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030))
                              .then((value) => setState(() {
                                administrationFoncierState.dateInnauguration = value!;
                              }));
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                                width: size.width * .4,
                                child: Text('Date de Livraison : ${administrationFoncierState.dateInnauguration.day.toString()}/${administrationFoncierState.dateInnauguration.month.toString()}/${administrationFoncierState.dateInnauguration.year.toString()}')),
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
                  height: size.height * .05,
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance.collection("equipement-collectif").add({
                      "code": code.text,
                      "nom": nom.text,
                      "dateInnauguration" : administrationFoncierState.dateInnauguration,
                      "finance" : finance.text,
                      "categorie" : categorie.text,
                      "villageID" : idVillage,
                      "date": DateTime.now()
                    }).then((value) {
                      Navigator.pop(context);
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
        );
      });
}
