import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> getDocs({required String collection}) async =>
    FirebaseFirestore.instance.collection(collection).get();

Future<DocumentSnapshot> getDoc(
        {required String collection, required String id}) async =>
    FirebaseFirestore.instance.collection(collection).doc(id).get();

Future getNumberProduits({required String idRegion, required String idCulture}) async {
  int i = 0;
  

  return getDocs(collection: "departements").then((departements) async {
    for (var itemD in departements.docs) {
      if (itemD.get("regions") == idRegion) {
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

Future getNumberMateriels({required String idRegion, required String idMaterial}) async {
  int i = 0;
  

  return getDocs(collection: "departements").then((departements) async {
    for (var itemD in departements.docs) {
      if (itemD.get("regions") == idRegion) {
        await getDocs(collection: "communes").then((communes) async {
          for (var itemC in communes.docs) {
            if (itemC.get("departements") == itemD.id) {
              await getDocs(collection: "villages").then((villages) async {
                for (var itemV in villages.docs) {
                  if (itemV.get("communes") == itemC.id) {
                    await getDocs(collection: "champs").then((champs) async {
                      for (var itemCH in champs.docs) {
                        if (itemCH.get("village") == itemV.id) {
                          await getDocs(collection: "materiels-champs")
                              .then((materielChamps) {
                            for (var itemP in materielChamps.docs) {
                              if (itemP.get("champs") == itemCH.id &&
                                  itemP.get("materiel") == idMaterial) {
                                i += 1;
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

Future getNumberEspecspe({required String idRegion, required String idEspece}) async {
  int i = 0;
  

  return getDocs(collection: "departements").then((departements) async {
    for (var itemD in departements.docs) {
      if (itemD.get("regions") == idRegion) {
        await getDocs(collection: "communes").then((communes) async {
          for (var itemC in communes.docs) {
            if (itemC.get("departements") == itemD.id) {
              await getDocs(collection: "villages").then((villages) async {
                for (var itemV in villages.docs) {
                  if (itemV.get("communes") == itemC.id) {
                    await getDocs(collection: "betes").then((betes) async {
                      for (var itemBete in betes.docs) {
                        if (itemBete.get("village") == itemV.id && itemBete.get("idAnimal") == idEspece) {
                          i += 1;
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

Future getNumberMortalite({required String idRegion,   required String type}) async {
  int i = 0;
  


  return getDocs(collection: "departements").then((departements) async {
    for (var itemD in departements.docs) {
      if (itemD.get("regions") == idRegion) {
        await getDocs(collection: "communes").then((communes) async {
          for (var itemC in communes.docs) {
            if (itemC.get("departements") == itemD.id) {
              await getDocs(collection: "villages").then((villages) async {
                for (var itemV in villages.docs) {
                  if (itemV.get("communes") == itemC.id) {
                    await getDocs(collection: type).then((mortalites) async {
                      for (var itemMortalite in mortalites.docs) {
                        if (itemMortalite.get("village") == itemV.id ) {
                          i += 1;
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

Future getNumberViolence({required String idRegion}) async {
  int i = 0;
  


  return getDocs(collection: "departements").then((departements) async {
    for (var itemD in departements.docs) {
      if (itemD.get("regions") == idRegion) {
        await getDocs(collection: "communes").then((communes) async {
          for (var itemC in communes.docs) {
            if (itemC.get("departements") == itemD.id) {
              await getDocs(collection: "villages").then((villages) async {
                for (var itemV in villages.docs) {
                  if (itemV.get("communes") == itemC.id) {
                    await getDocs(collection: "violence-basee-sur-le-genre").then((mortalites) async {
                      for (var itemMortalite in mortalites.docs) {
                        if (itemMortalite.get("village") == itemV.id ) {
                          i += 1;
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




