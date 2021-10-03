import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/transformation/gestion-gerant/dialog-gerant.dart';

adminGerant({required BuildContext context}) {
  Size size = MediaQuery.of(context).size ;
  showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      height: size.height * .9,
      width: size.width * .6,
      child: Column(
        children: [
          Container(
            /*  height: size.height * .07, */
            width: size.width * .6,
            child: Row(
              children: [
                Text('Gestion des Gérants') ,
                Spacer(),
                GestureDetector(
                  onTap: () => addGerant(context: context),
                  child:  Container(
                    width: size.width * .1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Ajouter un gérant',
                          style: TextStyle(
                              fontSize: size.height * .015,
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
              ],
            ),
          ),
          SizedBox(height: size.height * .02,),
          Container(
            height: size.height * .8,
            width: size.width * .6,
             child:  LayoutBuilder(
                                  builder: (context ,  constraints) =>  StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                    .collection("gerants")
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
                                                  'Code',
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
                                                  'Nom',
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

                                    listes.addAll(snapshot.data!.docs.map((e) {
                                    Timestamp timestamp = e.get('date');
                                    DateTime date =
                                        new DateTime.fromMicrosecondsSinceEpoch(
                                            timestamp.millisecondsSinceEpoch *
                                                1000);
                                    return TableRow(children: [
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                e.get('code'),
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
                                               "${ e.get('prenom')} ${ e.get('nom')}",
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
                                    ]);
                                  }).toList());

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
                                    
                                  } ),
                                ),
                              ),
        ],
      ),
    ),
  ));
}