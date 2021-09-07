import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-Domaine.dart';

adminDomaine({
  required BuildContext context,
}) async {
  Size size = MediaQuery.of(context).size;
  await FirebaseFirestore.instance
     .collection("villages")
      .get()
      .then((value) {
    // print(value.docs.length);
    if (value.docs.length > 0) {
      administrationFoncierState.setState(() {
        administrationFoncierState.villageSelected = value.docs.first.id;
      });
    } else {
      administrationFoncierState.setState(() {
        administrationFoncierState.villageSelected = '';
      });
    }
  });
  showDialog(
      context: context,
      builder: (context) => StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
               .collection("domaines")
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
                                Text('Gestions des Domaines'),
                                Spacer(),
                                Container(
                                  // width: size.width * .15,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("villages").snapshots(),
                                    builder: (context, snap) {
                                      return !snap.hasData ?  Container() : DropdownButton<String>(
                                          value: administrationFoncierState
                                              .villageSelected,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              administrationFoncierState
                                                  .setState(() {
                                                administrationFoncierState
                                                    .villageSelected = newValue!;
                                              });
                                            });
                                          },
                                          items: snap.data!.docs
                                              .map((e) => DropdownMenuItem(
                                                  value: e.id,
                                                  child: Text(
                                                      "${e.get("code")}-${e.get("nom")}")))
                                              .toList());
                                    }
                                  ),
                                  decoration: BoxDecoration(),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => addDomaine(
                                      context: context,
                                      
                                      idVillage: administrationFoncierState
                                          .villageSelected),
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
                                          '   Ajouter un Domaine / Lot   ',
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
                          Container(
                            height: size.height * .8,
                            width: size.width * .7,
                            child: LayoutBuilder(
                            builder: (context, constraints) =>
                                StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("domaines")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  List<TableRow> listes = [
                                    TableRow(children: [
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Icon(
                                                Icons.format_list_numbered,
                                                color: vert,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Code Domaine',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Icon(
                                                CupertinoIcons.globe,
                                                color: vert,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'CNI Propriétaire du domaine',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Icon(
                                                Icons.date_range_rounded,
                                                color: vert,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Date',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Icon(
                                                Icons.settings,
                                                color: vert,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Paramètres',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                    ])
                                  ];

                                  for
                                   (var item in snapshot.data!.docs) {
                                     if (item.get("villages") == administrationFoncierState.villageSelected) {
                                       Timestamp timestamp = item.get('date');
                                    DateTime date =
                                        new DateTime.fromMicrosecondsSinceEpoch(
                                            timestamp.millisecondsSinceEpoch *
                                                1000);
                                       listes.add(TableRow(children: [
Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                item.get('code'),
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                item.get('cni'),
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                dateFormatter(date),
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () => null,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: vert,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
                                              GestureDetector(
                                                onTap: () => null,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: rouge,
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                    ]));
                                     }
                                    
                                  }

                                 
                                  return Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth,
                                    child: ListView(
                                      children: [
                                        Container(
                                          child: Table(
                                            border:
                                                TableBorder.all(color: vert),
                                            children: listes,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                )));
}
