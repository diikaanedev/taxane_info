import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/gestion-des-membres/admin_gestion_membres.dart';

Widget getMenuAdRole2({required BoxConstraints constraints , required BuildContext context , required String idRegroupement})  {
  return Column(
    children: [
      Spacer(),
      Container(
        height: constraints.maxHeight * .25,
        child: Row(
          children: [
            // Spacer(),
            Spacer(),
            GestureDetector(
              onTap: () => adminGestionMembres(context: context, idRegroupement: idRegroupement),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des membres ',
                    style: TextStyle(
                        fontSize: constraints.maxHeight * .02,
                        fontWeight: FontWeight.w800,
                        color: blanc),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: jaune,
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () =>null,
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestions des Evenements ',
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
    ],
  );
}
