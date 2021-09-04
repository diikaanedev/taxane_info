import 'package:flutter/material.dart';

class FieldDataMoth extends StatelessWidget {
  final double taille;
  final String mois;
  final Color color;
  const FieldDataMoth(
      {Key? key, required this.taille, required this.mois, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Spacer(),
          Container(
            height: constraints.maxHeight * taille,
            color: color,
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Text(mois)
        ],
      ),
    );
  }
}
