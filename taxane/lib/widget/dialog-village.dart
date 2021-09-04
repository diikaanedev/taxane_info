import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

dialogAddVillage(
    {required BuildContext context,
    required String idPays,
    required String idRegion,
    required String idDepartement,
    required String idCommune}) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("pays")
                .doc(idPays)
                .collection("regions")
                .doc(idRegion)
                .collection("departements")
                .doc(idDepartement)
                .collection("communes")
                .doc(idCommune)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                TextEditingController code = TextEditingController();
                TextEditingController nom = TextEditingController();
                return AlertDialog(
                  title: Container(
                    width: size.width * .5,
                    child: Row(
                      children: [
                        Spacer(),
                        Text('Gestion des Villages/Quartiers '),
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
                              'Formulaire d\'ajout de villages/vuartiers',
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
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('pays')
                                .doc(idPays)
                                .collection("regions")
                                .doc(idRegion)
                                .collection("departements")
                                .doc(idDepartement)
                                .collection("communes")
                                .doc(idCommune)
                                .collection("villages")
                                .add({
                              "code": code.text,
                              "nom": nom.text,
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
                        Spacer(),
                      ],
                    ),
                  ),
                );
              }
            });
      });
}

dialogEditVillage({
  required BuildContext context,
  required String idPays,
  required String idRegion,
  required String idDepartement,
  required String idCommune,
  required String idVillage,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("pays")
                .doc(idPays)
                .collection("regions")
                .doc(idRegion)
                .collection("departements")
                .doc(idDepartement)
                .collection("communes")
                .doc(idCommune)
                .collection("villages")
                .doc(idVillage)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                TextEditingController code =
                    TextEditingController(text: snapshot.data!.get('code'));
                TextEditingController nom =
                    TextEditingController(text: snapshot.data!.get('nom'));
                return AlertDialog(
                  title: Container(
                    width: size.width * .5,
                    child: Row(
                      children: [
                        Spacer(),
                        Text('Gestion des Villages/Quartiers '),
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
                              'Formulaire de modification de ${snapshot.data!.get('nom')}',
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
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('pays')
                                .doc(idPays)
                                .collection("regions")
                                .doc(idRegion)
                                .collection("departements")
                                .doc(idDepartement)
                                .collection("communes")
                                .doc(idCommune)
                                .collection("villages")
                                .doc(idVillage)
                                .update({
                              "code": code.text,
                              "nom": nom.text,
                            }).then((value) => Navigator.pop(context));
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .2,
                            child: Center(
                              child: Text(
                                'Modifier',
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
              }
            });
      });
}
