import 'package:flutter/cupertino.dart';
import 'package:taxane/utils/color-by-dii.dart';

Widget getHeader(
    {required BuildContext context,
    required List<String> titles,
    required double width,
    required BoxConstraints constraints}) {
  List<Container> listes = [];

  for (var item in titles) {
    listes.add(Container(
        height: constraints.maxHeight * .05,
        // color: bleu,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Text(
              item,
              style: TextStyle(
                  color: noir.withOpacity(.8), fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        )));
  }

  return Container(
    width: constraints.maxWidth,
    child: Row(
      children: listes,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ),
  );
}

Widget getRowTable(
    {required BuildContext context,
    required List<String> titles,
    required double heigth,
    required double width,
    required int choixColor,
    required BoxConstraints constraints})  {
  List<Container> listes = [];
  int i = 0;
  Color color = noir;
  for (var item in titles) {
    i++;

    if (i == choixColor) {
      if (item.toLowerCase() == "active" || item.toLowerCase() == "success") {
        color = vert;
      } else {
        color = rouge;
      }
    }

    listes.add(Container(
        height: heigth,
        width: width,
        // color: bleu,
        child: Row(
          children: [
            SizedBox(
              width: width * .04,
            ),
            Text(
              item,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        )));

    color = noir;
  }

  listes.add(
    Container(
        height: heigth,
        width: width * .4,
        child: Row(
          children: [
            
            Icon(CupertinoIcons.eye, color: noir.withOpacity(.8)),
            Spacer(),
          ],
        )),
  );

  return Row(children: listes);
}
