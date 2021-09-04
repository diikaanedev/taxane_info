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
                            SizedBox(
                              width: constraints.maxWidth * .03,
                            ),
                            Container(
                              width: constraints.maxWidth * .5,
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
          Positioned(
              bottom: 0,
              child: Container(
                height: size.height * .2,
                width: size.width,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      // color: Colors.black45,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: constraints.maxWidth * .2,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUX8SoXFrf-n1aei5x1oMdAFawT661j9sACQ&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: constraints.maxWidth * .2,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuYWKEPJQwwCnFWn26Kr1ttHRFDg5NB4AJNQjNWSglBLQx7gtmdxTUWTv9vAgvwZogSYM&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: constraints.maxWidth * .2,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8eQv4mM-p_thhb_z8UbyijLPLrmt-zTKrzw&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: constraints.maxWidth * .2,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUX8SoXFrf-n1aei5x1oMdAFawT661j9sACQ&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: constraints.maxWidth * .2,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuYWKEPJQwwCnFWn26Kr1ttHRFDg5NB4AJNQjNWSglBLQx7gtmdxTUWTv9vAgvwZogSYM&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: constraints.maxWidth * .2,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8eQv4mM-p_thhb_z8UbyijLPLrmt-zTKrzw&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
          Positioned(
              bottom: size.height * .2,
              child: Container(
                height: size.height * .05,
                width: size.width,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * .01,
                          ),
                          Text(
                            'Nos Partenaires',
                            style: TextStyle(
                                color: rouge,
                                fontSize: constraints.maxHeight * .5),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
