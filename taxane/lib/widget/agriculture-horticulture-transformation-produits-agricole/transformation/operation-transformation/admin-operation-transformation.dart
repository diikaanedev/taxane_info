import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/transformation/operation-transformation/show-transforamtions/show-operation-transformation.dart';

adminOperationTransformation({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      height: size.height * .9,
      width: size.width * .8,
      child: Column(
        children: [
          Container(
            /*  height: size.height * .07, */
            width: size.width * .8,
            child: Row(
              children: [
                Text('Gestion des Opérations de transformation') ,
                Spacer(),
                GestureDetector(
                  onTap: () => null,
                  child:  Container(
                    
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '   Ajouter une opération   ',
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
                /* SizedBox(width: 8,),
                 GestureDetector(
                   onTap: () => null,
                  child:  Container(
                    width: size.width * .1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Gestion des Gérants',
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
                        color: rouge,
                        borderRadius:
                            BorderRadius.circular(4)),
                  ),
                ), */
                SizedBox(width: 8,),
              ],
            ),
          ),
          SizedBox(height: size.height * .02,),
          Container(
            height: size.height * .8,
            width: size.width * .8,
             child:  LayoutBuilder(
                                  builder: (context ,  constraints) =>  StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                    .collection("/operation-transformation")
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
                                                  CupertinoIcons.money_dollar_circle,
                                                  color: vert,
                                                ),
                                                SizedBox(
                                                  width:
                                                      constraints.maxWidth * .01,
                                                ),
                                                Text(
                                                  'Compte d\'exploitation',
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
                                               "${ e.get('compte-exploitation')}",
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
                                                onTap: () => showOperationTransformation(context: context, idOperation: e.id),
                                                child: Icon(
                                                  Icons.remove_red_eye_rounded,
                                                  color: jaune,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .01,
                                              ),
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