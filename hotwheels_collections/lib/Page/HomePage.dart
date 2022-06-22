import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hotwheels_collections/Page/Logined.dart';
import 'package:hotwheels_collections/Page/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:hotwheels_collections/dbManage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([firebase, updateDB()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return LoginedPage();
                } else {
                  return SignUpPage();
                }
              },
            );
          }
          return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor('#FFAA00'),
                  HexColor('#9F2C00'),
                ],
              )),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: const AssetImage(
                                'assets/images/hwcorrection.png'),
                            fit: BoxFit.scaleDown),
                      ),
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              )));
        },
      ),
    );
  }

  Future<void> updateDB() async {
    await Future.delayed(Duration(seconds: 1));
    await DBManage().CheckDatabaseVer();
    //await DBManage().importDB();
  }
}
