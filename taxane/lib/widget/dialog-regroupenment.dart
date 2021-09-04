import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/utils/color-by-dii.dart';
import 'package:file_picker/file_picker.dart';

addRegroupement({required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  TextEditingController code = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController nomRepresentant = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController email = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: StatefulBuilder(
        builder: (context, setState) => Container(
          height: size.height * .8,
          width: size.width * .5,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: size.height * .1,
                child: Center(
                  child: Text(
                    'Formulaire d\'ajout de regroupement/association',
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
                        labelText: "code regroupement",
                        icon: Icon(CupertinoIcons.command)),
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
                height: size.height * .05,
                width: size.width * .4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    cursorColor: vert,
                    controller: nom,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "nom regroupement",
                        icon: Icon(CupertinoIcons.person_3_fill)),
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
                height: size.height * .05,
                width: size.width * .4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    cursorColor: vert,
                    controller: nomRepresentant,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "nom representant et fonction ",
                        icon: Icon(CupertinoIcons.person)),
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
                // height: size.height * .05,
                width: size.width * .4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    cursorColor: vert,
                    maxLines: 10,
                    controller: description,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "description regroupement",
                    ),
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
                height: size.height * .05,
                width: size.width * .4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    cursorColor: vert,
                    controller: tel,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "telephone regroupement",
                        icon: Icon(CupertinoIcons.phone)),
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
                height: size.height * .05,
                width: size.width * .4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    cursorColor: vert,
                    controller: email,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "email regroupement",
                        icon: Icon(CupertinoIcons.mail)),
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
                height: size.height * .05,
                width: size.width * .4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(administrationFoncierState.logoName == ""
                          ? 'Logo Regroupement'
                          : administrationFoncierState.logoName),
                      SizedBox(
                        width: size.width * .05,
                      ),
                      RaisedButton(
                        child: Icon(CupertinoIcons.upload_circle_fill),
                        color: Colors.transparent,
                        onPressed: () async {
                          final result = await FilePickerWeb.platform.pickFiles(
                              type: FileType.any, allowMultiple: false);
                          if (result!.files.first != null) {
                            var fileBytes = result.files.first.bytes;
                            var fileName = result.files.first.name;
                            setState(() {
                              administrationFoncierState.setState(() {
                                administrationFoncierState.fileLogo =
                                    fileBytes!;
                                administrationFoncierState.logoName = fileName;
                              });
                            });
                          }
                        },
                      )
                    ],
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
                  try {
                    print("hello on est bn");
                    Reference ref = FirebaseStorage.instance.ref(
                        'regroupement-logo/${new DateTime.now().millisecondsSinceEpoch.toString()}.png');

                    ref.putData(administrationFoncierState.fileLogo).then((_) {
                      _.ref.getDownloadURL().then((value) {
                        FirebaseFirestore.instance
                            .collection("regroupements")
                            .doc(code.text)
                            .set({
                          "code": code.text,
                          "name": nom.text,
                          "nomRepresentant": nomRepresentant.text,
                          "description": description.text,
                          "phone": tel.text,
                          "email": email.text,
                          "logo_url": value,
                          "date": DateTime.now()
                        });
                      });
                    });
                  } catch (e) {
                    print(e);

                    FirebaseFirestore.instance
                        .collection("regroupements")
                        .doc(code.text)
                        .set({
                      "code": code.text,
                      "name": nom.text,
                      "nomRepresentant": nomRepresentant.text,
                      "description": description.text,
                      "phone": tel.text,
                      "email": email.text,
                      "logo_url": "",
                      "date": DateTime.now()
                    });
                  }
                },
                child: Container(
                  height: size.height * .05,
                  // width: size.width * .5,
                  child: Container(
                    height: size.height * .05,
                    // width: size.width * .2,
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
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showRegroupement(
    {required BuildContext context, required String idRegroupement}) {
  Size size = MediaQuery.of(context).size;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("regroupements")
              .doc(idRegroupement)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              return Container(
                height: size.height * .8,
                width: size.width * .6,
                child: Row(
                  children: [
                    Spacer(),
                    Container(
                      width: size.width * .375,
                      // color: vert,
                      child: Column(
                        children: [
                          Container(
                            height: size.height * .05,
                            width: size.width,
                            child: Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: size.height * .04,
                                  color: vert,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${snapshot.data!.get('name')}",
                                  style: TextStyle(
                                      color: noir,
                                      fontSize: size.height * .03,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: size.height * .75,
                            width: size.width * .375,
                            child: LayoutBuilder(
                              builder: (context, constraints) => StreamBuilder<
                                      QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("regroupements")
                                      .doc(idRegroupement)
                                      .collection("membres")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else {
                                      List<TableRow> listes = [
                                        TableRow(children: [
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.format_list_numbered,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Code ',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    CupertinoIcons.globe,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Nom ',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.date_range_rounded,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Sexe',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                          Container(
                                              height:
                                                  constraints.maxHeight * .05,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(
                                                    Icons.settings,
                                                    color: vert,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .01,
                                                  ),
                                                  Text(
                                                    'Paramètres',
                                                    style: TextStyle(
                                                        color: vert,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )),
                                        ])
                                      ];

                                      listes.addAll(snapshot.data!.docs
                                          .map((e) => TableRow(children: [
                                                Container(
                                                    height: size.height * .05,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
                                                        Text(
                                                          e.get('matricule'),
                                                          style: TextStyle(
                                                              color: vert,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    )),
                                                Container(
                                                    height: size.height * .05,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
                                                        Text(
                                                          "${e.get('prenom')} ${e.get('name')}",
                                                          style: TextStyle(
                                                              color: vert,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    )),
                                                Container(
                                                    height: size.height * .05,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
                                                        Text(
                                                          e.get('sexe'),
                                                          style: TextStyle(
                                                              color: vert,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    )),
                                                Container(
                                                    height: size.height * .05,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () => null,
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .eye_fill,
                                                            color: jaune,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * .01,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () => null,
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: vert,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * .01,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () => null,
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: rouge,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    )),
                                              ]))
                                          .toList());
                                      return Container(
                                        child: ListView(
                                          children: [
                                            Table(
                                              border:
                                                  TableBorder.all(color: vert),
                                              children: listes,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: size.width * .2,
                      // color: rouge,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            height: size.height * .3,
                            decoration: BoxDecoration(
                                // color: vert,
                                image: DecorationImage(
                                    image: snapshot.data!.get('logo_url') == ''
                                        ? NetworkImage(
                                            "https://image.flaticon.com/icons/png/512/1907/1907626.png")
                                        : NetworkImage(
                                            snapshot.data!.get('logo_url')))),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Container(
                            height: size.height * .04,
                            child: Row(
                              children: [
                                Spacer(),
                                Container(
                                  width: size.width * .095,
                                  height: size.height * .04,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) => Row(
                                      children: [
                                        Spacer(),
                                        Icon(
                                          CupertinoIcons.phone,
                                          color: blanc,
                                          size: constraints.maxHeight * .5,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'TÉLÉPHONE',
                                          style: TextStyle(
                                              color: blanc,
                                              fontSize:
                                                  constraints.maxHeight * .5),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: noir),
                                ),
                                Spacer(),
                                Container(
                                  width: size.width * .095,
                                  height: size.height * .04,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) => Row(
                                      children: [
                                        Spacer(),
                                        Icon(
                                          CupertinoIcons.mail,
                                          color: blanc,
                                          size: constraints.maxHeight * .5,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'MESSAGE',
                                          style: TextStyle(
                                              color: blanc,
                                              fontSize:
                                                  constraints.maxHeight * .5),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: noir),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Container(
                            height: size.height * .05,
                            width: size.width * .19,
                            child: Text(
                              "${snapshot.data!.get('name')}",
                              style: TextStyle(
                                  color: noir,
                                  fontSize: size.height * .02,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            // height: size.height * .05,
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(CupertinoIcons.map_pin),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Container(
                                  width: size.width * .15,
                                  height: size.height * .03,
                                  child: Center(
                                    child: Text(
                                      'Associer à un adresse',
                                      style: TextStyle(color: blanc),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: vert),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Container(
                            // height: size.height * .05,
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * .03,
                                  height: size.height * .05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAbFBMVEU8Wpn///8yU5UpTZOXpcXR1eQlS5Lb3urx8vjU2OY6WJjs7/aptM+gqskwUZX19/q1vteHlr1Wb6Zvg7Jqf7CWocOMmr7Kz+BFYZ3T1uV2hrOHk7uQncHo6vPDytweR5BhdagOQIx6i7VLZqAxseyuAAAEFklEQVR4nO3d21biMACF4TTVQlJNDxTKqBDHef93HJBBXSBDDyTdifu/8kZWv9XSlB5SkXyUl1WtRfjpuirzT5Y4/jFrMiNjAO6I0thmdiIsFjYO3TFtF8VXoTJy6kW6edKoT2Eb2Qo8pG17FCo79cI4yqqDsDAxrsF92hTvwkV838FjcrEXqmzq5XBYpnbCJtZtdJ9uEpHHups5ZHNRmqkXwmmmFFW8+5l9shJRHGxfTtcibqCI3scYY4wxxhj72WktrzX1Ig5OS5Omom6enqvlcvl4sZcgiTucbu62alMkVyumXtj+yUyvys112vFq59TL2zOdimp2nRWsUGf1tsOGGa4wq+978sISSr3t7wtJaFd9t8+whFq2g3zBCOU6v24JWSjrob5AhGOAQQj1etg+JhihTucjgCEI7dC9aChCuRoFxBdqcR0RtjAbdKgWkFCPGSiCEGYDfk0EJdSvY4HownTstxBdqM1oILhQLmMXpqP3M+BCvR4PxBbKp9iFZvyeFFyYdT+zHaZw3C/fIIS3+BpCC28xGmILzUPswmHjfXHSBvhBu35noObt6rUW++veJ03N+E9pD9/m2aTyoAlH2OeHRWmBt8WL9TgqDfSpQd10FgZ6o3334+5tOvWyDku+dRU+BXnLzP45na7CUB/nkS8dgQHeE3So82HpJtSn6uRdR+Es0B0NhT9J+Ct6oYpeGP86pBA2CinEj0IK8aOQQvwoDEwos7Ns1xtLt7/T8//+CIQvV7OzVNcHEIr783/+0npq3Hu3uRj6vT964QZjM3UoBDnH4VC4xThf7FAIMs+cQ+EjxoUph0KQmfQcCkEmtHQoXEcvBJk4152wwBgOHQo3IDPnuhPeR78OQQZ8h0KQAd+hcBW98C16IcghjTth8Sd24RxkV+pOiDLguxPC3GvjTNhGL3yI/nsIMx+dMyHM7cPOhK8gw6E7Icg5DHdCnBukXQlzmEdpXAlhBnxnQpgBf3+FVJ3Wdn3OuWjP/vdfsyXKYLEjpmf1ucp9KRzgd3W+UwHldFrvKKQQPwopxI9CCvGjkEL8KKQQPwopxI9CCvGjkEL8KKQQPwopxI9CCvGjkEL8KKQQPwopxI9CCvGjkEL8KKQQPwopxI9CCvGjkEL8KKQQPwopxI9CCvGjkEL8KKQQPwopxI/Cmwu9T5rlWaiF95df+xXqWnh/i4JfoayE96m//QpNKXJ7g8/pk1+hzYX3eaO9CnWTiER5nnTYqzBTO2Gy8Luv8SmUi2QvLPy+7sOjUJviXZgorzsbj0KrkoMwaa3HtehNqG2bHIWJMv6+i76E0qjkU5gUi8zXavQj1NmiSL4Kd6uxscbL3LXu39KppbGNOn6M+PzEvKx8HIbLl2LeqaFvx9N1VX55T+ZfbDJTsSTKozMAAAAASUVORK5CYII="),
                                          fit: BoxFit.fill)),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: size.width * .03,
                                  height: size.height * .05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://assets.stickpng.com/images/580b57fcd9996e24bc43c521.png"),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: size.width * .03,
                                  height: size.height * .05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://images.frandroid.com/wp-content/uploads/2018/07/youtube-dark.jpg"),
                                          fit: BoxFit.fill)),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => addMembreRegroupemen(
                                      context: context,
                                      idRegroupement: snapshot.data!.id),
                                  child: Container(
                                    width: size.width * .03,
                                    height: size.height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        // color: vert,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://image.flaticon.com/icons/png/512/47/47768.png"),
                                            fit: BoxFit.contain)),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Container(
                            // height: size.height * .05,
                            width: size.width * .19,
                            child: Row(
                              children: [
                                Text(
                                  "Représentant :",
                                  style: TextStyle(
                                      color: noir,
                                      fontSize: size.height * .015,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  " ${snapshot.data!.get('nomRepresentant')}",
                                  style: TextStyle(
                                      color: noir,
                                      fontSize: size.height * .015,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Text(
                            "${snapshot.data!.get('description')}",
                            style: TextStyle(
                                color: noir,
                                fontSize: size.height * .015,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              );
            }
          }),
    ),
  );
}

addMembreRegroupemen(
    {required BuildContext context, required String idRegroupement}) {
  Size size = MediaQuery.of(context).size;
  TextEditingController matricule = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController cni = new TextEditingController();
  TextEditingController prenomPere = new TextEditingController();
  TextEditingController nomMere = new TextEditingController();
  TextEditingController prenomMere = new TextEditingController();
  TextEditingController dateNaiss = new TextEditingController();
  TextEditingController lieuxNaiss = new TextEditingController();
  TextEditingController nombreEpouse = new TextEditingController();
  TextEditingController nombrePersonActifEnCharge = new TextEditingController();
  TextEditingController nombrePersonInactifEnCharge =
      new TextEditingController();
  TextEditingController nbreJeune = new TextEditingController();
  TextEditingController nbreFemme = new TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('regroupements')
            .doc(idRegroupement)
            .snapshots(),
        builder: (context, snapshot) => !snapshot.hasData
            ? Container()
            : StatefulBuilder(
                builder: (context, setState) => Container(
                  height: size.height * .7,
                  width: size.width * .5,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Text(
                        'Formulaire d\' ajout d\'un membre',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: noir,
                            fontSize: size.height * .03,
                            fontWeight: FontWeight.bold),
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
                                Icon(administrationFoncierState.sexe == "homme"
                                    ? Icons.male
                                    : Icons.female),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Sexe / '),
                                DropdownButton<String>(
                                    value: administrationFoncierState.sexe,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState.sexe =
                                              newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "homme",
                                      "femme",
                                    ]
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toUpperCase())))
                                        .toList()),
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
                            controller: matricule,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Matricule',
                                icon: Icon(CupertinoIcons.command)),
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: nom,
                            decoration: InputDecoration(
                                labelText: 'Nom Membre',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: prenom,
                            decoration: InputDecoration(
                                labelText: 'Prenom Membre',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: prenom,
                            decoration: InputDecoration(
                                labelText: 'Prenom Membre',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: cni,
                            decoration: InputDecoration(
                                labelText: 'CNI',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: prenomPere,
                            decoration: InputDecoration(
                                labelText: 'Prenom Père',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: nomMere,
                            decoration: InputDecoration(
                                labelText: 'Nom Mère',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: prenomMere,
                            decoration: InputDecoration(
                                labelText: 'Prenom Mère',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: dateNaiss,
                            decoration: InputDecoration(
                                labelText: 'Date de Naissance',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            cursorColor: vert,
                            controller: lieuxNaiss,
                            decoration: InputDecoration(
                                labelText: 'Lieux de Naissance',
                                border: InputBorder.none,
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
                        height: size.height * .05,
                        width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            children: [
                              Text(administrationFoncierState.logoName == ""
                                  ? 'Image profile Membre'
                                  : administrationFoncierState.logoName),
                              SizedBox(
                                width: size.width * .05,
                              ),
                              RaisedButton(
                                child: Icon(CupertinoIcons.upload_circle_fill),
                                color: Colors.transparent,
                                onPressed: () async {
                                  final result = await FilePickerWeb.platform
                                      .pickFiles(
                                          type: FileType.any,
                                          allowMultiple: false);
                                  if (result!.files.first != null) {
                                    var fileBytes = result.files.first.bytes;
                                    var fileName = result.files.first.name;
                                    setState(() {
                                      administrationFoncierState.setState(() {
                                        administrationFoncierState.fileLogo =
                                            fileBytes!;
                                        administrationFoncierState.logoName =
                                            fileName;
                                      });
                                    });
                                  }
                                },
                              )
                            ],
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
                                Icon(Icons.school),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Niveau Étude / '),
                                DropdownButton<String>(
                                    value:
                                        administrationFoncierState.niveauEtude,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState
                                              .niveauEtude = newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "coranique",
                                      "cm2",
                                      "befm",
                                      "baccalaureat",
                                      "licence",
                                      "master",
                                      "doctorant",
                                    ]
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toUpperCase())))
                                        .toList()),
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
                        height: size.height * .04,
                        width: size.width * .4,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(Icons.school),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('NSituation Matrimonial / '),
                                DropdownButton<String>(
                                    value:
                                        administrationFoncierState.matrimonial,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        administrationFoncierState.setState(() {
                                          administrationFoncierState
                                              .matrimonial = newValue!;
                                        });
                                      });
                                    },
                                    items: [
                                      "celibataire",
                                      "marier",
                                    ]
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toUpperCase())))
                                        .toList()),
                              ],
                            )),
                        decoration: BoxDecoration(
                            border: Border.all(color: vert),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            print("oh c con");

                            Reference ref = FirebaseStorage.instance.ref(
                                'regroupement-membre/${new DateTime.now().millisecondsSinceEpoch.toString()}');

                            ref
                                .putData(administrationFoncierState.fileLogo)
                                .then((_) {
                              _.ref.getDownloadURL().then((value) {
                                print("helle");
                                FirebaseFirestore.instance
                                    .collection("regroupements")
                                    .doc(idRegroupement)
                                    .collection("membres")
                                    .add({
                                  "matricule": matricule.text,
                                  "name": nom.text,
                                  "prenom": prenom.text,
                                  "cni": cni.text,
                                  "prenomPere": prenomPere.text,
                                  "nomMere": nomMere.text,
                                  "prenomMere": prenomMere.text,
                                  "dateNaiss": dateNaiss.text,
                                  "lieuxNaiss": lieuxNaiss.text,
                                  "sexe": administrationFoncierState.sexe,
                                  "niveauEtude":
                                      administrationFoncierState.niveauEtude,
                                  "matrimonial":
                                      administrationFoncierState.matrimonial,
                                  "avatar": value,
                                  "date": DateTime.now()
                                });
                              });
                            });
                          } catch (e) {
                            print(e);
                            FirebaseFirestore.instance
                                .collection("regroupements")
                                .doc(idRegroupement)
                                .collection("membres")
                                .add({
                              "matricule": matricule.text,
                              "name": nom.text,
                              "prenom": prenom.text,
                              "cni": cni.text,
                              "prenomPere": prenomPere.text,
                              "nomMere": nomMere.text,
                              "prenomMere": prenomMere.text,
                              "dateNaiss": dateNaiss.text,
                              "lieuxNaiss": lieuxNaiss.text,
                              "sexe": administrationFoncierState.sexe,
                              "niveauEtude":
                                  administrationFoncierState.niveauEtude,
                              "matrimonial":
                                  administrationFoncierState.matrimonial,
                              "avatar": "",
                              "date": DateTime.now()
                            });
                          }
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .5,
                          child: Center(
                            child: Container(
                              height: size.height * .05,
                              width: size.width * .2,
                              child: Center(
                                child: Text(
                                  'Ajouter',
                                  style: TextStyle(
                                      color: jaune,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: jaune),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    ),
  );
}
