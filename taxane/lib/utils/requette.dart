import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> getDocs({required String collection}) async =>
    FirebaseFirestore.instance.collection(collection).get();

Future<DocumentSnapshot> getDoc(
        {required String collection, required String id}) async =>
    FirebaseFirestore.instance.collection(collection).doc(id).get();

Future getNumberProduits(
    {required String idRegion, required String idCulture}) async {
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

Future getNumberProduitsRegion(
    {required String idDept, required String idCulture}) async {
  int i = 0;

  return getDocs(collection: "communes").then((communes) async {
    for (var itemC in communes.docs) {
      if (itemC.get("departements") == idDept) {
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
    print(i);
    return i;
  });
}

Future getNumberProduitsDepartement(
    {required String idCommune, required String idCulture}) async {
  int i = 0;

  return getDocs(collection: "villages").then((villages) async {
    for (var itemV in villages.docs) {
      if (itemV.get("communes") == idCommune) {
        await getDocs(collection: "champs").then((champs) async {
          for (var itemCH in champs.docs) {
            if (itemCH.get("village") == itemV.id) {
              await getDocs(collection: "productions").then((productions) {
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
    print(i);
    return i;
  });
}

Future getNumberProduitsCommunes(
    {required String idVillage, required String idCulture}) async {
  int i = 0;

  // return getDocs(collection: "villages").then((villages) async {
  //   for (var itemV in villages.docs) {
  //     if (itemV.get("communes") == idCommune) {

  //     }
  //   }

  // });

  return getDocs(collection: "champs").then((champs) async {
    for (var itemCH in champs.docs) {
      if (itemCH.get("village") == idVillage) {
        await getDocs(collection: "productions").then((productions) {
          for (var itemP in productions.docs) {
            if (itemP.get("champs") == itemCH.id &&
                itemP.get("idProduit") == idCulture) {
              i += int.parse(itemP.get("quantiteInitial"));
            }
          }
        });
      }
    }
    print(i);
    return i;
  });
}

Future getNumberProduitsVillage(
    {required String idRegroupement,
    required String idVillage,
    required String idCulture}) async {
  int i = 0;

  return getDocs(collection: "membres").then((membres) async {
    for (var itemMembres in membres.docs) {
      if (itemMembres.get("regroupements") == idRegroupement) {
        await getDocs(collection: "champs").then((champs) async {
          for (var itemChamp in champs.docs) {
            if (itemChamp.get("membre") == itemMembres.id) {
              await getDocs(collection: "productions").then((productions) {
                for (var itemP in productions.docs) {
                  if (itemP.get("champs") == itemChamp.id &&
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
    print(i);
    return i;
  });
}

Future getNumberMateriels(
    {required String idRegion, required String idMaterial}) async {
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

Future getNumberMaterielRegion(
    {required String idDept, required String idMateriel}) {
  int i = 0;

  return getDocs(collection: "communes").then((communes) async {
    for (var itemC in communes.docs) {
      if (itemC.get("departements") == idDept) {
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
                            itemP.get("materiel") == idMateriel) {
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

Future getNumberMaterielDepartement(
    {required String idCommune, required String idMateriel}) {
  int i = 0;

  return getDocs(collection: "villages").then((villages) async {
    for (var itemV in villages.docs) {
      if (itemV.get("communes") == idCommune) {
        await getDocs(collection: "champs").then((champs) async {
          for (var itemCH in champs.docs) {
            if (itemCH.get("village") == itemV.id) {
              await getDocs(collection: "materiels-champs")
                  .then((materielChamps) {
                for (var itemP in materielChamps.docs) {
                  if (itemP.get("champs") == itemCH.id &&
                      itemP.get("materiel") == idMateriel) {
                    i += 1;
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

Future getNumberMaterielCommune(
    {required String idVillage, required String idMateriel}) {
  int i = 0;

  return getDocs(collection: "champs").then((champs) async {
    for (var itemCH in champs.docs) {
      if (itemCH.get("village") == idVillage) {
        await getDocs(collection: "materiels-champs").then((materielChamps) {
          for (var itemP in materielChamps.docs) {
            if (itemP.get("champs") == itemCH.id &&
                itemP.get("materiel") == idMateriel) {
              i += 1;
            }
          }
        });
      }
    }
    print(i);
    return i;
  });
}

Future getNumberMaterielVillage(
    {required String idVillage,
    required String idMateriel,
    required String idRegroupement}) {
  int i = 0;

  return getDocs(collection: "membres").then((membres) async {
    for (var itemMembres in membres.docs) {
      if (itemMembres.get("regroupements") == idRegroupement) {
        await getDocs(collection: "champs").then((champs) async {
          for (var itemChamp in champs.docs) {
            if (itemChamp.get("membre") == itemMembres.id) {
              await getDocs(collection: "materiels-champs")
                  .then((materielChamps) {
                for (var itemP in materielChamps.docs) {
                  if (itemP.get("champs") == itemChamp.id &&
                      itemP.get("materiel") == idMateriel) {
                    i += 1;
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

Future getNumberEspecspe(
    {required String idRegion, required String idEspece}) async {
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
                        if (itemBete.get("village") == itemV.id &&
                            itemBete.get("idAnimal") == idEspece) {
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

Future getNumberEspecspeRegion(
    {required String idDept, required String idEspece}) async {
  int i = 0;

  return getDocs(collection: "communes").then((communes) async {
    for (var itemC in communes.docs) {
      if (itemC.get("departements") == idDept) {
        await getDocs(collection: "villages").then((villages) async {
          for (var itemV in villages.docs) {
            if (itemV.get("communes") == itemC.id) {
              await getDocs(collection: "betes").then((betes) async {
                for (var itemBete in betes.docs) {
                  if (itemBete.get("village") == itemV.id &&
                      itemBete.get("idAnimal") == idEspece) {
                    i += 1;
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

Future getNumberEspecspeDepartement(
    {required String idCommune, required String idEspece}) async {
  int i = 0;

  return getDocs(collection: "villages").then((villages) async {
    for (var itemV in villages.docs) {
      if (itemV.get("communes") == idCommune) {
        await getDocs(collection: "betes").then((betes) async {
          for (var itemBete in betes.docs) {
            if (itemBete.get("village") == itemV.id &&
                itemBete.get("idAnimal") == idEspece) {
              i += 1;
            }
          }
        });
      }
    }
    print(i);
    return i;
  });
}

Future getNumberEspecspeCommune(
    {required String idVillage, required String idEspece}) async {
  int i = 0;

  return getDocs(collection: "betes").then((betes) async {
    for (var itemBete in betes.docs) {
      if (itemBete.get("village") == idVillage &&
          itemBete.get("idAnimal") == idEspece) {
        i += 1;
      }
    }
    print(i);
    return i;
  });
}

Future getNumberEspecspeVillage(
    {required String idVillage,
    required String idEspece,
    required String idRegroupement}) async {
  int i = 0;

  return getDocs(collection: "membres").then((membres) async {
    for (var itemMembres in membres.docs) {
      if (itemMembres.get("regroupements") == idRegroupement) {
        await getDocs(collection: "troupeaux").then((troupeaux) async {
          for (var itemTroupeaux in troupeaux.docs) {
            if (itemTroupeaux.get("eleveur") == itemMembres.id) {
              await getDocs(collection: "betes").then((betes) {
                for (var itemBetes in betes.docs) {
                  if (itemBetes.get("troupeaux") == itemTroupeaux.id &&
                      itemBetes.get("idAnimal") == idEspece) {
                    i += 1;
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

Future getNumberMortalite(
    {required String idRegion, required String type}) async {
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
                        if (itemMortalite.get("village") == itemV.id) {
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

Future getNumberMortaliteRegions(
    {required String idDept, required String type}) async {
  int i = 0;

  return getDocs(collection: "communes").then((communes) async {
    for (var itemC in communes.docs) {
      if (itemC.get("departements") == idDept) {
        await getDocs(collection: "villages").then((villages) async {
          for (var itemV in villages.docs) {
            if (itemV.get("communes") == itemC.id) {
              await getDocs(collection: type).then((mortalites) async {
                for (var itemMortalite in mortalites.docs) {
                  if (itemMortalite.get("village") == itemV.id) {
                    i += 1;
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

Future getNumberMortaliteDepartements(
    {required String idCommune, required String type}) async {
  int i = 0;

  return getDocs(collection: "villages").then((villages) async {
    for (var itemV in villages.docs) {
      if (itemV.get("communes") == idCommune) {
        await getDocs(collection: type).then((mortalites) async {
          for (var itemMortalite in mortalites.docs) {
            if (itemMortalite.get("village") == itemV.id) {
              i += 1;
            }
          }
        });
      }
    }
    print(i);
    return i;
  });
}

Future getNumberMortaliteCommunes(
    {required String idVilage, required String type}) async {
  int i = 0;

  return getDocs(collection: type).then((mortalites) async {
    for (var itemMortalite in mortalites.docs) {
      if (itemMortalite.get("village") == idVilage) {
        i += 1;
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
                    await getDocs(collection: "violence-basee-sur-le-genre")
                        .then((mortalites) async {
                      for (var itemMortalite in mortalites.docs) {
                        if (itemMortalite.get("village") == itemV.id) {
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

Future getNumberViolenceRegion({required String idDept}) async {
  int i = 0;

  return getDocs(collection: "communes").then((communes) async {
    for (var itemC in communes.docs) {
      if (itemC.get("departements") == idDept) {
        await getDocs(collection: "villages").then((villages) async {
          for (var itemV in villages.docs) {
            if (itemV.get("communes") == itemC.id) {
              await getDocs(collection: "violence-basee-sur-le-genre")
                  .then((mortalites) async {
                for (var itemMortalite in mortalites.docs) {
                  if (itemMortalite.get("village") == itemV.id) {
                    i += 1;
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

Future getNumberViolenceDepartement({required String idCommune}) async {
  int i = 0;

  return getDocs(collection: "villages").then((villages) async {
    for (var itemV in villages.docs) {
      if (itemV.get("communes") == idCommune) {
        await getDocs(collection: "violence-basee-sur-le-genre")
            .then((mortalites) async {
          for (var itemMortalite in mortalites.docs) {
            if (itemMortalite.get("village") == itemV.id) {
              i += 1;
            }
          }
        });
      }
    }
    print(i);
    return i;
  });
}

Future getNumberViolenceCommune({required String idVillage}) async {
  int i = 0;

  return getDocs(collection: "violence-basee-sur-le-genre")
      .then((mortalites) async {
    for (var itemMortalite in mortalites.docs) {
      if (itemMortalite.get("village") == idVillage) {
        i += 1;
      }
    }
    print(i);
    return i;
  });
}
