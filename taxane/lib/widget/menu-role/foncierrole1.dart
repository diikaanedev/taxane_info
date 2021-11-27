import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/admin-concession.dart';
import 'package:taxane/widget/admin-domaine.dart';
import 'package:taxane/widget/admin-menage.dart';
import 'package:taxane/widget/admin-regroupement.dart';

Widget foncierRole1(
    {required BoxConstraints constraints, required BuildContext context}) {
  return Column(
    children: [
      Spacer(),
      // Container(
      //   height:
      //       constraints.maxHeight *
      //           .25,
      //   color: jaune,
      //   child: Row(
      //     children: [
      //       // Spacer(),
      //       Spacer(),

      //       Spacer(),
      //     ],
      //   ),
      // ),
      // Spacer(),
      Container(
        height: constraints.maxHeight * .25,
        // color: vert,
        child: Row(
          children: [
            Spacer(),
            GestureDetector(
              onTap: () => adminRegouprement(context: context),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des Regroupemments / Associations',
                    style: TextStyle(
                        fontSize: constraints.maxHeight * .02,
                        fontWeight: FontWeight.w800,
                        color: blanc),
                  ),
                ),
                decoration: BoxDecoration(
                    color: vert, borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => AdminConcession(context: context),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des Concessions / Villa',
                    style: TextStyle(
                        fontSize: constraints.maxHeight * .02,
                        fontWeight: FontWeight.w800,
                        color: blanc),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: rouge,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      Spacer(),
      Container(
        height: constraints.maxHeight * .25,
        child: Row(
          children: [
            Spacer(),
            GestureDetector(
              onTap: () => adminMenage(context: context),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des Ménages',
                    style: TextStyle(
                        fontSize: constraints.maxHeight * .02,
                        fontWeight: FontWeight.w800,
                        color: blanc),
                  ),
                ),
                decoration: BoxDecoration(
                    color: jaune, borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => adminDomaine(context: context),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des Domaines ou Lots',
                    style: TextStyle(
                        fontSize: constraints.maxHeight * .02,
                        fontWeight: FontWeight.w800,
                        color: blanc),
                  ),
                ),
                decoration: BoxDecoration(
                    color: rouge, borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      Spacer(),
    ],
  );
}
