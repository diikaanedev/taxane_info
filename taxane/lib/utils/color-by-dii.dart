import 'dart:convert';

import 'package:flutter/material.dart';

Color vert = Color.fromRGBO(58, 130, 96, 1);
Color rouge = Color.fromRGBO(122, 64, 61, 1);
Color noir = Color.fromRGBO(16, 28, 45, 1);
Color gris = Color.fromRGBO(122, 129, 167, 1);
Color gris2 = Color.fromRGBO(249, 249, 249, 1);
Color gris3 = Color.fromRGBO(117, 117, 117, 1);

Color vert2 = Color.fromRGBO(190, 213, 41, 1);
Color vert3 = Color.fromRGBO(70, 156, 116, 1);
Color blanc = Color.fromRGBO(255, 255, 255, 1);
Color blanc2 = Color.fromRGBO(247, 247, 247, 1);

Color beige = Color.fromRGBO(255, 242, 230, 1);
Color jaune = Color.fromRGBO(254, 204, 73, 1);

String dateFormatter(DateTime date) {
  dynamic dayData =
      '{ "1" : "Lundi", "2" : "Mardi", "3" : "Mercredi", "4" : "Jeudi", "5" : "Vendredi", "6" : "Samedi", "7" : "Dimanche" }';

  dynamic monthData =
      '{ "1" : "Janvier", "2" : "Fevrier", "3" : "Mars", "4" : "Avril", "5" : "Mai", "6" : "Juin", "7" : "Julliet", "8" : "Aout", "9" : "Septembre", "10" : "Octobre", "11" : "Novembre", "12" : "Décembre" }';

  // return date.toString();
  return json.decode(dayData)['${date.weekday}'] +
      " " +
      date.day.toString() +
      " " +
      json.decode(monthData)['${date.month}'];
  // " " +
  // date.year.toString() +
  // " à " +
  // date.hour.toString() +
  // "h:" +
  // date.minute.toString() +
  // "min";
  // return [
  //   json.decode(monthData)['${date.month}'],
  //   date.day.toString(),
  //   date.year.toString(),
  //   json.decode(dayData)['${date.weekday}'],
  // ];
}

String dateFormatterComplet(DateTime date) {
  dynamic dayData =
      '{ "1" : "Lundi", "2" : "Mardi", "3" : "Mercredi", "4" : "Jeudi", "5" : "Vendredi", "6" : "Samedi", "7" : "Dimanche" }';

  dynamic monthData =
      '{ "1" : "Janvier", "2" : "Fevrier", "3" : "Mars", "4" : "Avril", "5" : "Mai", "6" : "Juin", "7" : "Julliet", "8" : "Aout", "9" : "Septembre", "10" : "Octobre", "11" : "Novembre", "12" : "Décembre" }';

  // return date.toString();
  return json.decode(dayData)['${date.weekday}'] +
      " " +
      date.day.toString() +
      " " +
      json.decode(monthData)['${date.month}'] +
      " " +
      date.year.toString();
  // " " +
  // date.year.toString() +
  // " à " +
  // date.hour.toString() +
  // "h:" +
  // date.minute.toString() +
  // "min";
  // return [
  //   json.decode(monthData)['${date.month}'],
  //   date.day.toString(),
  //   date.year.toString(),
  //   json.decode(dayData)['${date.weekday}'],
  // ];
}
