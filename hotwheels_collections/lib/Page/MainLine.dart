import 'dart:ffi';
import 'dart:io';
import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutterfire_ui/firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hotwheels_collections/Page/MainlineCar.dart';
import 'package:hotwheels_collections/dbManage.dart';
import 'package:hotwheels_collections/jsonread.dart';
import 'package:hotwheels_collections/modelData/mainlineData.dart';
import 'dart:convert';

import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  bool isAscending = true; //

  List<MainLineData> DataMainline = [];
  late List<MainLineData> allMainLineData; //x
  late Future<List<MainLineData>>? mainlineData;
  bool inSearch = false;
  String TextinSearchBar = '';

  List<String> AllYear = [];
  //Future allYear = DBManage().getAllYearMainline();
  String YearSelectedItem = 'ALL YEAR';
  String SerieSelectedItem = 'ALL Series';
  late Future<List<String>> Series =
      DBManage().getSeriesMainlinrOfYear(convertYearStrToInt(YearSelectedItem));

  @override
  void initState() {
    super.initState();
    //allYear =  DBManage().getAllYearMainline();
    mainlineData = getMainlineData();
    KeyboardVisibilityController().onChange.listen((isVisible) {
      if (!isVisible) {
        clearKeyboardFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        clearKeyboardFocus();
        print('back');
        return true;
      },
      child: GestureDetector(
        onTap: clearKeyboardFocus,
        onVerticalDragCancel: clearKeyboardFocus,
        child: Scaffold(
            //appBar: AppBar(title: Text('MainLine')),
            body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(15),
                //     bottomRight: Radius.circular(15))
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            color: HexColor('#707070'),
                          ),
                          hintText: 'Model name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          )),
                      onChanged: searchModel,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(3, 4, 5, 4),
                      child: Row(
                        children: [
                          AscendingButton(),
                          FutureBuilder(
                            future: DBManage().getAllYearMainline(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                //print(snapshot.data);
                                List<String> allYearItem = snapshot.data;
                                allYearItem.insert(0, 'ALL YEAR');
                                allYearItem = allYearItem.toSet().toList();
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    YearDropDown(allYearItem),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FutureBuilder(
                                      future: Series,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.connectionState ==
                                                ConnectionState.done) {
                                          List<String> allSeriesItem =
                                              snapshot.data;
                                          allSeriesItem.insert(0, 'ALL Series');
                                          allSeriesItem =
                                              allSeriesItem.toSet().toList();
                                          //print(allSeriesItem);
                                          if (allSeriesItem.length <= 1) {
                                            return Container();
                                          }
                                          //SerieSelectedItem = allSeriesItem[0];
                                          //return Container();
                                          return Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            decoration: BoxDecoration(
                                              color: Colors.orange[900],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Series : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    value: SerieSelectedItem,
                                                    items: allSeriesItem
                                                        .map((item) =>
                                                            DropdownMenuItem(
                                                                value: item,
                                                                child:
                                                                    Text(item)))
                                                        .toList(),
                                                    onChanged: (item) =>
                                                        setState(() {
                                                      SerieSelectedItem = item!;
                                                      mainlineData =
                                                          getMainlineData();
                                                      Series = DBManage()
                                                          .getSeriesMainlinrOfYear(
                                                              convertYearStrToInt(
                                                                  YearSelectedItem));
                                                    }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                  ],
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: mainlineData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<MainLineData> data = snapshot.data;
                  if (data.length <= 0) {
                    return Expanded(
                        child: Center(
                            child: Text(
                      'There are no results for "${TextinSearchBar}"',
                      style: TextStyle(color: HexColor('#707070')),
                    )));
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          onTap: () {
                            //print('tap listTile');
                            clearKeyboardFocus();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainlineCar(CarData: data[i])));
                          },
                          leading: Container(
                            width: 70,
                            child: Loadimage(data[i]),
                          ),
                          title: Text(data[i].ModelName),
                          subtitle: Text(
                              '${data[i].Series} ${data[i].SeriesNumber} ${data[i].YEAR}'),
                        );
                      },
                    ),
                  );
                }
                //return Center(child: CircularProgressIndicator());
                return LinearProgressIndicator();
              },
            )
          ],
        )),
      ),
    );
  }

  Widget Loadimage(MainLineData item) {
    return OptimizedCacheImage(
      imageUrl: item.img_url,
    );
  }

  Widget AscendingButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton.icon(
          onPressed: () {
            resetScroll();
            setState(() {
              isAscending = !isAscending;
              mainlineData = getMainlineData();
            });
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          icon: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.compare_arrows,
              size: 28,
            ),
          ),
          label: Text(isAscending ? 'Aa-Zz' : 'zZ-aA')),
    );
  }

  Widget YearDropDown(List<String> allYearItem) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
        color: Colors.orange[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            'Year : ',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              value: YearSelectedItem,
              items: allYearItem
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (item) => setState(() {
                YearSelectedItem = item!;
                SerieSelectedItem = 'ALL Series';
                Series = DBManage().getSeriesMainlinrOfYear(
                    convertYearStrToInt(YearSelectedItem));
                mainlineData = getMainlineData();
              }),
            ),
          ),
        ],
      ),
    );
  }

  void resetScroll() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
  }

  Future<List<MainLineData>> getMainlineData() async {
    Database db = await DBManage().openDatabase();
    final mainlineStore = intMapStoreFactory.store('mainline');
    Finder finder;
    List<Filter> allFilter = [
      Filter.matchesRegExp(
          'ModelName', RegExp('.*${TextinSearchBar}.*', caseSensitive: false))
    ];
    // if (YearSelectedItem == 'ALL YEAR') {
    //   finder = Finder(
    //       sortOrders: [SortOrder('ModelName', isAscending)],
    //       filter: Filter.matchesRegExp('ModelName',
    //           RegExp('.*${TextinSearchBar}.*', caseSensitive: false)));
    // } else {
    //   finder = Finder(
    //       sortOrders: [SortOrder('ModelName', isAscending)],
    //       filter: Filter.and([
    //         Filter.equals('YEAR', int.parse(YearSelectedItem)),
    //         Filter.matchesRegExp('ModelName',
    //             RegExp('.*$TextinSearchBar.*', caseSensitive: false))
    //       ]));
    // }

    if (YearSelectedItem != 'ALL YEAR') {
      allFilter.add(Filter.equals('YEAR', int.parse(YearSelectedItem)));
    }
    if (SerieSelectedItem != 'ALL Series') {
      allFilter.add(Filter.equals('Series', SerieSelectedItem));
    }
    finder = Finder(
        sortOrders: [SortOrder('ModelName', isAscending)],
        filter: Filter.and(allFilter));
    final mainlineSnapshot = await mainlineStore.find(db, finder: finder);
    List<MainLineData> list = mainlineSnapshot.map((snapshot) {
      final item = MainLineData.fromJson(snapshot.value);
      return item;
    }).toList();

    list.sort((item1, item2) => isAscending
        ? item1.ModelName.toLowerCase().compareTo(item2.ModelName.toLowerCase())
        : item2.ModelName.toLowerCase()
            .compareTo(item1.ModelName.toLowerCase()));
    db.close();
    return list;

    // JsonManagement jsonManagement = JsonManagement();

    // //List<dynamic> list = await jsonManagement.read('mainline.json');

    // //allMainLineData = await jsonManagement.read('datamainline.json');
    // await Future.delayed(Duration(seconds: 1));

    // return await jsonManagement.read('datamainline.json');
  }

  void searchModel(String query) {
    //inSearch = true;

    // final suggestions = allMainLineData.where((element) {
    //   final ModelName = element.ModelName.toLowerCase();
    //   final input = query.toLowerCase();

    //   return ModelName.contains(input);
    // }).toList();

    // setState(() {
    //   DataMainline = suggestions;
    // });
    TextinSearchBar = query;
    setState(() {
      mainlineData = getMainlineData();
    });

    resetScroll();
  }

  int convertYearStrToInt(String str) {
    int year = 0;
    try {
      year = int.parse(str);
    } catch (e) {}
    return year;
  }

  void clearKeyboardFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
