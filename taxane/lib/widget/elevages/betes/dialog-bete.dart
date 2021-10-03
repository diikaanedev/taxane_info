import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/elevage.dart';
import 'package:taxane/utils/color-by-dii.dart';

addBete({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  showDialog(context: context, builder: (context) {
      TextEditingController code =
                TextEditingController();
            TextEditingController matricule_troupeaux =
                TextEditingController();
                TextEditingController race =
                TextEditingController();
                 TextEditingController couleur =
                TextEditingController();

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
                          'Formulaire d\'ajout d\'espece animal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: noir,
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
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
                                  Text('Animal / '),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("animaux").snapshots(),
                                    builder: (context, snaps) {
                                      return !snaps.hasData ? Container() : StatefulBuilder(
                                        builder: (context, setState) =>
                                            DropdownButton<String>(
                                                value:elevageState.espece_animale,
                                                underline: Container(),
                                                onChanged: (String? newValue) async {
                                                 setState((){
                                                  // ignore: invalid_use_of_protected_member
                                                  elevageState.setState(() {
                                                    elevageState.espece_animale = newValue!;
                                                  });
                                                  FirebaseFirestore.instance.collection('animaux').doc(elevageState.espece_animale).get().then((value) {
                                                    setState((){
                                                         elevageState.setState(() {
                                                    elevageState.nom_espace_animl = value.get("nom");
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
                      height: size.height * .02,
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
                              labelText: 'Code animal',
                              icon: Icon(CupertinoIcons.globe)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: race,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Race animal',
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
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: couleur,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Couleur animal',
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
                     StatefulBuilder(
                      builder: (context ,  setState) => Container(
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: GestureDetector(
                            onTap: () async {
                              await showDatePicker(
                              context: context,
                              initialDate: elevageState.dateNaiss,
                              initialDatePickerMode: DatePickerMode.day,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030)).then((value) => setState((){
                                elevageState.dateNaiss = value!;
                              }));                      
                            },
                    
                            child: Column(
                              children: [
                                Spacer(),
                                Container(
                        width: size.width * .4,
                    
                                  child: Text('Date de Naissance : ${elevageState.dateNaiss.day.toString()}/${elevageState.dateNaiss.month.toString()}/${elevageState.dateNaiss.year.toString()}')),
                                Spacer(),
                    
                              ],
                            ),
                            
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: vert),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          cursorColor: vert,
                          controller: matricule_troupeaux,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Matricule troupeaux',
                              icon: Icon(CupertinoIcons.map)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: vert),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    
                      SizedBox(
                      height: size.height * .05,
                    ),
                    GestureDetector(
                      onTap: () async {
                        
                         FirebaseFirestore.instance.collection('troupeaux').get().then((value)  {
                             String idMembre = 'nothing';
                             
                              print(matricule_troupeaux.text.toLowerCase().trim());
                              for (var item in value.docs) {
                                  if (item.get("code").toString().toLowerCase().trim() == matricule_troupeaux.text.toLowerCase().trim()) {
                                 idMembre = item.get('code');
                               } 
                              }

                           
                            if (idMembre !='nothing') {

                               FirebaseFirestore.instance.collection("betes").add({
                                  "code" : code.text,
                                  "race" : race.text,
                                  "couleur" : couleur.text,
                                  "idAnimal" : elevageState.espece_animale,
                                  "animal" : elevageState.nom_espace_animl,
                                  "dateNaiss" :  elevageState.dateNaiss,
                                  "troupeaux" : idMembre,
                                  "date" : DateTime.now()
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