import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/card-menu-home.dart';
import 'package:taxane/widget/field-data.dart';
import 'package:taxane/widget/menu-left-home.dart';

class HomeLaptop extends StatefulWidget {
  const HomeLaptop({Key? key}) : super(key: key);

  @override
  _HomeLaptopState createState() => _HomeLaptopState();
}

class _HomeLaptopState extends State<HomeLaptop> {
  late Size size;
  String valueData = "Agriculture";

  String localite = "Sénégal";
  int y = int.parse(DateFormat('y').format(DateTime.now()));
  int yL = int.parse(DateFormat('y').format(DateTime.now())) - 1;
  int yP = int.parse(DateFormat('y').format(DateTime.now())) + 1;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        elevation: .0,
      ),
      backgroundColor: vert,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
          ),
          Positioned(
              top: size.height * .015,
              left: size.width * .2,
              child: Container(
                width: size.width * .79,
                height: size.height * .97,
                child: LayoutBuilder(
                  builder: (context, constraints) => Stack(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                            color: blanc,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(
                          // right: constraints.maxWidth * .01,
                          top: constraints.maxHeight * .01,
                          child: Container(
                            height: constraints.maxHeight * .05,
                            width: constraints.maxWidth,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                ),
                                Text(
                                  'Localité ',
                                  style: TextStyle(
                                      color: gris3,
                                      fontSize: constraints.maxHeight * .04),
                                ),
                                Text(
                                  '$localite',
                                  style: TextStyle(
                                      color: gris3,
                                      decoration: TextDecoration.underline,
                                      fontSize: constraints.maxHeight * .04),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                ),
                                Container(
                                  width: constraints.maxWidth * .001,
                                  color: vert,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                ),
                                DropdownButton<String>(
                                  style: TextStyle(
                                      fontSize: constraints.maxHeight * .03,
                                      fontWeight: FontWeight.bold,
                                      color: noir),
                                  underline: Container(),
                                  icon: Icon(
                                    CupertinoIcons.chevron_down_circle_fill,
                                    color: vert,
                                  ),
                                  items: <String>[
                                    '$yL',
                                    '$y',
                                    '$yP',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  value: y.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      y = int.parse(value!);
                                      yL = y - 1;
                                      yP = y + 1;
                                    });
                                  },
                                ),
                                Spacer(),
                                Container(
                                  width: constraints.maxWidth * .1,
                                  child: Center(
                                    child: Text(
                                      'Ajouter utilisateur',
                                      style: TextStyle(color: blanc),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: vert,
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .01,
                                )
                              ],
                            ),
                          )),
                      Positioned(
                          top: constraints.maxHeight * .07,
                          child: Container(
                            height: constraints.maxHeight * .65,
                            width: constraints.maxWidth,
                            child: Column(
                              children: [
                                Spacer(),
                                Container(
                                  height: constraints.maxHeight * .12,
                                  // color: gris3,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) => Row(
                                      children: [
                                        SizedBox(
                                          width: constraints.maxWidth * .03,
                                        ),
                                        Container(
                                          width: constraints.maxWidth * .3,
                                          child: CardMenuHome(
                                            title: 'Nombre Association',
                                            icon: CupertinoIcons
                                                .circle_grid_hex_fill,
                                            nombre: '340',
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: constraints.maxWidth * .28,
                                          child: CardMenuHome(
                                            title: 'Nombre Message',
                                            icon: CupertinoIcons.mail,
                                            nombre: '10',
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: constraints.maxWidth * .28,
                                          child: CardMenuHome(
                                            title: 'Nombre Utilisateur',
                                            icon: CupertinoIcons
                                                .person_crop_circle,
                                            nombre: '100000',
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: constraints.maxHeight * .4,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) => Row(
                                      children: [
                                        SizedBox(
                                          width: constraints.maxWidth * .03,
                                        ),
                                        Container(
                                          width: constraints.maxWidth * .3,
                                          color: gris,
                                        ),
                                        Spacer(),
                                        Container(
                                          width: constraints.maxWidth * .6,
                                          child: Column(
                                            children: [
                                              Text('Tableau des Associations')
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            height: constraints.maxHeight * .3,
                            width: constraints.maxWidth,
                            child: Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight * .05,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth * .02,
                                      ),
                                      Text(
                                        'Détails Productions',
                                        style: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * .025,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      DropdownButton<String>(
                                        items: <String>[
                                          'Agriculture',
                                          'Élevage',
                                          'Horticulture',
                                          'Foncier',
                                          '25 NOVEMBRE'
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        value: valueData,
                                        onChanged: (value) {
                                          setState(() {
                                            valueData = value!;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .02,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: constraints.maxHeight * .2,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert,
                                          mois: 'Janvier',
                                          taille: .6,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Février',
                                          taille: .4,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Mars',
                                            taille: .85),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert2,
                                            mois: 'AVril',
                                            taille: .4),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert,
                                          mois: 'Mai',
                                          taille: .6,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Juin',
                                            taille: .3),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Juilliet',
                                          taille: .6,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Aout',
                                            taille: .7),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Septembre',
                                          taille: .4,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Octobre',
                                            taille: .6),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                          color: vert2,
                                          mois: 'Novembre',
                                          taille: .7,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .01,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxHeight * .2,
                                        child: FieldDataMoth(
                                            color: vert,
                                            mois: 'Décembre',
                                            taille: .6),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: blanc2,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )),
                          )),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: blanc, borderRadius: BorderRadius.circular(8)),
              )),
          MenuLeftHome(
            choice: 1,
          )
        ],
      ),
    );
  }
}
