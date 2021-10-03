import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/menu-letf.dart';

class MenuLeftHome extends StatelessWidget {
  final int choice;
  const MenuLeftHome({
    Key? key,
    required this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
        top: size.height * .015,
        child: Container(
          width: size.width * .2,
          height: size.height * .97,
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                Container(
                  height: constraints.maxHeight * .05,
                  width: constraints.maxWidth,
                  child: Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * .05,
                      ),
                      Text(
                        'Taxan-info',
                        style: TextStyle(
                            color: blanc,
                            fontSize: constraints.maxHeight * .02,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: vert,
                        radius: constraints.maxWidth * .05,
                        backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/taxane-info.appspot.com/o/logo%2FLOGO%20FOCUS.jpg?alt=media&token=2d710f10-d0b6-4e8f-a414-27f0c0c2027f',
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * .1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * .05,
                ),
                CircleAvatar(
                  radius: constraints.maxHeight * .05,
                  backgroundColor: vert,
                  backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Cropscientist.jpg/1200px-Cropscientist.jpg'),
                ),
                SizedBox(
                  height: constraints.maxHeight * .01,
                ),
                Text(
                  'root@root.sn',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxHeight * .02,
                      color: blanc),
                ),
                SizedBox(
                  height: constraints.maxHeight * .01,
                ),
                Text(
                  'Manager Général',
                  style: TextStyle(color: blanc),
                ),
                SizedBox(
                  height: constraints.maxHeight * .05,
                ),
                Container(
                  height: constraints.maxHeight * .05,
                  width: constraints.maxWidth,
                  child: GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(context, "/home"),
                    child: MenuLeft(
                        test: "Home",
                        icon: CupertinoIcons.home,
                        isSelect: choice == 1),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * .01,
                ),
                GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(context, "/administration-foncier"),
                  child: Container(
                    height: constraints.maxHeight * .05,
                    width: constraints.maxWidth,
                    child: MenuLeft(
                        test: 'Administration & Foncier',
                        icon: CupertinoIcons.person_3_fill,
                        isSelect: choice == 2),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * .01,
                ),
                GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(context, "/equipement-collectif"),
                  child: Container(
                      height: constraints.maxHeight * .05,
                      width: constraints.maxWidth,
                      child: MenuLeft(
                        test: 'Equipements Collectifs',
                        icon: CupertinoIcons.map_pin_ellipse,
                        isSelect: choice == 3,
                      )),
                ),
                SizedBox(
                  height: constraints.maxHeight * .01,
                ),
                Container(
                  height: constraints.maxHeight * .05,
                  width: constraints.maxWidth,
                  child: GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(context, "/agriculture-horticulture"),
                    child: MenuLeft(
                        test: 'Agriculture & Horticulture',
                        icon: CupertinoIcons.leaf_arrow_circlepath,
                        isSelect: choice == 4),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * .01,
                ),
                Container(
                  height: constraints.maxHeight * .05,
                  width: constraints.maxWidth,
                  child: GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(context, "/elevage"),
                    child: MenuLeft(
                        test: 'Élevage',
                        icon: CupertinoIcons.home,
                        isSelect: choice == 5),
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Container(
                  height: constraints.maxHeight * .3,
                  width: constraints.maxWidth * .8,
                  child: Column(
                    children: [
                      Spacer(),
                      Text('25 NOVEMBRE'),
                      Spacer(),
                      Container(
                        height: constraints.maxHeight * .04,
                        width: constraints.maxWidth * .7,
                        child: MenuLeft(
                            test: 'Violence Basée sur le Genre',
                            icon: Icons.baby_changing_station_rounded,
                            isSelect: choice == 6),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .02,
                      ),
                      Container(
                        height: constraints.maxHeight * .04,
                        width: constraints.maxWidth * .7,
                        child: MenuLeft(
                            test: 'Mortalité Maternelle',
                            icon: Icons.female,
                            isSelect: choice == 7),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .02,
                      ),
                      Container(
                        height: constraints.maxHeight * .04,
                        width: constraints.maxWidth * .7,
                        child: MenuLeft(
                            test: 'Mortalité Infantile',
                            icon: Icons.child_care,
                            isSelect: choice == 8),
                      ),
                      Spacer(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: vert3,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }
}
