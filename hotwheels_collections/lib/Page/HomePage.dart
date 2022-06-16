import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          return CircularProgressIndicator();
        },
        future: firebase,
      ),
    );
  }
}