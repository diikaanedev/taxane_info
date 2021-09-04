import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

class TableRegion extends StatefulWidget {
  final String id;
  const TableRegion({Key? key, required this.id}) : super(key: key);

  @override
  _TableRegionState createState() => _TableRegionState();
}

class _TableRegionState extends State<TableRegion> {
  late List<TableRow> listes = [];
  @override
  void initState() {
    setState(() {
      listes = [];
    });
    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      listes = [];
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      listes = [];
    });
    return LayoutBuilder(
      builder: (context, constraints) {
        listes.addAll(listes = [
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
                      'Code Région',
                      style:
                          TextStyle(color: vert, fontWeight: FontWeight.bold),
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
                      'Nom Région',
                      style:
                          TextStyle(color: vert, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(color: vert, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(color: vert, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                )),
          ]),
        ]);
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('pays')
                .doc(widget.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                List regions = snapshot.data!.get('regions') as List;
                listes.addAll(regions.map((e) {
                  Timestamp timestamp = e['date'];
                  DateTime date = new DateTime.fromMicrosecondsSinceEpoch(
                      timestamp.millisecondsSinceEpoch * 1000);
                  return TableRow(children: [
                    Container(
                        height: constraints.maxHeight * .05,
                        child: Row(
                          children: [
                            Spacer(),
                            Text(
                              e['code'],
                              style: TextStyle(
                                  color: vert, fontWeight: FontWeight.w300),
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
                              e['nom'],
                              style: TextStyle(
                                  color: vert, fontWeight: FontWeight.w300),
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
                                  color: vert, fontWeight: FontWeight.w300),
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
                              Icons.edit,
                              color: vert,
                            ),
                            SizedBox(
                              width: constraints.maxWidth * .01,
                            ),
                            Icon(
                              Icons.delete,
                              color: rouge,
                            ),
                            Spacer(),
                          ],
                        )),
                  ]);
                }).toList());
                return Table(
                  children: listes,
                );
              }
            });
      },
    );
  }
}
