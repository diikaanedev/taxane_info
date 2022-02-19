import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';

dialogAddConcession(
    {required BuildContext context, required String idVillage}) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
        TextEditingController nombreCase = TextEditingController();
        TextEditingController nomP = TextEditingController();
        TextEditingController prenomP = TextEditingController();
        TextEditingController eau = TextEditingController();
        TextEditingController energie = TextEditingController();
        return AlertDialog(
          title: Container(
            width: size.width * .5,
            child: Row(
              children: [
                Spacer(),
                Text('Gestion des Concessions/Vilas '),
                Spacer(),
              ],
            ),
          ),
          content: Container(
            height: size.height * .8,
            width: size.width * .5,
            // color: vert,
            child: Column(
              children: [
                Spacer(),
                Container(
                  height: size.height * .07,
                  child: Center(
                    child: Text(
                      'Formulaire d\'ajout de concession/village',
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
                          labelText: "Code Concession",
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
                      controller: nom,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Nom Concession",
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
                      controller: nomP,
                      decoration: InputDecoration(
                          labelText: "Nom Propriétaire Concession",
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
                      controller: prenomP,
                      decoration: InputDecoration(
                          labelText: "Prénom Propriétaire Concession",
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
                      controller: nombreCase,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "nombre de Case/Appartements",
                          border: InputBorder.none,
                          icon: Icon(CupertinoIcons.building_2_fill)),
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text('Aprovisionnement en Eau / '),
                          StatefulBuilder(
                            builder: (context, setState) =>
                                DropdownButton<String>(
                                    value: administrationFoncierState.eau,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState.eau =
                                              newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "robinet",
                                      "fontaine",
                                      "lac",
                                      "puits",
                                      "pas eau"
                                    ]
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toUpperCase())))
                                        .toList()),
                          ),
                        ],
                      )),
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text('Source en energie / '),
                        SizedBox(
                          width: 8,
                        ),
                        StatefulBuilder(
                          builder: (context, setState) =>
                              DropdownButton<String>(
                                  value: administrationFoncierState.energie,
                                  underline: Container(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      administrationFoncierState.setState(() {
                                        administrationFoncierState.energie =
                                            newValue!;
                                      });
                                    });
                                  },
                                  items: [
                                    "electricite",
                                    "solaire",
                                    "héoleinne",
                                    "pas energie"
                                  ]
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.toUpperCase())))
                                      .toList()),
                        ),
                      ],
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
                    FirebaseFirestore.instance.collection("concessions").add({
                      "code": code.text,
                      "nom": nom.text,
                      "eau": administrationFoncierState.eau,
                      "villages": idVillage,
                      "energie": administrationFoncierState.energie,
                      "nomP": nomP.text,
                      "prenomP": prenomP.text,
                      "nombre": nombreCase.text,
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
      });
}

dialogEditoncession(
    {required BuildContext context,
    required String idVillage,
    required String idConcession}) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;

        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("concessions")
                .doc(idConcession)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                TextEditingController code =
                    TextEditingController(text: snapshot.data!.get("code"));
                TextEditingController nom =
                    TextEditingController(text: snapshot.data!.get("nom"));
                TextEditingController nombreCase = TextEditingController(
                    text: snapshot.data!.get("nombre").toString());
                TextEditingController nomP =
                    TextEditingController(text: snapshot.data!.get("nomP"));
                TextEditingController prenomP =
                    TextEditingController(text: snapshot.data!.get("prenomP"));
                TextEditingController eau = TextEditingController();
                TextEditingController energie = TextEditingController();
                return AlertDialog(
                  title: Container(
                    width: size.width * .5,
                    child: Row(
                      children: [
                        Spacer(),
                        Text('Gestion des Concessions/Vilas'),
                        Spacer(),
                      ],
                    ),
                  ),
                  content: Container(
                    height: size.height * .8,
                    width: size.width * .5,
                    // color: vert,
                    child: Column(
                      children: [
                        Spacer(),
                        Container(
                          height: size.height * .07,
                          child: Center(
                            child: Text(
                              'Formulaire d\'édition de concession/village',
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
                                  labelText: "Code Concession",
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
                              controller: nom,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Nom Concession",
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
                              controller: nomP,
                              decoration: InputDecoration(
                                  labelText: "Nom Propriétaire Concession",
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
                              controller: prenomP,
                              decoration: InputDecoration(
                                  labelText: "Prénom Propriétaire Concession",
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
                              controller: nombreCase,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "nombre de Case/Appartements",
                                  border: InputBorder.none,
                                  icon: Icon(CupertinoIcons.building_2_fill)),
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
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Aprovisionnement en Eau / '),
                                  StatefulBuilder(builder: (context, setState) {
                                    //  setState(() {
                                    //         administrationFoncierState
                                    //             .setState(() {
                                    //           administrationFoncierState.eau =
                                    //               snapshot.data!.get("eau");
                                    //         });
                                    //       });
                                    return DropdownButton<String>(
                                        value: snapshot.data!.get("eau"),
                                        underline: Container(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            administrationFoncierState
                                                .setState(() {
                                              administrationFoncierState.eau =
                                                  newValue!;
                                            });
                                          });
                                        },
                                        items: [
                                          "robinet",
                                          "fontaine",
                                          "lac",
                                          "puits",
                                          "pas eau"
                                        ]
                                            .map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e.toUpperCase())))
                                            .toList());
                                  }),
                                ],
                              )),
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
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Source en energie / '),
                                SizedBox(
                                  width: 8,
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) =>
                                      DropdownButton<String>(
                                          value: snapshot.data!.get("energie"),
                                          underline: Container(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              administrationFoncierState
                                                  .setState(() {
                                                administrationFoncierState
                                                    .energie = newValue!;
                                              });
                                            });
                                          },
                                          items: [
                                            "electricite",
                                            "solaire",
                                            "héoleinne",
                                            "pas energie"
                                          ]
                                              .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e.toUpperCase())))
                                              .toList()),
                                ),
                              ],
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
                                .collection("concessions")
                                .doc(idConcession)
                                .update({
                              "code": code.text,
                              "nom": nom.text,
                              "eau": administrationFoncierState.eau,
                              "villages": idVillage,
                              "energie": administrationFoncierState.energie,
                              "nomP": nomP.text,
                              "prenomP": prenomP.text,
                              "nombre": nombreCase.text,
                              "date": DateTime.now()
                            }).then((value) => Navigator.pop(context));
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .2,
                            child: Center(
                              child: Text(
                                'Modifierr',
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

dialogDeleteoncession(
    {required BuildContext context,
    required String idVillage,
    required String idConcession}) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;

        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("concessions")
                .doc(idConcession)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                return AlertDialog(
                  title: Container(
                    width: size.width * .5,
                    child: Row(
                      children: [
                        Spacer(),
                        Text('Gestion des Concessions/Vilas'),
                        Spacer(),
                      ],
                    ),
                  ),
                  content: Container(
                    height: size.height * .3,
                    width: size.width * .4,
                    // color: vert,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Container(
                          height: size.height * .07,
                          child: Center(
                            child: Text(
                              'Suprimer cette concession/village',
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
                        GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("concessions")
                                .doc(idConcession)
                                .delete()
                                .then((value) => Navigator.pop(context));
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .2,
                            child: Center(
                              child: Text(
                                'Suprimer',
                                style: TextStyle(
                                    color: rouge, fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: rouge),
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
