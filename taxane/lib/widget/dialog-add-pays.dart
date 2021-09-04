import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

dialogAddPays({
  required BuildContext context,
}) {
  TextEditingController code = TextEditingController();
  TextEditingController nom = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Container(
            width: size.width * .5,
            child: Row(
              children: [
                Spacer(),
                Text('Gestion des Pays '),
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
                      'Formulaire d\' ajout d\'un pays',
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
                    FirebaseFirestore.instance.collection('pays').add({
                      "nom": nom.text,
                      "code": code.text,
                      "date": DateTime.now()
                    }).then((value) {
                      value.collection("regions");
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

dialogEditPays({required BuildContext context, required String id}) {
  DocumentReference doc = FirebaseFirestore.instance.collection('pays').doc(id);
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return StreamBuilder<DocumentSnapshot>(
            stream: doc.get().asStream(),
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
                        Text('Gestion des Pays '),
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
                              'Formulaire de Modification d\'un pays',
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
                                  hintText: snapshot.data!.get('nom'),
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
                                .doc(id)
                                .update({
                              "nom": nom.text,
                              "code": code.text,
                              "regions": [],
                              "date": DateTime.now()
                            });
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

dialogDeletePays({required BuildContext context, required String id}) {
  DocumentReference doc = FirebaseFirestore.instance.collection('pays').doc(id);
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return StreamBuilder<DocumentSnapshot>(
            stream: doc.get().asStream(),
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
                    width: size.width * .3,
                    child: Row(
                      children: [
                        Spacer(),
                        Text('Gestion des Pays '),
                        Spacer(),
                      ],
                    ),
                  ),
                  content: Container(
                    height: size.height * .3,
                    width: size.width * .3,
                    // color: vert,
                    child: Column(
                      children: [
                        Spacer(),
                        Container(
                          height: size.height * .1,
                          child: Center(
                            child: Text(
                              'Voullez-vous réellement le suprimez',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: noir,
                                  fontSize: size.height * .03,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('pays')
                                .doc(id)
                                .delete()
                                .then((value) => Navigator.pop(context));
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .2,
                            child: Center(
                              child: Text(
                                'Suprimmer',
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
