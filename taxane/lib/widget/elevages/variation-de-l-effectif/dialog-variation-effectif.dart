import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/elevage.dart';
import 'package:taxane/utils/color-by-dii.dart';

editBete({required BuildContext context , required String idBete}) async {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) {

   

    return  AlertDialog(
    content: Container(
      height: size.height * .7,
      width: size.width * .3,
      child: ListView(
        children: [
           Spacer(),
                    Container(
                      height: size.height * .1,
                      child: Center(
                        child: Text(
                          'Formulaire d\'edition d\'espece animal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: noir,
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                   
                   SizedBox(height: size.height * .02,),
                  

                   
                    GestureDetector(
                      onTap: () async {
                        
                         
                       
                      },  
                      child: Container(
                        height: size.height * .05,
                        width: size.width * .2,
                        child: Center(
                          child: Text(
                            'Ajouter',
                            style: TextStyle(
                                color: jaune, fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: jaune),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Spacer(),
        ],
      ),
    ),
     actions: [
                RaisedButton(
                    color: rouge,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "   Fermer   ",
                      style: TextStyle(
                          fontSize: size.height * .015,
                          fontWeight: FontWeight.bold,
                          color: blanc),
                    ))
              ],
  );
  });
}