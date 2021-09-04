import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-menage.dart';

adminMenage({
  required BuildContext context,
}) async {
  Size size = MediaQuery.of(context).size;
  await FirebaseFirestore.instance
      .collection("pays")
      .doc(administrationFoncierState.paysSelected)
      .collection("regions")
      .doc(administrationFoncierState.regionSlected)
      .collection("departements")
      .doc(administrationFoncierState.departementSelected)
      .collection("communes")
      .doc(administrationFoncierState.communeSelected)
      .collection("villages")
      .doc(administrationFoncierState.villageSelected)
      .collection("concessions")
      .get()
      .then((value) {
    // print(value.docs.length);
    if (value.docs.length > 0) {
      administrationFoncierState.setState(() {
        administrationFoncierState.concessionSelected = value.docs.first.id;
      });
    } else {
      administrationFoncierState.setState(() {
        administrationFoncierState.concessionSelected = '';
      });
    }
  });
  showDialog(
      context: context,
      builder: (context) => StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("pays")
              .doc(administrationFoncierState.paysSelected)
              .collection("regions")
              .doc(administrationFoncierState.regionSlected)
              .collection("departements")
              .doc(administrationFoncierState.departementSelected)
              .collection("communes")
              .doc(administrationFoncierState.communeSelected)
              .collection("villages")
              .doc(administrationFoncierState.villageSelected)
              .collection("concessions")
              .snapshots(),
          builder: (context, snapshot) => !snapshot.hasData
              ? Container(
                  height: size.height * .3,
                  width: size.width * .6,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : AlertDialog(
                  content: StatefulBuilder(
                    builder: (context, setState) => Container(
                      height: size.height * .9,
                      width: size.width * .7,
                      child: Column(
                        children: [
                          Container(
                            height: size.height * .04,
                            width: size.width * .7,
                            child: Row(
                              children: [
                                Text('Gestions des Ménages'),
                                Spacer(),
                                Container(
                                  // width: size.width * .15,
                                  child: DropdownButton<String>(
                                      value: administrationFoncierState
                                          .concessionSelected,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          administrationFoncierState
                                              .setState(() {
                                            administrationFoncierState
                                                .concessionSelected = newValue!;
                                          });
                                        });
                                      },
                                      items: snapshot.data!.docs
                                          .map((e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Text(
                                                  "${e.get("code")}-${e.get("nom")}")))
                                          .toList()),
                                  decoration: BoxDecoration(),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => addMenage(
                                      context: context,
                                      idPays: administrationFoncierState
                                          .paysSelected,
                                      idRegion: administrationFoncierState
                                          .regionSlected,
                                      idDepartement: administrationFoncierState
                                          .departementSelected,
                                      idCommune: administrationFoncierState
                                          .communeSelected,
                                      idVillage: administrationFoncierState
                                          .villageSelected,
                                      idConcession: administrationFoncierState
                                          .concessionSelected),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: vert,
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                            child: Text(
                                          '   Ajouter un ménage   ',
                                          style: TextStyle(color: blanc),
                                        )),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                )));
}
