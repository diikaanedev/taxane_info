import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/dialog-menage.dart';

adminMenage({
  required BuildContext context,
}) async {
  Size size = MediaQuery.of(context).size;
  await FirebaseFirestore.instance
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
          stream: FirebaseFirestore.instance.collection("menages").snapshots(),
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
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("concessions")
                                          .snapshots(),
                                      builder: (context, snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : DropdownButton<String>(
                                                value:
                                                    administrationFoncierState
                                                        .concessionSelected,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    administrationFoncierState
                                                        .setState(() {
                                                      administrationFoncierState
                                                              .concessionSelected =
                                                          newValue!;
                                                    });
                                                  });
                                                },
                                                items: snap.data!.docs
                                                    .map((e) => DropdownMenuItem(
                                                        value: e.id,
                                                        child: Text(
                                                            "${e.get("code")}-${e.get("nom")}")))
                                                    .toList());
                                      }),
                                  decoration: BoxDecoration(),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => addMenage(
                                      context: context,
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
                          Container(
                            height: size.height * .8,
                            width: size.width * .7,
                            child: LayoutBuilder(
                              builder: (context, constraints) =>
                                  StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("menages")
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
                                                  width: constraints.maxWidth *
                                                      .01,
                                                ),
                                                Text(
                                                  'Code Ménage',
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
                                                  width: constraints.maxWidth *
                                                      .01,
                                                ),
                                                Text(
                                                  'Nom Chef Ménage',
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
                                                  width: constraints.maxWidth *
                                                      .01,
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
                                                  width: constraints.maxWidth *
                                                      .01,
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

                                    for (var item in snapshot.data!.docs) {
                                      if (item.get("concessions") ==
                                          administrationFoncierState
                                              .concessionSelected) {
                                        Timestamp timestamp = item.get('date');
                                        DateTime date = new DateTime
                                                .fromMicrosecondsSinceEpoch(
                                            timestamp.millisecondsSinceEpoch *
                                                1000);
                                        listes.add(TableRow(children: [
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
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
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    item.get('nom'),
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
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
                                              height:
                                                  constraints.maxHeight * .05,
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
                                                        constraints.maxWidth *
                                                            .01,
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

  adminMenageRole2(
    {required BuildContext context, required String idVillage}) async {
  Size size = MediaQuery.of(context).size;
  await FirebaseFirestore.instance
      .collection("concessions")
      .get()
      .then((value) {
    // print(value.docs.length);
    if (value.docs.length > 0) {
      for (var item in value.docs) {
        if (item.get('villages') == idVillage) {
          administrationFoncierState.setState(() {
            administrationFoncierState.concessionSelected = item.id;
          });
          break;
        }
      }
    } else {
      administrationFoncierState.setState(() {
        administrationFoncierState.concessionSelected = '';
      });
    }
  });
  showDialog(
      context: context,
      builder: (context) => StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("menages").snapshots(),
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
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("concessions")
                                          .snapshots(),
                                      builder: (context, snap) {
                                        if (!snap.hasData) {
                                          return Container();
                                        } else {
                                          List<DropdownMenuItem<String>> items =
                                              [];
                                          for (var item in snap.data!.docs) {
                                            if (item.get('villages') ==
                                                idVillage) {
                                              items.add(DropdownMenuItem(
                                                  value: item.id,
                                                  child: Text(
                                                      "${item.get("code")}-${item.get("nom")}")));
                                            }
                                          }

                                          return DropdownButton<String>(
                                              value: administrationFoncierState
                                                  .concessionSelected,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  administrationFoncierState
                                                      .setState(() {
                                                    administrationFoncierState
                                                            .concessionSelected =
                                                        newValue!;
                                                  });
                                                });
                                              },
                                              items: items);
                                        }
                                      }),
                                  decoration: BoxDecoration(),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => addMenage(
                                      context: context,
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
                          Container(
                            height: size.height * .8,
                            width: size.width * .7,
                            child: LayoutBuilder(
                              builder: (context, constraints) =>
                                  StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("menages")
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
                                                  width: constraints.maxWidth *
                                                      .01,
                                                ),
                                                Text(
                                                  'Code Ménage',
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
                                                  width: constraints.maxWidth *
                                                      .01,
                                                ),
                                                Text(
                                                  'Nom Chef Ménage',
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
                                                  width: constraints.maxWidth *
                                                      .01,
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
                                                  width: constraints.maxWidth *
                                                      .01,
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

                                    for (var item in snapshot.data!.docs) {
                                      if (item.get("concessions") ==
                                          administrationFoncierState
                                              .concessionSelected) {
                                        Timestamp timestamp = item.get('date');
                                        DateTime date = new DateTime
                                                .fromMicrosecondsSinceEpoch(
                                            timestamp.millisecondsSinceEpoch *
                                                1000);
                                        listes.add(TableRow(children: [
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
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
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    item.get('nom'),
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
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
                                              height:
                                                  constraints.maxHeight * .05,
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
                                                        constraints.maxWidth *
                                                            .01,
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
