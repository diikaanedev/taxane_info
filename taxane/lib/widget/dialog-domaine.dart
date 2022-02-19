import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

addDomaine({required BuildContext context, required String idVillage}) {
  Size size = MediaQuery.of(context).size;

  return showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController surface = TextEditingController();
        TextEditingController longitude = TextEditingController();
        TextEditingController latitude = TextEditingController();
        TextEditingController titre = TextEditingController();
        TextEditingController usage = TextEditingController();
        TextEditingController cni = TextEditingController();
        TextEditingController nom = TextEditingController();
        TextEditingController prenom = TextEditingController();
        return AlertDialog(
          content: Container(
            height: size.height * .9,
            width: size.width * .7,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "Formulaire d'ajout de domaine",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: size.height * .05,
                            width: size.width * .4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: TextField(
                                cursorColor: vert,
                                controller: code,
                                decoration: InputDecoration(
                                    labelText: "Code du domaine",
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
                                    labelText: "Surface du domaine en m²",
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
                                controller: latitude,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Latitude du domaine",
                                    icon: Icon(CupertinoIcons.location)),
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
                                    border: InputBorder.none,
                                    labelText: "Longitude du domaine",
                                    icon: Icon(CupertinoIcons.location)),
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
                                controller: titre,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Titre du domaine",
                                    icon: Icon(CupertinoIcons.location)),
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
                                controller: usage,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Usage du domaine",
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
                                controller: cni,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "CNI du propriétaire du domaine",
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
                                controller: nom,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "nom du propriétaire du domaine",
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
                                controller: prenom,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText:
                                        "prenom du propriétaire du domaine",
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
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("domaines")
                                  .add({
                                "code": code.text,
                                "surface": surface.text,
                                "titre": titre.text,
                                "usage": usage.text,
                                "cni": cni.text,
                                "nom": nom.text,
                                "prenom": prenom.text,
                                "villages": idVillage,
                                "geoPoint": GeoPoint(
                                    double.parse(latitude.text),
                                    double.parse(longitude.text)),
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
                                      color: jaune,
                                      fontWeight: FontWeight.bold),
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
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      });
}

editDomaine(
    {required BuildContext context,
    required String idVillage,
    required String idDomaine}) {
  Size size = MediaQuery.of(context).size;

  return showDialog(
      context: context,
      builder: (context) {
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("domaines")
                .doc(idDomaine)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("");
              } else {
                print(snapshot.data!.get("geoPoint").latitude);
                TextEditingController code =
                    TextEditingController(text: snapshot.data!.get("code"));
                TextEditingController surface =
                    TextEditingController(text: snapshot.data!.get("surface"));
                TextEditingController longitude = TextEditingController(
                    text: snapshot.data!.get("geoPoint").longitude.toString());
                TextEditingController latitude = TextEditingController(
                    text: snapshot.data!.get("geoPoint").latitude.toString());
                TextEditingController titre =
                    TextEditingController(text: snapshot.data!.get("titre"));
                TextEditingController usage =
                    TextEditingController(text: snapshot.data!.get("usage"));
                TextEditingController cni =
                    TextEditingController(text: snapshot.data!.get("cni"));
                TextEditingController nom =
                    TextEditingController(text: snapshot.data!.get("nom"));
                TextEditingController prenom =
                    TextEditingController(text: snapshot.data!.get("prenom"));
                return AlertDialog(
                  content: Container(
                    height: size.height * .9,
                    width: size.width * .7,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "Formulaire d'édition de domaine",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: size.height * .05,
                                    width: size.width * .4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: TextField(
                                        cursorColor: vert,
                                        controller: code,
                                        decoration: InputDecoration(
                                            labelText: "Code du domaine",
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
                                            labelText:
                                                "Surface du domaine en m²",
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
                                        controller: latitude,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "Latitude du domaine",
                                            icon:
                                                Icon(CupertinoIcons.location)),
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
                                            border: InputBorder.none,
                                            labelText: "Longitude du domaine",
                                            icon:
                                                Icon(CupertinoIcons.location)),
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
                                        controller: titre,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "Titre du domaine",
                                            icon:
                                                Icon(CupertinoIcons.location)),
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
                                        controller: usage,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "Usage du domaine",
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
                                        controller: cni,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText:
                                                "CNI du propriétaire du domaine",
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
                                        controller: nom,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText:
                                                "nom du propriétaire du domaine",
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
                                        controller: prenom,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText:
                                                "prenom du propriétaire du domaine",
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
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("domaines")
                                          .doc(idDomaine)
                                          .update({
                                        "code": code.text,
                                        "surface": surface.text,
                                        "titre": titre.text,
                                        "usage": usage.text,
                                        "cni": cni.text,
                                        "nom": nom.text,
                                        "prenom": prenom.text,
                                        "villages": idVillage,
                                        "geoPoint": GeoPoint(
                                            double.parse(latitude.text),
                                            double.parse(longitude.text)),
                                        "date": DateTime.now()
                                      }).then((value) =>
                                              Navigator.pop(context));
                                    },
                                    child: Container(
                                      height: size.height * .05,
                                      width: size.width * .2,
                                      child: Center(
                                        child: Text(
                                          'Modifier',
                                          style: TextStyle(
                                              color: jaune,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: jaune),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              }
            });
      });
}

deleteDomaine(
    {required BuildContext context,
    required String idVillage,
    required String idDomaine}) {
  Size size = MediaQuery.of(context).size;

  return showDialog(
      context: context,
      builder: (context) {
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("domaines")
                .doc(idDomaine)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("");
              } else {
                return AlertDialog(
                  content: Container(
                    height: size.height * .3,
                    width: size.width * .3,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height * .05,
                                  ),
                                  Text(
                                    "Supréssion de ce domaine",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.height * .05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("domaines")
                                          .doc(idDomaine)
                                          .delete()
                                          .then((value) =>
                                              Navigator.pop(context));
                                    },
                                    child: Container(
                                      height: size.height * .05,
                                      width: size.width * .2,
                                      child: Center(
                                        child: Text(
                                          'Suprimmer',
                                          style: TextStyle(
                                              color: rouge,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: rouge),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              }
            });
      });
}
