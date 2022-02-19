import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';

addMembreGestionMembre(
    {required BuildContext context, required String idRegroupement}) {
  Size size = MediaQuery.of(context).size;
  TextEditingController matricule = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController cni = new TextEditingController();
  TextEditingController prenomPere = new TextEditingController();
  TextEditingController nomMere = new TextEditingController();
  TextEditingController prenomMere = new TextEditingController();
  TextEditingController dateNaiss = new TextEditingController();
  TextEditingController lieuxNaiss = new TextEditingController();
  TextEditingController fonction = new TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: StatefulBuilder(
        builder: (context, setState) => Container(
          height: size.height * .7,
          width: size.width * .5,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Text(
                'Formulaire d\' ajout d\'un membre',
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
                height: size.height * .04,
                width: size.width * .4,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(administrationFoncierState.sexe == "homme"
                            ? Icons.male
                            : Icons.female),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Sexe / '),
                        DropdownButton<String>(
                            value: administrationFoncierState.sexe,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                administrationFoncierState.setState(() {
                                  administrationFoncierState.sexe = newValue!;
                                });
                              });
                            },
                            items: [
                              "homme",
                              "femme",
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
                    controller: matricule,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Matricule',
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
                    controller: nom,
                    decoration: InputDecoration(
                        labelText: 'Nom Membre',
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
                    controller: prenom,
                    decoration: InputDecoration(
                        labelText: 'Prenom Membre',
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
                    controller: fonction,
                    decoration: InputDecoration(
                        labelText: 'Fonction Membre',
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
                    controller: cni,
                    decoration: InputDecoration(
                        labelText: 'CNI',
                        border: InputBorder.none,
                        icon: Icon(CupertinoIcons.globe)),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: vert),
                    borderRadius: BorderRadius.circular(8)),
              ),
              // SizedBox(
              //   height: size.height * .05,
              // ), // SizedBox(
              //   height: size.height * .05,
              // ),
              // Container(
              //   height: size.height * .05,
              //   width: size.width * .4,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 8),
              //     child: TextField(
              //       cursorColor: vert,
              //       controller: prenomPere,
              //       decoration: InputDecoration(
              //           labelText: 'Prenom Père',
              //           border: InputBorder.none,
              //           icon: Icon(CupertinoIcons.globe)),
              //     ),
              //   ),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: vert),
              //       borderRadius: BorderRadius.circular(8)),
              // ),
              // SizedBox(
              //   height: size.height * .05,
              // ),
              // Container(
              //   height: size.height * .05,
              //   width: size.width * .4,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 8),
              //     child: TextField(
              //       cursorColor: vert,
              //       controller: nomMere,
              //       decoration: InputDecoration(
              //           labelText: 'Nom Mère',
              //           border: InputBorder.none,
              //           icon: Icon(CupertinoIcons.globe)),
              //     ),
              //   ),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: vert),
              //       borderRadius: BorderRadius.circular(8)),
              // ),
              // SizedBox(
              //   height: size.height * .05,
              // ),
              // Container(
              //   height: size.height * .05,
              //   width: size.width * .4,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 8),
              //     child: TextField(
              //       cursorColor: vert,
              //       controller: prenomMere,
              //       decoration: InputDecoration(
              //           labelText: 'Prenom Mère',
              //           border: InputBorder.none,
              //           icon: Icon(CupertinoIcons.globe)),
              //     ),
              //   ),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: vert),
              //       borderRadius: BorderRadius.circular(8)),
              // ),
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
                    controller: dateNaiss,
                    decoration: InputDecoration(
                        labelText: 'Date de Naissance',
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
                    controller: lieuxNaiss,
                    decoration: InputDecoration(
                        labelText: 'Lieux de Naissance',
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
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(administrationFoncierState.logoName == ""
                          ? 'Image profile Membre'
                          : administrationFoncierState.logoName),
                      SizedBox(
                        width: size.width * .05,
                      ),
                      RaisedButton(
                        child: Icon(CupertinoIcons.upload_circle_fill),
                        color: Colors.transparent,
                        onPressed: () async {
                          final result = await FilePickerWeb.platform.pickFiles(
                              type: FileType.any, allowMultiple: false);
                          if (result!.files.first != null) {
                            var fileBytes = result.files.first.bytes;
                            var fileName = result.files.first.name;
                            setState(() {
                              administrationFoncierState.setState(() {
                                administrationFoncierState.fileLogo =
                                    fileBytes!;
                                administrationFoncierState.logoName = fileName;
                              });
                            });
                          }
                        },
                      )
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
                        Icon(Icons.school),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Niveau Étude / '),
                        DropdownButton<String>(
                            value: administrationFoncierState.niveauEtude,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                administrationFoncierState.setState(() {
                                  administrationFoncierState.niveauEtude =
                                      newValue!;
                                });
                              });
                            },
                            items: [
                              "coranique",
                              "cm2",
                              "befm",
                              "baccalaureat",
                              "licence",
                              "master",
                              "doctorant",
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
                height: size.height * .04,
                width: size.width * .4,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.school),
                        SizedBox(
                          width: 4,
                        ),
                        Text('NSituation Matrimonial / '),
                        DropdownButton<String>(
                            value: administrationFoncierState.matrimonial,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                administrationFoncierState.setState(() {
                                  administrationFoncierState.matrimonial =
                                      newValue!;
                                });
                              });
                            },
                            items: [
                              "celibataire",
                              "marier",
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
              GestureDetector(
                onTap: () async {
                  try {
                    print("oh c con");

                    Reference ref = FirebaseStorage.instance.ref(
                        'regroupement-membre/${new DateTime.now().millisecondsSinceEpoch.toString()}');

                    ref.putData(administrationFoncierState.fileLogo).then((_) {
                      _.ref.getDownloadURL().then((value) {
                        print("helle");
                        FirebaseFirestore.instance.collection("membres").add({
                          "matricule": matricule.text,
                          "name": nom.text,
                          "fonction": fonction.text,
                          "prenom": prenom.text,
                          "cni": cni.text,
                          "prenomPere": prenomPere.text,
                          "regroupements": idRegroupement,
                          "nomMere": nomMere.text,
                          "prenomMere": prenomMere.text,
                          "dateNaiss": dateNaiss.text,
                          "lieuxNaiss": lieuxNaiss.text,
                          "sexe": administrationFoncierState.sexe,
                          "niveauEtude": administrationFoncierState.niveauEtude,
                          "matrimonial": administrationFoncierState.matrimonial,
                          "avatar": value,
                          "date": DateTime.now()
                        });
                      });
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    print(e);
                    FirebaseFirestore.instance.collection("membres").add({
                      "matricule": matricule.text,
                      "name": nom.text,
                      "prenom": prenom.text,
                      "cni": cni.text,
                      "prenomPere": prenomPere.text,
                      "fonction": fonction.text,
                      "nomMere": nomMere.text,
                      "prenomMere": prenomMere.text,
                      "dateNaiss": dateNaiss.text,
                      "lieuxNaiss": lieuxNaiss.text,
                      "sexe": administrationFoncierState.sexe,
                      "niveauEtude": administrationFoncierState.niveauEtude,
                      "matrimonial": administrationFoncierState.matrimonial,
                      "regroupements": idRegroupement,
                      "avatar": "",
                      "date": DateTime.now()
                    });
                    Navigator.pop(context);
                  }
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

editMembreGestionMembre(
    {required BuildContext context,
    required String idRegroupement,
    required String idMembre}) {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("membres")
            .doc(idMembre)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return AlertDialog(
              content: StatefulBuilder(builder: (context, setState) {
                TextEditingController matricule = new TextEditingController(
                    text: snapshot.data!.get("matricule"));
                TextEditingController nom =
                    new TextEditingController(text: snapshot.data!.get("name"));
                TextEditingController prenom = new TextEditingController(
                    text: snapshot.data!.get("prenom"));
                TextEditingController cni =
                    new TextEditingController(text: snapshot.data!.get("cni"));
                TextEditingController prenomPere = new TextEditingController();
                TextEditingController nomMere = new TextEditingController();
                TextEditingController prenomMere = new TextEditingController();
                TextEditingController dateNaiss = new TextEditingController(
                    text: snapshot.data!.get("dateNaiss"));
                TextEditingController lieuxNaiss = new TextEditingController(
                    text: snapshot.data!.get("lieuxNaiss"));

                TextEditingController fonction = new TextEditingController(
                    text: snapshot.data!.get("fonction"));

                return Container(
                  height: size.height * .7,
                  width: size.width * .5,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Text(
                        'Formulaire d\' édition d\'un membre',
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
                        height: size.height * .04,
                        width: size.width * .4,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(administrationFoncierState.sexe == "homme"
                                    ? Icons.male
                                    : Icons.female),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Sexe / '),
                                DropdownButton<String>(
                                    value: administrationFoncierState.sexe,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState.sexe =
                                              newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "homme",
                                      "femme",
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
                            controller: matricule,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Matricule',
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
                            controller: nom,
                            decoration: InputDecoration(
                                labelText: 'Nom Membre',
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
                            controller: prenom,
                            decoration: InputDecoration(
                                labelText: 'Prenom Membre',
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
                            controller: fonction,
                            decoration: InputDecoration(
                                labelText: 'Fonction Membre',
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
                            controller: cni,
                            decoration: InputDecoration(
                                labelText: 'CNI',
                                border: InputBorder.none,
                                icon: Icon(CupertinoIcons.globe)),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: vert),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      // SizedBox(
                      //   height: size.height * .05,
                      // ), // SizedBox(
                      //   height: size.height * .05,
                      // ),
                      // Container(
                      //   height: size.height * .05,
                      //   width: size.width * .4,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8),
                      //     child: TextField(
                      //       cursorColor: vert,
                      //       controller: prenomPere,
                      //       decoration: InputDecoration(
                      //           labelText: 'Prenom Père',
                      //           border: InputBorder.none,
                      //           icon: Icon(CupertinoIcons.globe)),
                      //     ),
                      //   ),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: vert),
                      //       borderRadius: BorderRadius.circular(8)),
                      // ),
                      // SizedBox(
                      //   height: size.height * .05,
                      // ),
                      // Container(
                      //   height: size.height * .05,
                      //   width: size.width * .4,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8),
                      //     child: TextField(
                      //       cursorColor: vert,
                      //       controller: nomMere,
                      //       decoration: InputDecoration(
                      //           labelText: 'Nom Mère',
                      //           border: InputBorder.none,
                      //           icon: Icon(CupertinoIcons.globe)),
                      //     ),
                      //   ),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: vert),
                      //       borderRadius: BorderRadius.circular(8)),
                      // ),
                      // SizedBox(
                      //   height: size.height * .05,
                      // ),
                      // Container(
                      //   height: size.height * .05,
                      //   width: size.width * .4,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8),
                      //     child: TextField(
                      //       cursorColor: vert,
                      //       controller: prenomMere,
                      //       decoration: InputDecoration(
                      //           labelText: 'Prenom Mère',
                      //           border: InputBorder.none,
                      //           icon: Icon(CupertinoIcons.globe)),
                      //     ),
                      //   ),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: vert),
                      //       borderRadius: BorderRadius.circular(8)),
                      // ),
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
                            controller: dateNaiss,
                            decoration: InputDecoration(
                                labelText: 'Date de Naissance',
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
                            controller: lieuxNaiss,
                            decoration: InputDecoration(
                                labelText: 'Lieux de Naissance',
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
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            children: [
                              Text(administrationFoncierState.logoName == ""
                                  ? 'Image profile Membre'
                                  : administrationFoncierState.logoName),
                              SizedBox(
                                width: size.width * .05,
                              ),
                              RaisedButton(
                                child: Icon(CupertinoIcons.upload_circle_fill),
                                color: Colors.transparent,
                                onPressed: () async {
                                  final result = await FilePickerWeb.platform
                                      .pickFiles(
                                          type: FileType.any,
                                          allowMultiple: false);
                                  if (result!.files.first != null) {
                                    var fileBytes = result.files.first.bytes;
                                    var fileName = result.files.first.name;
                                    setState(() {
                                      administrationFoncierState.setState(() {
                                        administrationFoncierState.fileLogo =
                                            fileBytes!;
                                        administrationFoncierState.logoName =
                                            fileName;
                                      });
                                    });
                                  }
                                },
                              )
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
                                Icon(Icons.school),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Niveau Étude / '),
                                DropdownButton<String>(
                                    value:
                                        administrationFoncierState.niveauEtude,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState
                                              .niveauEtude = newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "coranique",
                                      "cm2",
                                      "befm",
                                      "baccalaureat",
                                      "licence",
                                      "master",
                                      "doctorant",
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
                                Icon(Icons.school),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('NSituation Matrimonial / '),
                                DropdownButton<String>(
                                    value:
                                        administrationFoncierState.matrimonial,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState
                                              .matrimonial = newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "celibataire",
                                      "marier",
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
                      GestureDetector(
                        onTap: () async {
                          try {
                            print("oh c con");

                            Reference ref = FirebaseStorage.instance.ref(
                                'regroupement-membre/${new DateTime.now().millisecondsSinceEpoch.toString()}');

                            ref
                                .putData(administrationFoncierState.fileLogo)
                                .then((_) {
                              _.ref.getDownloadURL().then((value) {
                                print("helle");
                                FirebaseFirestore.instance
                                    .collection("membres")
                                    .doc(idMembre)
                                    .update({
                                  "matricule": matricule.text,
                                  "name": nom.text,
                                  "fonction": fonction.text,
                                  "prenom": prenom.text,
                                  "cni": cni.text,
                                  "prenomPere": prenomPere.text,
                                  "regroupements": idRegroupement,
                                  "nomMere": nomMere.text,
                                  "prenomMere": prenomMere.text,
                                  "dateNaiss": dateNaiss.text,
                                  "lieuxNaiss": lieuxNaiss.text,
                                  "sexe": administrationFoncierState.sexe,
                                  "niveauEtude":
                                      administrationFoncierState.niveauEtude,
                                  "matrimonial":
                                      administrationFoncierState.matrimonial,
                                  "avatar": value,
                                  "date": DateTime.now()
                                });
                              });
                              Navigator.pop(context);
                            });
                          } catch (e) {
                            print(e);
                            FirebaseFirestore.instance
                                .collection("membres")
                                .doc(idMembre)
                                .update({
                              "matricule": matricule.text,
                              "name": nom.text,
                              "prenom": prenom.text,
                              "cni": cni.text,
                              "prenomPere": prenomPere.text,
                              "fonction": fonction.text,
                              "nomMere": nomMere.text,
                              "prenomMere": prenomMere.text,
                              "dateNaiss": dateNaiss.text,
                              "lieuxNaiss": lieuxNaiss.text,
                              "sexe": administrationFoncierState.sexe,
                              "niveauEtude":
                                  administrationFoncierState.niveauEtude,
                              "matrimonial":
                                  administrationFoncierState.matrimonial,
                              "regroupements": idRegroupement,
                              // "avatar": "",
                              "date": DateTime.now()
                            });
                            Navigator.pop(context);
                          }
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
              }),
            );
          }
        }),
  );
}

deleteMembre(
    {required BuildContext context,
    required String idRegroupement,
    required String idMembre}) {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("membres")
            .doc(idMembre)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return AlertDialog(
              content: StatefulBuilder(builder: (context, setState) {
                return Container(
                  height: size.height * .3,
                  width: size.width * .4,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Text(
                        'Confirmez la supression du membre',
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
                          try {
                            FirebaseFirestore.instance
                                .collection("membres")
                                .doc(idMembre)
                                .delete();
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                            FirebaseFirestore.instance
                                .collection("membres")
                                .doc(idMembre)
                                .delete();
                            Navigator.pop(context);
                          }
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
              }),
            );
          }
        }),
  );
}
