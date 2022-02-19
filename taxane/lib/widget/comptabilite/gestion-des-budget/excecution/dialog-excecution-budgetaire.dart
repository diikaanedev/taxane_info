import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/comptabilite.dart';
import 'package:taxane/utils/color-by-dii.dart';

addExcecutionBudgetaire(
    {required BuildContext context, required String idOperation}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController code = TextEditingController();
        TextEditingController nom = TextEditingController();
        TextEditingController description = TextEditingController();
        TextEditingController cout_total = TextEditingController();
        return AlertDialog(
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
              height: size.height * .8,
              width: size.width * .5,
              child: ListView(
                children: [
                  Spacer(),
                  Container(
                    height: size.height * .1,
                    child: Center(
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("budgets")
                              .doc(idOperation)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? Text('')
                                : Text(
                                    'Excecution du budget ${snapshot.data!.get("nom")}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: noir,
                                        fontSize: size.height * .03,
                                        fontWeight: FontWeight.bold),
                                  );
                          }),
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
                            Icon(Icons.explicit_rounded),
                            SizedBox(
                              width: 4,
                            ),
                            DropdownButton<String>(
                                value: comptabiliteState.choixExecution,
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    comptabiliteState.setState(() {
                                      comptabiliteState.choixExecution =
                                          newValue!;
                                    });
                                  });
                                },
                                items: [
                                  "debit",
                                  "credit",
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
                        controller: code,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Code',
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
                            labelText: 'Nom',
                            icon: Icon(CupertinoIcons.map)),
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
                        controller: description,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Description',
                            icon: Icon(CupertinoIcons.map)),
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
                        controller: cout_total,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'cout total',
                            icon: Icon(CupertinoIcons.map)),
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
                                    width: size.width * .3,
                                    child: Text(
                                        '  Date Execution : ${comptabiliteState.date.day.toString()}/${comptabiliteState.date.month.toString()}/${comptabiliteState.date.year.toString()}')),
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
                  GestureDetector(
                    onTap: () async {
                      String cout = await FirebaseFirestore.instance
                          .collection("budgets")
                          .doc(idOperation)
                          .get()
                          .then((value) => value.get("coutTotal"));
                      int coutT = int.parse(cout);

                      if (coutT > int.parse(cout_total.text)) {
                        FirebaseFirestore.instance
                            .collection("excecution-budgetaire")
                            .add({
                          "nom": nom.text,
                          "code": code.text,
                          "description": description.text,
                          "choix-Excecution": comptabiliteState.choixExecution,
                          "date-Excecution": comptabiliteState.date,
                          "cout-total": int.parse(cout_total.text),
                          "opperationID" : idOperation,
                          "date": DateTime.now()
                        }).then((value) async {
                          await FirebaseFirestore.instance.collection("budgets").doc(idOperation).update(
                            {
                              "coutTotal" : comptabiliteState.choixExecution == "debit" ?  (coutT - int.parse(cout_total.text)).toString() : (coutT  + int.parse(cout_total.text)).toString()
                            }
                          );
                        });
                        Navigator.pop(context);
                      }
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
            );
          }),
          actions: [
            // ignore: deprecated_member_use
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
