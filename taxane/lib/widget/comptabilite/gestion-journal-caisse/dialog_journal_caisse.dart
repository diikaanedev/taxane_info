import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/comptabilite.dart';
import 'package:taxane/utils/color-by-dii.dart';

addOperationCaisseJournal(
    {required BuildContext context, required String idRegroupement}) {
  Size size = MediaQuery.of(context).size;
  TextEditingController code = new TextEditingController();
  TextEditingController montant = new TextEditingController();
  TextEditingController details = new TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: StatefulBuilder(
        builder: (context, setState) => Container(
          height: size.height * .7,
          width: size.width * .7,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Text(
                'Formulaire d\' ajout d\'une oppération de caisse',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: noir,
                    fontSize: size.height * .03,
                    fontWeight: FontWeight.bold),
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
                        labelText: 'Numéro de Référence',
                        icon: Icon(CupertinoIcons.waveform_circle)),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: vert),
                    borderRadius: BorderRadius.circular(8)),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              StatefulBuilder(
                builder: (context, setState) => Container(
                  height: size.height * .05,
                  width: size.width * .4,
                  decoration: BoxDecoration(
                      border: Border.all(color: vert),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                                width: size.width * .4,
                                child: Text(
                                    '  Date : ${comptabiliteState.date.day.toString()}/${comptabiliteState.date.month.toString()}/${comptabiliteState.date.year.toString()}')),
                            Spacer(),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await showDatePicker(
                                  context: context,
                                  initialDate: comptabiliteState.date,
                                  initialDatePickerMode: DatePickerMode.day,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030))
                              .then((value) => setState(() {
                                    comptabiliteState.date = value!;
                                  }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                              color: rouge),
                          child: Center(
                            child: Text(
                              "    Choisir Votre date     ",
                              style: TextStyle(color: blanc),
                            ),
                          ),
                        ),
                      )
                    ],
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
                    controller: details,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Détails transaction',
                        icon: Icon(CupertinoIcons.command)),
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
                height: size.height * .04,
                width: size.width * .4,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.outbox_sharp,
                          color: gris,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Solde Entrées ou Sorties /   '),
                        DropdownButton<String>(
                            value: comptabiliteState.typeEntresSortie,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                comptabiliteState.setState(() {
                                  comptabiliteState.typeEntresSortie =
                                      newValue!;
                                });
                              });
                            },
                            items: [
                              "entrees",
                              "sorties",
                            ]
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(e.toUpperCase())))
                                .toList()),
                      ],
                    )),
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
                    controller: montant,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Montant transaction',
                        icon: Icon(CupertinoIcons.money_rubl_circle)),
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
                  FirebaseFirestore.instance.collection("journalCaisse").add({
                    "dateOperation": comptabiliteState.date,
                    "numeroReference": code.text,
                    "montant": montant.text,
                    "soldeEntre": comptabiliteState.typeEntresSortie,
                    "idRegroupement" : idRegroupement,
                    "detailTransaction": details.text
                  }).then((value) {
                    FirebaseFirestore.instance
                        .collection("caisse")
                        .doc(idRegroupement)
                        .get()
                        .then((caisse) {
                      FirebaseFirestore.instance
                          .collection("caisse")
                          .doc(idRegroupement)
                          .update({
                        "montantPrecedant":
                            comptabiliteState.typeEntresSortie == "entrees"
                                ? caisse.get("montantPrecedant") +
                                    int.parse(montant.text)
                                : caisse.get("montantPrecedant") -
                                    int.parse(montant.text)
                      }).then((value) => print("complete"));
                    });
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: size.height * .05,
                  width: size.width * .5,
                  child: Center(
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
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

editOperationCaisseJournal(
    {required BuildContext context,
    required String idRegroupement,
    required String idOperationCaisseJournal}) {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("journalCaisse")
            .doc(idOperationCaisseJournal)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            TextEditingController code = new TextEditingController(
                text: snapshot.data!.get("numeroReference"));
            TextEditingController montant =
                new TextEditingController(text: snapshot.data!.get("montant"));
            TextEditingController details = new TextEditingController(
                text: snapshot.data!.get("detailTransaction"));
            Timestamp timestampF = snapshot.data!.get('dateOperation');
            DateTime date = new DateTime.fromMicrosecondsSinceEpoch(
                timestampF.millisecondsSinceEpoch * 1000);
            return AlertDialog(
              content: StatefulBuilder(
                builder: (context, setState) {
                  setState(() {
                    comptabiliteState.date = date;
                    comptabiliteState.typeEntresSortie =
                        snapshot.data!.get('soldeEntre');
                  });
                  return Container(
                    height: size.height * .7,
                    width: size.width * .7,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Text(
                          'Formulaire d\' édition d\'une oppération de caisse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: noir,
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold),
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
                                  labelText: 'Numéro de Référence',
                                  icon: Icon(CupertinoIcons.waveform_circle)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        StatefulBuilder(
                          builder: (context, setState) => Container(
                            height: size.height * .05,
                            width: size.width * .4,
                            decoration: BoxDecoration(
                                border: Border.all(color: vert),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                          width: size.width * .4,
                                          child: Text(
                                              '  Date : ${comptabiliteState.date.day.toString()}/${comptabiliteState.date.month.toString()}/${comptabiliteState.date.year.toString()}')),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    await showDatePicker(
                                            context: context,
                                            initialDate: comptabiliteState.date,
                                            initialDatePickerMode:
                                                DatePickerMode.day,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2030))
                                        .then((value) => setState(() {
                                              comptabiliteState.date = value!;
                                            }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(4),
                                          bottomRight: Radius.circular(4),
                                        ),
                                        color: rouge),
                                    child: Center(
                                      child: Text(
                                        "    Choisir Votre date     ",
                                        style: TextStyle(color: blanc),
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                              controller: details,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Détails transaction',
                                  icon: Icon(CupertinoIcons.command)),
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
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.outbox_sharp,
                                    color: gris,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text('Solde Entrées ou Sorties /   '),
                                  DropdownButton<String>(
                                      value: comptabiliteState.typeEntresSortie,
                                      underline: Container(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          comptabiliteState.setState(() {
                                            comptabiliteState.typeEntresSortie =
                                                newValue!;
                                          });
                                        });
                                      },
                                      items: [
                                        "entrees",
                                        "sorties",
                                      ]
                                          .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.toUpperCase())))
                                          .toList()),
                                ],
                              )),
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
                              controller: montant,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Montant transaction',
                                  icon: Icon(CupertinoIcons.money_rubl_circle)),
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
                                .collection("journalCaisse")
                                .doc(idOperationCaisseJournal)
                                .update({
                              "dateOperation": comptabiliteState.date,
                              "numeroReference": code.text,
                              "montant": montant.text,
                              "soldeEntre": comptabiliteState.typeEntresSortie,
                              "detailTransaction": details.text
                            }).then((value) {
                              FirebaseFirestore.instance
                                  .collection("caisse")
                                  .doc(idRegroupement)
                                  .get()
                                  .then((caisse) {
                                FirebaseFirestore.instance
                                    .collection("caisse")
                                    .doc(idRegroupement)
                                    .update({
                                  "montantPrecedant":
                                      comptabiliteState.typeEntresSortie ==
                                              "entrees"
                                          ? caisse.get("montantPrecedant") +
                                              int.parse(montant.text)
                                          : caisse.get("montantPrecedant") -
                                              int.parse(montant.text)
                                }).then((value) => print("complete"));
                              });
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .5,
                            child: Center(
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
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        }),
  );
}

deleteOperationCaisseJournal(
    {required BuildContext context,
    required String idRegroupement,
    required String idOperationCaisseJournal}) {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("journalCaisse")
            .doc(idOperationCaisseJournal)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            return AlertDialog(
              content: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    height: size.height * .2,
                    width: size.width * .3,
                    child: Column(
                      children: [
                        Text(
                          'Suprimer cette  oppération de caisse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: noir,
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        GestureDetector(
                          onTap: () async {
                            FirebaseFirestore.instance
                                .collection("journalCaisse")
                                .doc(idOperationCaisseJournal)
                                .delete()
                                .then((value) {
                              FirebaseFirestore.instance
                                  .collection("caisse")
                                  .doc(idRegroupement)
                                  .get()
                                  .then((caisse) {
                                FirebaseFirestore.instance
                                    .collection("caisse")
                                    .doc(idRegroupement)
                                    .update({
                                  "montantPrecedant":
                                      snapshot.data!.get("soldeEntre") ==
                                              "entrees"
                                          ? caisse.get("montantPrecedant") +
                                              int.parse(
                                                  snapshot.data!.get("montant"))
                                          : caisse.get("montantPrecedant") -
                                              int.parse(
                                                  snapshot.data!.get("montant"))
                                }).then((value) => print("complete"));
                              });
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: size.height * .05,
                            width: size.width * .5,
                            child: Center(
                              child: Container(
                                height: size.height * .05,
                                width: size.width * .2,
                                child: Center(
                                  child: Text(
                                    'Suprimer',
                                    style: TextStyle(
                                        color: rouge,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: rouge),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        }),
  );
}
