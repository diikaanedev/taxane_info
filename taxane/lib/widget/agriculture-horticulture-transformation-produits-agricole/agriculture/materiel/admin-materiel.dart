import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/agriculture-hortoculture.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/materiel/dialog-materiel.dart';

adminMateriel({required BuildContext context}) async {
  Size size = MediaQuery.of(context).size;
  await  FirebaseFirestore.instance.collection("champs").get().then((value) {
    agricultureHortocultureState.setState(() {
      agricultureHortocultureState.champ = value.docs.first.id;
    });
  });
  showDialog(context: context, builder: (context) => StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("materiels-champs").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container();
      } else {
        return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Container(
              height: size.height * .7,
              width: size.width * .5,
              child: Column(
                children: [
                   Container(
                    width: size.width * .7,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * .01,
                        ),
                        Text('Gestion des Matériels '),
                        
                        Spacer(),
                       Row(
                              children: [
                        Text('Champs /  '),
      
                                Container(
                                                  // width: size.width * .15,
                                                  child: StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore.instance.collection("champs").snapshots(),
                                                    builder: (context, snap) {
                                                      return !snap.hasData ? Container() : DropdownButton<String>(
                                                          value: agricultureHortocultureState
                                                              .champ,
                                                          onChanged: (String? newValue) {
                                                            setState(() {
                                                              agricultureHortocultureState.champ = newValue!;
                                                            });
                                                          },
                                                          items: snap.data!.docs
                                                              .map((e) => DropdownMenuItem(
                                                                  value: e.id,
                                                                  child: Text(
                                                                      "${e.get("code")}")))
                                                              .toList());
                                                    }
                                                  ),
                                                  decoration: BoxDecoration(),
                                                ),
                              ],
                            )
                        ,
                        Spacer(),
                        
                          GestureDetector(
                          onTap: () => addMaterielChamps(context: context, idChamps: agricultureHortocultureState.champ),
                          child: Container(
                            width: size.width * .1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '  ajouter materiel à un champs  ',
                                  style: TextStyle(
                                      fontSize: size.height * .012,
                                      color: blanc),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: vert,
                                borderRadius:
                                    BorderRadius.circular(4)),
                          ),
                        ),
                        SizedBox(width: 8,),
                         GestureDetector(
                          onTap: () => addMateriel(context: context),
                          child: Container(
                            width: size.width * .1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'gestion materiel',
                                  style: TextStyle(
                                      fontSize: size.height * .012,
                                      color: blanc),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: rouge,
                                borderRadius:
                                    BorderRadius.circular(4)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                Container(
                  height: size.height * .6,
                                width: size.width * .7,
                  child: LayoutBuilder(builder: (context ,  constraints)=> StreamBuilder<QuerySnapshot>(builder:  (context, snaps) {
                            if (!snapshot.hasData) {
                                                  return Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );
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
                                                            'Code Materiel',
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
                                                            'Nom Materiel',
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
                                      
                                           for (var item in snapshot.data!.docs) {
                                             if (item.get('champs') == agricultureHortocultureState.champ) {
                                               Timestamp timestamp = item.get('date');
                                          DateTime date = new DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                              timestamp.millisecondsSinceEpoch *
                                                  1000);

                                                  listes.add(TableRow(
                                                    children: [
 Container(
                                                height:
                                                    constraints.maxHeight * .05,
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      item.get('materielCode'),
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
                                                      item.get('materielNom'),
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
                                                )
                                                ),
                                                    ]));
                                             }
                                           }
                                      
                                            return Container(
                                              height: constraints.maxHeight,
                                              width: constraints.maxWidth,
                                              child: StatefulBuilder(
                                                builder: (context, setSat) {
                                                  return ListView(
                                                    children: [
                                                      Container(
                                                        child: Table(
                                                          border:
                                                              TableBorder.all(color: vert),
                                                          children: listes,
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }
                                              ),
                                            );    
                                      
                                                }
                          },
                          stream: FirebaseFirestore.instance
                                              .collection("materiels-champs")
                                              .snapshots(),)),
                ),
                ],
              ),),
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
        }
      );
      }
    }
  ),
    
     );
}