import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/menu-left-home.dart';

class EquipementCollectif extends StatefulWidget {
  const EquipementCollectif({Key? key}) : super(key: key);

  @override
  _EquipementCollectifState createState() => _EquipementCollectifState();
}

class _EquipementCollectifState extends State<EquipementCollectif> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
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
                        builder: (context, constraints) => Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultTabController(
                                length: 1,
                                child: Scaffold(
                                  appBar: AppBar(
                                    elevation: .0,
                                    leading: Container(),
                                    backgroundColor: blanc,
                                    toolbarHeight: constraints.maxHeight * .07,
                                    bottom: TabBar(
                                      indicatorColor: vert,
                                      tabs: [
                                        Tab(
                                            icon: Container(
                                          width: constraints.maxWidth * .3,
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                'Equipement Collectif',
                                                style: TextStyle(
                                                    color: vert,
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            .02,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .03,
                                              ),
                                              Icon(
                                                CupertinoIcons.person_3_fill,
                                                color: vert,
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        )),
                                       
                                      ],
                                    ),
                                  ),
                                  body: TabBarView(
                                    children: [
                                      
                                      // Foncier by dii
                                      Container(
                                        color: rouge,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          decoration: BoxDecoration(
                              color: blanc,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: blanc, borderRadius: BorderRadius.circular(8)),
                    )),
           MenuLeftHome(
                  choice: 3,
                )
        ],
      ),
    );
  }
}
