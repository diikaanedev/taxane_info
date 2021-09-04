import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

addMenage(
    {required BuildContext context,
    required String idConcession,
    required String idPays,
    required String idRegion,
    required String idDepartement,
    required String idCommune,
    required String idVillage}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (context) => StreamBuilder<Object>(
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
            .collection("concessions")
            .doc(idConcession)
            .snapshots(),
        builder: (context, snapshot) => !snapshot.hasData
            ? Container(
                height: size.height,
                width: size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  content: Container(
                    height: size.height * .9,
                    width: size.width * .7,
                  ),
                ),
              )),
  );
}
