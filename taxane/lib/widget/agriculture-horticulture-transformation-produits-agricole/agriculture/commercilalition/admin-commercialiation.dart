import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/agriculture-hortoculture.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/commercilalition/dialog-commercialisation.dart';
import 'package:taxane/widget/agriculture-horticulture-transformation-produits-agricole/agriculture/operateur-stockeur/admin-operateur-stockeur.dart';

adminCommercialisation({required BuildContext context}) async {
  Size size = MediaQuery.of(context).size;
     await  FirebaseFirestore.instance.collection("productions").get().then((value) {
    agricultureHortocultureState.setState(() {
      agricultureHortocultureState.production = value.docs.first.id;
    });
  });
  showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
                content: Container(
                  height: size.height * .9,
                  width: size.width * .6,
                  child: Column(
                    children: [
                      Container(
                        width: size.width * .7,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * .01,
                            ),
                            Text('Gestion des Commercialisations'),
                              Spacer(),
                               Row(
                                      children: [
                                Text('Productions /  '),
              
                                        Container(
                                                          // width: size.width * .15,
                                                          child: StreamBuilder<QuerySnapshot>(
                                                            stream: FirebaseFirestore.instance.collection("productions").snapshots(),
                                                            builder: (context, snap) {
                                                              return !snap.hasData ? Container() : DropdownButton<String>(
                                                                  value: agricultureHortocultureState
                                                                      .production,
                                                                  onChanged: (String? newValue) {
                                                                    setState(() {
                                                                      agricultureHortocultureState.production = newValue!;
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
                              onTap: () => addCommercialisation(context: context , idProduction: agricultureHortocultureState.production ),
                              child: Container(
                                /* width: size.width * .1, */
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '  Ajouter commercialisation  ',
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
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .01,
                            ),
                            GestureDetector(
                              onTap: () => adminOperateurStokeur(context: context),
                              child: Container(
                                /* width: size.width * .1, */
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '   Gestion  Operateur Stockeur   ',
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
                                    borderRadius: BorderRadius.circular(4)),
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
                        child: LayoutBuilder(
                          builder: (context, constraints) => StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("commercialisations")
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
                                                width: constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Code Commerciale',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight: FontWeight.bold),
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
                                                width: constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Nom Produit',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight: FontWeight.bold),
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
                                                width: constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Date',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight: FontWeight.bold),
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
                                                width: constraints.maxWidth * .01,
                                              ),
                                              Text(
                                                'Paramètres',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Spacer(),
                                            ],
                                          )),
                                    ])
                                  ];

                                  

                                  for (var item in snapshot.data!.docs) {
                                    if (item.get("productionID") == agricultureHortocultureState.production) {
                                       Timestamp timestamp = item.get('date');
                                    DateTime date =
                                        new DateTime.fromMicrosecondsSinceEpoch(
                                            timestamp.millisecondsSinceEpoch *
                                                1000);

                                                listes.add( TableRow(children: [
                                      Container(
                                          height: constraints.maxHeight * .05,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                item.get('code'),
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight: FontWeight.w300),
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
                                                "${item.get('produit')}",
                                                style: TextStyle(
                                                    color: vert,
                                                    fontWeight: FontWeight.w300),
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
                                                    fontWeight: FontWeight.w300),
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
                                                  Icons.remove_red_eye,
                                                  color: vert,
                                                ),
                                              ),
                                              SizedBox(
                                                width: constraints.maxWidth * .01,
                                              ),
                                              GestureDetector(   
                                                onTap: () => null,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: jaune,
                                                ),
                                              ),
                                              SizedBox(
                                                width: constraints.maxWidth * .01,
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
                                            border: TableBorder.all(color: vert),
                                            children: listes,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              );
        }
      ));
}
