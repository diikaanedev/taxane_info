import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:taxane/utils/color-by-dii.dart';

class LoginLaptop extends StatefulWidget {
  const LoginLaptop({Key? key}) : super(key: key);

  @override
  _LoginLaptopState createState() => _LoginLaptopState();
}

class _LoginLaptopState extends State<LoginLaptop> {
  late Size size;
  bool isVisible = true;
  String password = '';
  String email = '';
  bool chargement = false;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        elevation: .0,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: blanc,
          ),
          Positioned(
              child: Container(
            height: size.height * .2,
            width: size.width,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Center(
                    child: Text(
                      'Taxane-Info',
                      style: TextStyle(
                          color: rouge,
                          fontSize: constraints.maxHeight * .15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          )),
          Positioned(
              top: size.height * .15,
              child: Container(
                height: size.height * .6,
                width: size.width,
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * .05,
                      ),
                      Text(
                        'Formulaire de Connection',
                        style: TextStyle(
                            fontSize: constraints.maxHeight * .05,
                            color: rouge),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .1,
                      ),
                      Container(
                        height: constraints.maxHeight * .1,
                        width: constraints.maxWidth * .6,
                        child: Row(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * .01,
                            ),
                            Text('Email ou Pseudo'),
                            SizedBox(
                              width: constraints.maxWidth * .03,
                            ),
                            Container(
                              width: constraints.maxWidth * .4,
                              child: TextField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                onChanged: (value) => setState(() {
                                  email = value;
                                }),
                                cursorColor: Colors.black,
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .05,
                      ),
                      Container(
                        height: constraints.maxHeight * .1,
                        width: constraints.maxWidth * .6,
                        child: Row(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * .01,
                            ),
                            Text('Mot de passe '),
                            Spacer(),
                            Container(
                              width: constraints.maxWidth * .45,
                              child: TextField(
                                obscureText: isVisible,
                                onChanged: (value) => setState(() {
                                  password = value;
                                }),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                        onTap: () => setState(() {
                                              isVisible = !isVisible;
                                            }),
                                        child: isVisible
                                            ? Icon(
                                                CupertinoIcons.eye_slash,
                                                color: Colors.black,
                                              )
                                            : Icon(CupertinoIcons.eye_fill,
                                                color: Colors.black))),
                                cursorColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .05,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            chargement = true;
                          });
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(value.user!.uid)
                                .get()
                                .then((doc) async {
                              if (!doc.exists) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(value.user!.uid)
                                    .set({
                                  "username": email.split('@')[0],
                                  "role": 1,
                                  "avatar": "",
                                });
                              }
                              Navigator.popAndPushNamed(context, "/home");
                            }).catchError((err) {
                              print("we haeve error");
                              setState(() {
                                chargement = false;
                              });
                            });
                          });
                        },
                        child: Container(
                          height: constraints.maxHeight * .1,
                          width: constraints.maxWidth * .15,
                          child: Center(
                            child: chargement
                                ? CircularProgressIndicator(
                                    backgroundColor: vert,
                                    color: blanc,
                                  )
                                : Text(
                                    'Se connecter',
                                    style:
                                        TextStyle(fontSize: 18, color: blanc),
                                  ),
                          ),
                          decoration: BoxDecoration(
                              color: vert,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          
        ],
      ),
    );
  }
}
