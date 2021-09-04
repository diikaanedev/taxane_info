import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

class CardMenuHome extends StatelessWidget {
  final String title, nombre;
  final IconData icon;
  const CardMenuHome({
    Key? key,
    required this.title,
    required this.nombre,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Spacer(),
            CircleAvatar(
              backgroundColor: jaune,
              radius: constraints.maxWidth * .07,
              child: Center(
                child: Icon(
                  icon,
                  size: constraints.maxWidth * .05,
                  color: vert,
                ),
              ),
            ),
            Container(
                width: constraints.maxWidth * .6,
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                          color: gris3, fontSize: constraints.maxWidth * .05),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * .01,
                    ),
                    Text(
                      nombre,
                      style: TextStyle(
                          color: gris3, fontSize: constraints.maxWidth * .05),
                    ),
                    Spacer(),
                  ],
                )),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
