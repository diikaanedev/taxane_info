import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:taxane/widget/admin-commune.dart';
import 'package:taxane/widget/admin-departement.dart';
import 'package:taxane/widget/admin-regions.dart';
import 'package:taxane/widget/admin-village.dart';

Widget getMenuAd({required BoxConstraints constraints , required BuildContext context}) {
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
              onTap: () => adminRegion(context: context, idPays: administrationFoncierState.paysSelected),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des Régions',
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
              onTap: () => adminDepartement(context: context),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des Départements',
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
              onTap: () => adminCommune(context: context),
              child: Container(
                width: constraints.maxWidth * .3,
                child: Center(
                  child: Text(
                    'Gestion des communes',
                    style: TextStyle(
                        fontSize: constraints.maxHeight * .02,
                        fontWeight: FontWeight.w800,
                        color: blanc),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: vert,
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => adminVillage(context: context),
              child: Container(
                width: constraints.maxWidth * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: jaune,
                ),
                child: Center(
                  child: Text(
                    'Gestion des Villages / Quartiers',
                    style: TextStyle(
                        fontSize: constraints.maxHeight * .02,
                        fontWeight: FontWeight.w800,
                        color: blanc),
                  ),
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
