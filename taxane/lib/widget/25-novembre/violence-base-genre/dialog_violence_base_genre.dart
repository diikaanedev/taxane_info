import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/25_novembre.dart';
import 'package:taxane/utils/color-by-dii.dart';

addOperationViolenceBaseGenre(
    {required BuildContext context, required String idVillage}) {
  Size size = MediaQuery.of(context).size;
  TextEditingController code = new TextEditingController();
  TextEditingController nomAuteur = new TextEditingController();
  TextEditingController nomVictime = new TextEditingController();
  TextEditingController faits = new TextEditingController();
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              height: size.height * .9,
              width: size.width * .7,
              color: blanc,
              child: StatefulBuilder(builder: (context, setState) {
                return LayoutBuilder(builder: (context, constrainst) {
                  return ListView(
                    children: [
                      Text(
                        'Formulaire d\' ajout d\'une opération de violence basée sur le genre ',
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
                                labelText: 'Code',
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: nomVictime,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Nom complet victime',
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: nomAuteur,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Nom complet auteur',
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
                                            '  Date : ${vingtCinqNovembreState.dateDesFaits.day.toString()}/${vingtCinqNovembreState.dateDesFaits.month.toString()}/${vingtCinqNovembreState.dateDesFaits.year.toString()}')),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  await showDatePicker(
                                          context: context,
                                          initialDate: vingtCinqNovembreState
                                              .dateDesFaits,
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2030))
                                      .then((value) => setState(() {
                                            vingtCinqNovembreState
                                                .dateDesFaits = value!;
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
                        height: size.height * .04,
                        width: size.width * .4,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(Icons.cloud),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Dégats / '),
                                DropdownButton<String>(
                                    value: vingtCinqNovembreState.degats,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        vingtCinqNovembreState.setState(() {
                                          vingtCinqNovembreState.degats =
                                              newValue!;
                                        });
                                      });
                                    },
                                    items: ["blessure", "mort", "autres"]
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
                        height: size.height * .04,
                        width: size.width * .4,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(Icons.code),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Décision Judiciare / '),
                                DropdownButton<String>(
                                    value: vingtCinqNovembreState
                                        .decisionJudiciaire,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        vingtCinqNovembreState.setState(() {
                                          vingtCinqNovembreState
                                              .decisionJudiciaire = newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "ammende",
                                      "emprisonnement",
                                      "autres"
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
                        height: size.height * .04,
                        width: size.width * .4,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(Icons.cleaning_services),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Liens / '),
                                DropdownButton<String>(
                                    value: vingtCinqNovembreState.liens,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        vingtCinqNovembreState.setState(() {
                                          vingtCinqNovembreState.liens =
                                              newValue!;
                                        });
                                      });
                                    },
                                    items: ["domestique", "parente", "autres"]
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
                        height: size.height * .15,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: faits,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Description des faits',
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
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            FirebaseFirestore.instance
                                .collection("violence-basee-sur-le-genre")
                                .add({
                              "auteurNomComplet": nomAuteur.text,
                              "code": code.text,
                              "date": DateTime.now(),
                              "dateDesFaits":
                                  vingtCinqNovembreState.dateDesFaits,
                              "decisionJudicaire":
                                  vingtCinqNovembreState.decisionJudiciaire,
                              "degats": vingtCinqNovembreState.degats,
                              "faits": faits.text,
                              "liens": vingtCinqNovembreState.liens,
                              "victimeNomComplet": nomVictime.text,
                              "village": idVillage,
                            }).then((value) => Navigator.pop(context));
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: vert),
                            child: Center(
                              child: Text(
                                '     Valider   ',
                                style: TextStyle(color: blanc),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                });
              }),
            ),
          ));
}
