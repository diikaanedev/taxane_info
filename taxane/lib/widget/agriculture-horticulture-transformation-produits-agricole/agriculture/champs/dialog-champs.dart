import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

addChamps({required BuildContext context, required String idVillage}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController codeMembre = TextEditingController();
        TextEditingController surface = TextEditingController();
        TextEditingController lattitude = TextEditingController();
        TextEditingController longitude = TextEditingController();

        return AlertDialog(
          content: Container(
            height: size.height * .7,
            width: size.width * .5,
            child: Column(
              children: [
                Spacer(),
                Container(
                  height: size.height * .07,
                  child: Center(
                    child: Text(
                      'Formulaire d\'ajout de Champs',
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
                      controller: codeMembre,
                      decoration: InputDecoration(
                          labelText: "Code Membre Propriétaire",
                          border: InputBorder.none,
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
                  height: size.height * .05,
                  width: size.width * .4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      cursorColor: vert,
                      controller: code,
                      decoration: InputDecoration(
                          labelText: "Code Champs",
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
                          labelText: "Surface Champs",
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
                      controller: lattitude,
                      decoration: InputDecoration(
                          labelText: "Lattitude Champs",
                          border: InputBorder.none,
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
                      controller: longitude,
                      decoration: InputDecoration(
                          labelText: "Longitude Champs",
                          border: InputBorder.none,
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
                  onTap: () async {
                    FirebaseFirestore.instance
                        .collection('membres')
                        .get()
                        .then((value) {
                      String idMembre = 'nothing';

                      print(codeMembre.text.toLowerCase().trim());
                      for (var item in value.docs) {
                        print("e.get('matricule') => ${item.get("matricule")}");
                        if (item
                                .get("matricule")
                                .toString()
                                .toLowerCase()
                                .trim() ==
                            codeMembre.text.toLowerCase().trim()) {
                          idMembre = item.get('matricule');
                        }
                      }

                      if (idMembre != 'nothing') {
                        FirebaseFirestore.instance.collection("champs").add({
                          "code": code.text,
                          "membre": idMembre,
                          "surface": double.parse(surface.text),
                          "geoPoint": GeoPoint(double.parse(lattitude.text),
                              double.parse(longitude.text)),
                          "village": idVillage,
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
        );
      });
}
