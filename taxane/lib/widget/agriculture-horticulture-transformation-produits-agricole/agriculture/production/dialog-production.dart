import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/agriculture-hortoculture.dart';
import 'package:taxane/utils/color-by-dii.dart';

addProduction({required BuildContext context , required String idChamps}) {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) {
    TextEditingController code =
                TextEditingController();
            TextEditingController nomProduit =
                TextEditingController();
                   TextEditingController quantite =
                TextEditingController();
    return AlertDialog(
    content: Container(
      height: size.height * .6,
      width: size.width * .5,
      child: Column(
        children: [
Spacer(),
                    Container(
                      height: size.height * .1,
                      child: Center(
                        child: Text(
                          'Formulaire d\'ajout de production',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: noir,
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: code,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Code Production',
                              icon: Icon(CupertinoIcons.globe)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                   Container(
                          height: size.height * .04,
                          width: size.width * .4,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Produit / '),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("cultures").snapshots(),
                                    builder: (context, snaps) {
                                      return !snaps.hasData ? Container() : StatefulBuilder(
                                        builder: (context, setState) =>
                                            DropdownButton<String>(
                                                value:agricultureHortocultureState.idproduit,
                                                underline: Container(),
                                                onChanged: (String? newValue) async {
                                                 setState((){
                                                  // ignore: invalid_use_of_protected_member
                                                  agricultureHortocultureState.setState(() {
                                                    agricultureHortocultureState.idproduit = newValue!;
                                                  });
                                                  FirebaseFirestore.instance.collection('cultures').doc(agricultureHortocultureState.idproduit).get().then((value) {
                                                    setState((){
                                                         agricultureHortocultureState.setState(() {
                                                    agricultureHortocultureState.produit = value.get("nom");
                                                  });
                                                    });
                                                  });
                                                 });
                                                },
                                                items: snaps.data!.docs.toList().map((e) => DropdownMenuItem(
                                                  value: e.id,
                                                  child: Text(e.get('nom')))).toList()
                                            ),
                                      );
                                    }
                                  ),
                                ],
                              )),
                          decoration: BoxDecoration(
                              border: Border.all(color: vert),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                     SizedBox(
                      height: size.height * .05,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: quantite,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Quantité Produit en (kg)',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: size.height * .1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        FirebaseFirestore.instance.collection("productions").add({
                          "code" : code.text,
                          "nomProduit" : agricultureHortocultureState.produit,
                          "idProduit" : agricultureHortocultureState.idproduit,
                          "quantite" : quantite.text,
                          "champs" : idChamps,
                          "date" : DateTime.now()
                        }).then((value) => Navigator.pop(context)); 
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
  );
  });
}