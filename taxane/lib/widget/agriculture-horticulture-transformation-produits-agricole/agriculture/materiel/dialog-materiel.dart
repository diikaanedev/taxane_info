import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/agriculture-hortoculture.dart';
import 'package:taxane/utils/color-by-dii.dart';

addMateriel({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
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
                      'Formulaire d\'ajout de matériel',
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
                          labelText: 'Code Matériel',
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
                          labelText: 'Nom Materiel',
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
                    FirebaseFirestore.instance.collection("materiels").add({
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

addMaterielChamps(
    {required BuildContext context, required String idChamps}) async {
  Size size = MediaQuery.of(context).size;

  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
        return AlertDialog(
          content: Container(
            height: size.height * .8,
            width: size.width * .5,
            child: Column(
              children: [
                Spacer(),
                StatefulBuilder(builder: (context, setState) {
                  FirebaseFirestore.instance
                      .collection('champs')
                      .doc(idChamps)
                      .get()
                      .then((value) async {
                    FirebaseFirestore.instance
                        .collection('membres')
                        .get()
                        .then((membres) {
                      for (var item in membres.docs) {
                        print(item.get('matricule').toString().toLowerCase());
                        print(
                            "membre : ${value.get('membre').toString().toLowerCase()}");
                        print(
                            "champs : ${item.get('prenom').toString().toLowerCase()}");
                        if (item.get('matricule').toString().toLowerCase() ==
                            value.get('membre').toString().toLowerCase()) {
                          setState(() {
                            agricultureHortocultureState.setState(() {
                              agricultureHortocultureState.perso =
                                  item.get('prenom') + ' ' + item.get('name');
                            });
                          });
                        }
                      }
                    });
                  });
                  return Container(
                    height: size.height * .1,
                    child: Center(
                      child: Text(
                        'Formulaire d\'ajout de matériel sur le Champs de : \n\n ${agricultureHortocultureState.perso}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: noir,
                            fontSize: size.height * .02,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: size.height * .05,
                ),
                Container(
                  height: size.height * .04,
                  width: size.width * .4,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text('Matériels / '),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("materiels")
                                  .snapshots(),
                              builder: (context, snaps) {
                                return !snaps.hasData
                                    ? Container()
                                    : StatefulBuilder(
                                        builder: (context, setState) =>
                                            DropdownButton<String>(
                                                value:
                                                    agricultureHortocultureState
                                                        .materiels,
                                                underline: Container(),
                                                onChanged:
                                                    (String? newValue) async {
                                                  setState(() {
                                                    // ignore: invalid_use_of_protected_member
                                                    agricultureHortocultureState
                                                        .setState(() {
                                                      agricultureHortocultureState
                                                              .materiels =
                                                          newValue!;
                                                    });
                                                  });
                                                },
                                                items: snaps.data!.docs
                                                    .toList()
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                            value: e.id,
                                                            child: Text(
                                                                e.get('nom'))))
                                                    .toList()),
                                      );
                              }),
                        ],
                      )),
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                SizedBox(
                  height: size.height * .1,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection("materiels")
                        .doc(agricultureHortocultureState.materiels)
                        .get()
                        .then((value) {
                      // ignore: invalid_use_of_protected_member
                      agricultureHortocultureState.setState(() {
                        agricultureHortocultureState.materielsNom =
                            value.get('nom')!;
                        agricultureHortocultureState.materielsCode =
                            value.get('code')!;
                      });
                    });
                    FirebaseFirestore.instance
                        .collection("materiels-champs")
                        .add({
                      "materiel": agricultureHortocultureState.materiels,
                      "materielNom": agricultureHortocultureState.materielsNom,
                      "materielCode":
                          agricultureHortocultureState.materielsCode,
                      "champs": idChamps,
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

addMaterielChampsRole2(
    {required BuildContext context, required String idChamps}) async {
  Size size = MediaQuery.of(context).size;

  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
        return AlertDialog(
          content: Container(
            height: size.height * .8,
            width: size.width * .5,
            child: Column(
              children: [
                Spacer(),
                StatefulBuilder(builder: (context, setState) {
                  FirebaseFirestore.instance
                      .collection('champs')
                      .doc(idChamps)
                      .get()
                      .then((value) async {
                    FirebaseFirestore.instance
                        .collection('membres')
                        .get()
                        .then((membres) {
                      for (var item in membres.docs) {
                        print(item.get('matricule').toString().toLowerCase());
                        print(
                            "membre : ${value.get('membre').toString().toLowerCase()}");
                        print(
                            "champs : ${item.get('prenom').toString().toLowerCase()}");
                        if (item.get('matricule').toString().toLowerCase() ==
                            value.get('membre').toString().toLowerCase()) {
                          setState(() {
                            agricultureHortocultureState.setState(() {
                              agricultureHortocultureState.perso =
                                  item.get('prenom') + ' ' + item.get('name');
                            });
                          });
                        }
                      }
                    });
                  });
                  return Container(
                    height: size.height * .1,
                    child: Center(
                      child: Text(
                        'Formulaire d\'ajout de matériel sur le Champs de : \n\n ${agricultureHortocultureState.perso}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: noir,
                            fontSize: size.height * .02,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: size.height * .05,
                ),
                Container(
                  height: size.height * .04,
                  width: size.width * .4,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text('Matériels / '),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("materiels")
                                  .snapshots(),
                              builder: (context, snaps) {
                                return !snaps.hasData
                                    ? Container()
                                    : StatefulBuilder(
                                        builder: (context, setState) =>
                                            DropdownButton<String>(
                                                value:
                                                    agricultureHortocultureState
                                                        .materiels,
                                                underline: Container(),
                                                onChanged:
                                                    (String? newValue) async {
                                                  setState(() {
                                                    // ignore: invalid_use_of_protected_member
                                                    agricultureHortocultureState
                                                        .setState(() {
                                                      agricultureHortocultureState
                                                              .materiels =
                                                          newValue!;
                                                    });
                                                  });
                                                },
                                                items: snaps.data!.docs
                                                    .toList()
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                            value: e.id,
                                                            child: Text(
                                                                e.get('nom'))))
                                                    .toList()),
                                      );
                              }),
                        ],
                      )),
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                SizedBox(
                  height: size.height * .1,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection("materiels")
                        .doc(agricultureHortocultureState.materiels)
                        .get()
                        .then((value) {
                      // ignore: invalid_use_of_protected_member
                      agricultureHortocultureState.setState(() {
                        agricultureHortocultureState.materielsNom =
                            value.get('nom')!;
                        agricultureHortocultureState.materielsCode =
                            value.get('code')!;
                      });
                    });
                    FirebaseFirestore.instance
                        .collection("materiels-champs")
                        .add({
                      "materiel": agricultureHortocultureState.materiels,
                      "materielNom": agricultureHortocultureState.materielsNom,
                      "materielCode":
                          agricultureHortocultureState.materielsCode,
                      "champs": idChamps,
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
