import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

dialogAddRegion({required BuildContext context, required String id}) {
  TextEditingController code = TextEditingController();
  TextEditingController nom = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("pays")
            .doc(id)
            .get()
            .asStream(),
        builder: (context, snapshot) {
          Size size = MediaQuery.of(context).size;
          if (!snapshot.hasData) {
            return Container();
          } else {
            return AlertDialog(
              title: Container(
                width: size.width * .5,
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                        'Ajouter une région sur ${snapshot.data!.get('nom')} '),
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
                          'Formulaire d\' ajout de région',
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
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection("pays")
                            .doc(id)
                            .get()
                            .then((value) => FirebaseFirestore.instance
                                    
                                    .collection("regions")
                                    .add({
                                  "code": code.text,
                                  "nom": nom.text,
                                  "pays" : id,
                                  "date": DateTime.now(),
                                }))
                            .then((value) {
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
          }
        }),
  );
}

dialogEditRegion(
    {required BuildContext context,
    required String id,
    required String idRegion}) {
  return showDialog(
    context: context,
    builder: (context) => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
             .collection("regions")
            .doc(idRegion)
            .snapshots(),
        builder: (context, snapshot) {
          Size size = MediaQuery.of(context).size;

          if (!snapshot.hasData) {
            return Container();
          } else {
            // List regions = snapshot.data!.get('regions') as List;

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
                    Text("Modifier la région ${snapshot.data!.get('nom')}"),
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
                          'Formulaire de modification de région',
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
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection("regions")
                            .doc(idRegion)
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
        }),
  );
}

dialogDeleteRegion(
    {required BuildContext context,
    required String id,
    required String idRegion}) {
  return showDialog(
    context: context,
    builder: (context) => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("regions")
            .doc(idRegion)
            .snapshots(),
        builder: (context, snapshot) {
          Size size = MediaQuery.of(context).size;

          if (!snapshot.hasData) {
            return Container();
          } else {
            return AlertDialog(
              title: Container(
                width: size.width * .3,
                child: Row(
                  children: [
                    Spacer(),
                    Text('Suprimer la région ${snapshot.data!.get('nom')}'),
                    Spacer(),
                  ],
                ),
              ),
              content: Container(
                height: size.height * .2,
                width: size.width * .3,
                // color: vert,
                child: Column(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        FirebaseFirestore.instance
                           .collection("regions")
                            .doc(idRegion)
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
                                color: jaune, fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: jaune),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }
        }),
  );
}
