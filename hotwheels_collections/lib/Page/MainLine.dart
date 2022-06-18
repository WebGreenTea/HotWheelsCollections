import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hotwheels_collections/jsonread.dart';
import 'package:hotwheels_collections/modelData/mainlineData.dart';
import 'dart:convert';

import 'package:optimized_cached_image/optimized_cached_image.dart';

class Mainline extends StatefulWidget {
  const Mainline({Key? key}) : super(key: key);

  @override
  State<Mainline> createState() => _MainlineState();
}

class _MainlineState extends State<Mainline> {
  // final queryData = FirebaseFirestore.instance
  //     .collection('mainline')
  //     .orderBy('ModelName')
  //     .withConverter<MainLineData>(
  //       fromFirestore: (snapshot, _) => MainLineData.fromJson(snapshot.data()!),
  //       toFirestore: (user, _) => user.toJson(),
  //     );
  // final searchController = TextEditingController();
   bool isDescending = false;
  // List<MainLineData> DataMainline = [];
  // late List<MainLineData> allMainLineData;
  // bool inSearch = false;

  late Future<List<MainLineData>> allMainLineData;

  @override
  void initState() {
    super.initState();
    allMainLineData = readMainline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mainline'),
      ),
      body: FutureBuilder(
        future: allMainLineData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<MainLineData> DataMainline = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: DataMainline.length,
                    itemBuilder: ((context, i) {
                      
                      var items = DataMainline..sort((item1, item2) => isDescending
                            ? item2.ModelName.compareTo(item1.ModelName)
                            : item1.ModelName.compareTo(item2.ModelName));
                      var item = items[i];
                      return ListTile(
                        onTap: () {
                          print(99999);
                        },
                        leading: Container(
                          width: 70,
                          child: Loadimage(item),
                        ),
                        title: Text(item.ModelName),
                        subtitle: Text('${item.Series} ${item.SeriesNumber}'),
                      );
                    }),
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),

      // return Scaffold(
      //   //appBar: AppBar(title: Text('MainLine')),
      //   body: FutureBuilder(
      //     future: readMainline(),
      //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //       if (snapshot.hasData) {
      //         print(11111);
      //         if(!inSearch){
      //           print(22222);
      //           DataMainline =  snapshot.data;
      //         }

      //         return Column(
      //           children: [
      //             Container(
      //               decoration: BoxDecoration(color: Colors.orange,
      //               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
      //               child: Column(
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
      //                     child: TextField(
      //                       controller: searchController,
      //                       decoration: InputDecoration(
      //                           filled: true,
      //                           fillColor: Colors.white,
      //                           prefixIcon: Icon(Icons.search,color: HexColor('#707070'),),
      //                           hintText: 'Model name',
      //                           border: OutlineInputBorder(
      //                             borderRadius: BorderRadius.circular(14),
      //                             borderSide: BorderSide(
      //                               width: 0,
      //                               style: BorderStyle.none,
      //                             ),
      //                           )),
      //                       onChanged: searchModel,
      //                     ),
      //                   ),
      //                   TextButton.icon(
      //                       onPressed: () {
      //                         setState(() {
      //                           isDescending = !isDescending;
      //                         });
      //                       },
      //                       style: TextButton.styleFrom(
      //                         primary: Colors.white,
      //                       ),
      //                       icon: RotatedBox(
      //                         quarterTurns: 1,
      //                         child: Icon(
      //                           Icons.compare_arrows,
      //                           size: 28,
      //                         ),
      //                       ),
      //                       label: Text(isDescending ? 'Z-A' : 'A-Z')),
      //                 ],
      //               ),
      //             ),
      //             Expanded(
      //               child: ListView.builder(
      //                 padding: EdgeInsets.zero,
      //                   shrinkWrap: true,
      //                   itemCount: DataMainline.length,
      //                   itemBuilder: (context, i) {
      //                     if (i.isOdd) return Divider();
      //                     DataMainline.sort((item1, item2) => isDescending
      //                         ? item2.ModelName.compareTo(item1.ModelName)
      //                         : item1.ModelName.compareTo(item2.ModelName));
      //                     var item = DataMainline[i];
      //                     return ListTile(
      //                       onTap: () {
      //                         print(99999);
      //                       },
      //                       leading: Container(
      //                         width: 70,
      //                         child: Loadimage(item),
      //                       ),
      //                       title: Text(item.ModelName),
      //                       subtitle: Text('${item.Series} ${item.SeriesNumber}'),
      //                     );
      //                   }),
      //             ),
      //           ],
      //         );
      //       } else {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //     },
      //   ),

      // body: Column(
      //   children: [
      //     TextField(
      //       controller: searchController,
      //       decoration: InputDecoration(
      //         prefixIcon: const Icon(Icons.search),
      //         hintText: 'Model name',
      //         border: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(14),

      //         )
      //       ),
      //       onChanged: searchModel,
      //     ),
      //     TextButton.icon(
      //         onPressed: () {
      //           setState(() {
      //             isDescending = !isDescending;
      //           });
      //         },
      //         icon: RotatedBox(
      //           quarterTurns: 1,
      //           child: Icon(
      //             Icons.compare_arrows,
      //             size: 28,
      //           ),
      //         ),
      //         label: Text(isDescending ? 'Z-A' : 'A-Z')),
      //     Expanded(
      //       child: FutureBuilder(
      //         future: readMainline(),
      //         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //           if (snapshot.hasData) {
      //             List<MainLineData> DataMainline = snapshot.data;
      //             return ListView.builder(
      //                 shrinkWrap: true,
      //                 itemCount: DataMainline.length,
      //                 itemBuilder: (context, i) {
      //                   if (i.isOdd) return Divider();
      //                   DataMainline.sort((item1, item2) => isDescending
      //                       ? item2.ModelName.compareTo(item1.ModelName)
      //                       : item1.ModelName.compareTo(item2.ModelName));
      //                   final item = DataMainline[i];
      //                   return ListTile(
      //                     onTap: () {
      //                       print(99999);
      //                     },
      //                     leading: Container(
      //                       width: 70,
      //                       child: Loadimage(item),
      //                     ),
      //                     title: Text(item.ModelName),
      //                     subtitle: Text('${item.Series} ${item.SeriesNumber}'),
      //                   );
      //                 });
      //           } else {
      //             return Center(child: CircularProgressIndicator());
      //           }
      //         },
      //       ),
      //     ),
      //   ],
      // ),

      // body: FirestoreListView(
      //     query: queryData,
      //     pageSize: 20,
      //     itemBuilder: (context, snapshot) {
      //       final MainLineData mainline = snapshot.data() as MainLineData;

      //       return ListTile(
      //         leading: Container(
      //           width: 70,
      //           child: Image.network(mainline.img_url, fit: BoxFit.cover,
      //               loadingBuilder: (BuildContext context, Widget child,
      //                   ImageChunkEvent? loadingProgress) {
      //             if (loadingProgress == null) {
      //               return child;
      //             }
      //             return Center(
      //               child: CircularProgressIndicator(
      //                 value: loadingProgress.expectedTotalBytes != null
      //                     ? loadingProgress.cumulativeBytesLoaded /
      //                         loadingProgress.expectedTotalBytes!
      //                     : null,
      //               ),
      //             );
      //           }),
      //         ),
      //         title: Text(mainline.ModelName),
      //         subtitle: Text('${mainline.Series} ${mainline.Exclusive.length == 0? "": "| ${mainline.Exclusive[0]}"}'),
      //       );
      //     }),
    );
  }

  Widget Loadimage(MainLineData item) {
    return OptimizedCacheImage(
      imageUrl: item.img_url,
    );
  }

  Future<List<MainLineData>> readMainline() async {
    JsonManagement jsonManagement = JsonManagement();

    //List<dynamic> list = await jsonManagement.read('mainline.json');

    return await jsonManagement.read('mainline.json');
  }
}
