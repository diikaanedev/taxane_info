import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> getDocs({required String collection}) async =>
    FirebaseFirestore.instance.collection(collection).get();

Future<DocumentSnapshot> getDoc(
        {required String collection, required String id}) async =>
    FirebaseFirestore.instance.collection(collection).doc(id).get();

Future getNumber({required String idRegion, required String idCulture}) async {
  int i = 0;
  print(idRegion =="3B4NgcSbQz2O4Rib3m7M");

  // return getDocs(collection: "regions").then((regions) async {
  //   for (var itemR in regions.docs) {
  //     if (itemR.get("pays") == idRegion) {
        
  //     }
  //   }
    
  // });

  return getDocs(collection: "departements").then((departements) async {
    for (var itemD in departements.docs) {
      if (itemD.get("regions") == "3B4NgcSbQz2O4Rib3m7M") {
        await getDocs(collection: "communes").then((communes) async {
          for (var itemC in communes.docs) {
            if (itemC.get("departements") == itemD.id) {
              await getDocs(collection: "villages").then((villages) async {
                for (var itemV in villages.docs) {
                  if (itemV.get("communes") == itemC.id) {
                    await getDocs(collection: "champs").then((champs) async {
                      for (var itemCH in champs.docs) {
                        if (itemCH.get("village") == itemV.id) {
                          await getDocs(collection: "productions")
                              .then((productions) {
                            for (var itemP in productions.docs) {
                              if (itemP.get("champs") == itemCH.id &&
                                  itemP.get("idProduit") == idCulture) {
                                i += int.parse(itemP.get("quantiteInitial"));
                              }
                            }
                          });
                        }
                      }
                    });
                  }
                }
              });
            }
          }
        });
      }
    }
    print(i);
    return i;
  });
}






// }); 
    // return getDocs(collection: "departements").then((departements) async {
    //   for (var itemD in departements.docs) {
    //     if (itemD.get("regions") == idRegion) {
    //       print("je suis las ${itemD.get("nom")}");
    //       await getDocs(collection: "communes").then((communes) async {
    //         print("je suis la aussi");
    //         for (var itemC in communes.docs) {
    //           print("je en dj ${itemC.id == itemD.id}");
    //           if (itemC.get("departements") == itemD.id) {
    //             print("encore je suis ici");
    //             await getDocs(collection: "villages").then((villages) async {
    //               for (var itemV in villages.docs) {
    //                 if (itemV.get("communes") == itemC.id) {
    //                   await getDocs(collection: "champs").then((champs) async {
    //                     for (var itemCH in champs.docs) {
    //                       if (itemCH.get("village") == itemV.id) {

    //                       }
    //                     }
    //                   });
    //                 }
    //               }
    //             });
    //           }
    //         }
    //       });
    //     }
    //   }

// return FirebaseFirestore.instance
//                           .collection("productions")
//                           .get()
//                           .then((productions) {
//                         for (var item in productions.docs) {
//                           i += int.parse(item.get("quantiteInitial"));
//                         }
//                         return i;
//                       });

// for (var itemD in depertements.docs) {
//       if (itemD.get("regions") == id) {
//         return FirebaseFirestore.instance
//             .collection("communes")
//             .get()
//             .then((communes) {
//           for (var itemC in communes.docs) {
//             if (itemC.get("departements") == itemD.id) {
//               return FirebaseFirestore.instance
//                   .collection("villages")
//                   .get()
//                   .then((villages) {
//                 for (var itemV in villages.docs) {
//                   if (itemV.get("communes") == itemC.id) {
//                     return FirebaseFirestore.instance
//                         .collection("champs")
//                         .get()
//                         .then((champs) {
//                       for (var itemCH in champs.docs) {
//                         return FirebaseFirestore.instance
//                             .collection("productions")
//                             .get()
//                             .then((productions) {
//                               for (var itemP in productions.docs) {
//                                 if (itemP.get("champs")==itemCH.id) {
//                                   return itemP.get("quantiteInitial");
//                                 }
//                               }
//                             });
//                       }
//                     });
//                   }
//                 }
//               });
//             }
//           }
//         });
//       }
//     }
