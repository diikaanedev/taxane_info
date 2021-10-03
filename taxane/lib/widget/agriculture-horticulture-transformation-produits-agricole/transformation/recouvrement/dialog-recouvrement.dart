import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/agriculture-hortoculture.dart';
import 'package:taxane/utils/color-by-dii.dart';

addRecouvrement({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) {
    TextEditingController code =
                TextEditingController();
                   TextEditingController quantite =
                TextEditingController();
                TextEditingController matriculeM_pt_vente =
                TextEditingController();
                    TextEditingController prix_unitaire =
                TextEditingController();
                            TextEditingController prix_verse =
                TextEditingController();
    return AlertDialog(
    content: Container(
      height: size.height * .8,
      width: size.width * .5,
      child: Column(
        children: [
                    Container(
                      height: size.height * .07,
                      child: Center(
                        child: Text(
                          'Formulaire d\'ajout de Recouvrement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: noir,
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
                              labelText: 'code recouvrement',
                              icon: Icon(CupertinoIcons.globe)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: size.height * .01,
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
                      height: size.height * .01,
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
                              labelText: 'quantité Produit en (kg)',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                     SizedBox(
                      height: size.height * .01,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: matriculeM_pt_vente,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'matricule point de vente ',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                     
                   
                      SizedBox(
                      height: size.height * .01,
                    ),
                   
                    
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: prix_unitaire,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'prix unitaire ',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                     SizedBox(
                      height: size.height * .01,
                    ),
                   
                    
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: prix_verse,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'prix total ',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                     GestureDetector(
                      onTap: () async {
                         FirebaseFirestore.instance.collection('point-de-ventes').get().then((value)  {
                             String idPtDeVente = 'nothing';
                             
                              print(matriculeM_pt_vente.text.toLowerCase().trim());
                              for (var item in value.docs) {
                                  if (item.get("code").toString().toLowerCase().trim() == matriculeM_pt_vente.text.toLowerCase().trim()) {
                                 idPtDeVente = item.get('code');
                               } 
                              }

                           
                            if (idPtDeVente !='nothing') {
                               FirebaseFirestore.instance.collection("recouvrements").add({
                                "code" :code.text,
                                "point-de-vente" : idPtDeVente,
                                "produit": agricultureHortocultureState.produit,
                                "idProduit" : agricultureHortocultureState.idproduit,
                                "prix_unitaire" : prix_unitaire.text,
                                "prix_verse" : prix_verse.text,
                                "date": DateTime.now()
                              }).then((value) => Navigator.pop(context));
                            }
                           

                           });
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
                    Spacer(),
        ],
      ),
    ),
  );
  });
}

