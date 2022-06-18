import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hotwheels_collections/Page/HomePage.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:provider/provider.dart';
import 'provider/GoogleSignIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => GoogleSignProvider()))
      ],
      child: MaterialApp(
        title: 'HotWheelsCollections',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: HomePage(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
        
//       ),
//     );
//   }
// }
