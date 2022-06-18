import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hotwheels_collections/Page/Logined.dart';
import 'package:hotwheels_collections/Page/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: firebase,
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
              child: Center(child: CircularProgressIndicator()));
        },
        
      ),
    );
  }
}
