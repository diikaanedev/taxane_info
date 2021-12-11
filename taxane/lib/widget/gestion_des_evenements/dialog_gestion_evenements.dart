import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';

addEvenements({required BuildContext context, required String idRegroupement}) {
  Size size = MediaQuery.of(context).size;
  TextEditingController lieux = new TextEditingController();
  TextEditingController nomAnimateur = new TextEditingController();
  TextEditingController nomFormation = new TextEditingController();
  TextEditingController nomBailleur = new TextEditingController();
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
                'Formulaire d\' ajout d\'un événement',
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
                        Icon(Icons.workspaces),
                        SizedBox(
                          width: 8,
                        ),
                        Text(' Type Événement / '),
                        DropdownButton<String>(
                            value: administrationFoncierState.typeEvenement,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                administrationFoncierState.setState(() {
                                  administrationFoncierState.typeEvenement =
                                      newValue!;
                                });
                              });
                            },
                            items: [
                              "reunion",
                              "formation",
                              "seminaire",
                              "foire"
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
                    child: Row(
                      children: [
                        Text(
                          ' Période : ',
                          style: TextStyle(
                            color: noir,
                            fontSize: size.height * .03,
                          ),
                        ),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () async {
                              showDatePicker(
                                      context: context,
                                      initialDate: administrationFoncierState
                                          .initialPeriod,
                                      initialDatePickerMode: DatePickerMode.day,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030))
                                  .then((value) => setState(() {
                                        administrationFoncierState
                                            .initialPeriod = value!;
                                      }));
                            },
                            child: Container(
                                height: size.height * .03,
                                decoration: BoxDecoration(
                                    color: vert,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                    child: Text('   Date Initiale   ',
                                        style: TextStyle(color: blanc)))),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                            '${administrationFoncierState.initialPeriod.day}-${administrationFoncierState.initialPeriod.month}-${administrationFoncierState.initialPeriod.year}'),
                        Spacer(),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () async {
                              showDatePicker(
                                      context: context,
                                      initialDate: administrationFoncierState
                                          .initialPeriod,
                                      initialDatePickerMode: DatePickerMode.day,
                                      firstDate: administrationFoncierState
                                          .initialPeriod,
                                      lastDate: DateTime(2030))
                                  .then((value) => setState(() {
                                        administrationFoncierState
                                            .initialFinal = value!;
                                      }));
                            },
                            child: Container(
                                height: size.height * .03,
                                decoration: BoxDecoration(
                                    color: vert,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                    child: Text('   Date Finale   ',
                                        style: TextStyle(color: blanc)))),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                            '${administrationFoncierState.initialFinal.day}-${administrationFoncierState.initialFinal.month}-${administrationFoncierState.initialFinal.year}'),
                        SizedBox(
                          width: 16,
                        ),
                        Spacer(),
                      ],
                    )),
                decoration: BoxDecoration(
                    // border: Border.all(color: vert),
                    // borderRadius: BorderRadius.circular(8)
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
                    controller: nomFormation,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText:
                            'Nom ${administrationFoncierState.typeEvenement}',
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
                    controller: lieux,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Lieux',
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
                    controller: nomAnimateur,
                    decoration: InputDecoration(
                        labelText: 'Nom Complet Animateur',
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
                    controller: nomBailleur,
                    decoration: InputDecoration(
                        labelText: 'Nom Complet Bailleur',
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
              GestureDetector(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('evenements')
                      .add({
                    "type": administrationFoncierState.typeEvenement,
                    "dateInitial": administrationFoncierState.initialPeriod,
                    "dateFinal": administrationFoncierState.initialFinal,
                    "lieux": lieux.text,
                    "name": nomFormation.text,
                    "nomCompletAninameur": nomAnimateur.text,
                    "nomCompletBailleur": nomBailleur.text,
                    "date": DateTime.now()
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

showEvenement(
    {required BuildContext context,
    required String idRegroupement,
    required String idEvenement}) async {
  Size size = MediaQuery.of(context).size;

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: size.height * 9,
                width: size.width * .8,
                child: LayoutBuilder(builder: (context, constraints) {
                  return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("evenements")
                          .doc(idEvenement)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Text("")
                            : Container(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: constraints.maxHeight,
                                      width: constraints.maxWidth,
                                    ),
                                    Positioned(
                                        child: Container(
                                      height: constraints.maxHeight * .05,
                                      width: constraints.maxWidth,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 5,
                                            color: vert,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            snapshot.data!.get('name'),
                                            style: TextStyle(
                                                color: vert,
                                                fontSize:
                                                    constraints.maxHeight * .03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () => addParticipants(
                                                context: context,
                                                idRegroupement: idRegroupement,
                                                idEvenement: idEvenement),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                                                    '   Ajouter un Participant   ',
                                                    style:
                                                        TextStyle(color: blanc),
                                                  )),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * .01,
                                          )
                                        ],
                                      ),
                                    )),
                                    Positioned(
                                        right: 0,
                                        top: constraints.maxHeight * .07,
                                        child: Container(
                                          height: constraints.maxHeight * .93,
                                          width: constraints.maxWidth * .35,
                                          child: Column(
                                            children: [
                                              Container(
                                                height:
                                                    constraints.maxHeight * .05,
                                                width:
                                                    constraints.maxWidth * .35,
                                                child: Center(
                                                  child: Text(
                                                    'Proces-Verbal  ',
                                                    style: TextStyle(
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            .03,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: noir),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height:
                                                    constraints.maxHeight * .8,
                                                width:
                                                    constraints.maxWidth * .35,
                                                child: StreamBuilder<
                                                        DocumentSnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "evenements")
                                                        .doc(idEvenement)
                                                        .snapshots(),
                                                    builder: (context, snap) {
                                                      if (!snap.hasData)
                                                        return Text('');
                                                      else {
                                                        return ListView(
                                                          children: [
                                                            Text(snap.data!.get("pv")),
                                                          ],
                                                        );
                                                      }
                                                    }),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                        left: 0,
                                        top: constraints.maxHeight * .07,
                                        child: Container(
                                          height: constraints.maxHeight * .93,
                                          width: constraints.maxWidth * .6,
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("participants")
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Text('');
                                                } else {
                                                  List<TableRow> listes = [
                                                    TableRow(children: [
                                                      Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Icon(
                                                                Icons
                                                                    .format_list_numbered,
                                                                color: vert,
                                                              ),
                                                              SizedBox(
                                                                width: constraints
                                                                        .maxWidth *
                                                                    .01,
                                                              ),
                                                              Text(
                                                                'Code ',
                                                                style: TextStyle(
                                                                    color: vert,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          )),
                                                      Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Icon(
                                                                CupertinoIcons
                                                                    .globe,
                                                                color: vert,
                                                              ),
                                                              SizedBox(
                                                                width: constraints
                                                                        .maxWidth *
                                                                    .01,
                                                              ),
                                                              Text(
                                                                'Nom ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: vert,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          )),
                                                      Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Icon(
                                                                Icons
                                                                    .date_range_rounded,
                                                                color: vert,
                                                              ),
                                                              SizedBox(
                                                                width: constraints
                                                                        .maxWidth *
                                                                    .01,
                                                              ),
                                                              Text(
                                                                'Téléphone',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: vert,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          )),
                                                      Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              .05,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Icon(
                                                                Icons.settings,
                                                                color: vert,
                                                              ),
                                                              SizedBox(
                                                                width: constraints
                                                                        .maxWidth *
                                                                    .01,
                                                              ),
                                                              Text(
                                                                'Paramètres',
                                                                style: TextStyle(
                                                                    color: vert,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          )),
                                                    ])
                                                  ];

                                                  for (QueryDocumentSnapshot item
                                                      in snapshot.data!.docs) {
                                                    if (true) {
                                                      listes.add(
                                                          TableRow(children: [
                                                        Container(
                                                            height:
                                                                size.height *
                                                                    .05,
                                                            child: Row(
                                                              children: [
                                                                Spacer(),
                                                                Text(
                                                                  item.get(
                                                                      'matricule'),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          vert,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            )),
                                                        Container(
                                                            height:
                                                                size.height *
                                                                    .05,
                                                            child: Row(
                                                              children: [
                                                                Spacer(),
                                                                Text(
                                                                  "${item.get('prenom')} ${item.get('nom')}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color:
                                                                          vert,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            )),
                                                        Container(
                                                            height:
                                                                size.height *
                                                                    .05,
                                                            child: Row(
                                                              children: [
                                                                Spacer(),
                                                                Text(
                                                                  item.get(
                                                                      'telephone'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          vert,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            )),
                                                        Container(
                                                            height:
                                                                size.height *
                                                                    .05,
                                                            child: Row(
                                                              children: [
                                                                Spacer(),
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      null,
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .eye_fill,
                                                                    color:
                                                                        jaune,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          .01,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      null,
                                                                  child: Icon(
                                                                    Icons.edit,
                                                                    color: vert,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          .01,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      null,
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color:
                                                                        rouge,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            )),
                                                      ]));
                                                    }
                                                  }

                                                  return Container(
                                                    child: ListView(
                                                      children: [
                                                        Table(
                                                          border:
                                                              TableBorder.all(
                                                                  color: vert),
                                                          children: listes,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              }),
                                        )),
                                  ],
                                ),
                              );
                      });
                }),
              );
            },
          ),
          actions: [
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

void addParticipants(
    {required BuildContext context,
    required String idRegroupement,
    required String idEvenement}) {
  Size size = MediaQuery.of(context).size;
  TextEditingController matricule = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController telephone = new TextEditingController();

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
                'Formulaire d\' ajout d\'un participant',
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
                        labelText: 'Nom participant',
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
                        labelText: 'Prenom participant',
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
                    controller: telephone,
                    decoration: InputDecoration(
                        labelText: 'Telephone participant',
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
              GestureDetector(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection("participants")
                      .add({
                    "matricule": matricule.text,
                    "nom": nom.text,
                    "prenom": prenom.text,
                    "telephone": telephone.text,
                    "sexe": administrationFoncierState.sexe,
                    "evenements": idEvenement,
                    "date": DateTime.now()
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
