import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:hotwheels_collections/storeData/mainlineData.dart';

class Mainline extends StatefulWidget {
  const Mainline({Key? key}) : super(key: key);

  @override
  State<Mainline> createState() => _MainlineState();
}

class _MainlineState extends State<Mainline> {
  final queryData = FirebaseFirestore.instance
      .collection('mainline')
      .orderBy('ModelName')
      .withConverter<MainLineData>(
        fromFirestore: (snapshot, _) => MainLineData.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MainLine')),
      body: FirestoreListView(
          query: queryData,
          pageSize: 20,
          itemBuilder: (context, snapshot) {
            final MainLineData mainline = snapshot.data() as MainLineData;

            return ListTile(
              leading: Container(
                width: 70,
                child: Image.network(mainline.img_url, fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                }),
              ),
              title: Text(mainline.ModelName),
              subtitle: Text(mainline.Series),
            );
          }),
    );
  }
}
