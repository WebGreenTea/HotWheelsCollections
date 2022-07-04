import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hotwheels_collections/modelData/dataVersionM.dart';
import 'package:hotwheels_collections/modelData/mainlineData.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/sembast_import_export.dart';

class DBManage {
  static const String VERSION_STORE_NAME = 'dataVersion';
  static const String MAINLINE_STORE_NAME = 'mainline';
  String dbName = 'mainDB.db';
  List<String> allDoc = ['mainline'];


  Future<void> importDB() async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/mainDB.json');
    var map = json.decode(jsondata) as Map;
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    Database importDb = await importDatabase(map, databaseFactoryIo, dbLocation);
    print(dbLocation);
  }

  Future<Database> openDatabase() async {
    //หา path สำหรับเก็บไฟล์ db
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //สร้าง db
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<void> CheckDatabaseVer() async{
    Database db = await openDatabase();
    if(!await dbIsLastVer(db)){
      await importDB();
    }
  }

  Future<bool> dbIsLastVer(Database db) async{
    final VersionStore = intMapStoreFactory.store(VERSION_STORE_NAME);
    final recVer = await VersionStore.findFirst(db);
    if(recVer == null){
      print('db not found');
      return false;
    }
    final dataVersion = DataVersion.fromJson(recVer.value);  
    int verD = dataVersion.dataVersion;
    print('versionDB on device is ${verD}');
    
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/DataVersion.json');
    final verInPackage =  json.decode(jsondata);
    //return list.map((e) => MainLineData.fromJson(e)).toList();
    int verP = DataVersion.fromJson(verInPackage).dataVersion;

    print('versionDB on package is ${verP}');
    if(verD<verP){
      print('impot database success');
      return false;
    }
    return true;
  }

  Future<List<String>> getAllYearMainline() async{
    Database db = await openDatabase();
    final mainlineStore = intMapStoreFactory.store('mainline');
    List<String> year = [];
    final finder = Finder(filter: Filter.custom((record) {
      var data = record.value as Map;
      String y = data['YEAR'].toString();
      if(year.contains(y)){
        return false;
      }
      year.add(y);
      return true;
    }));
    await mainlineStore.find(db,finder: finder);
    db.close();
    //final mainlineSnapshot = await mainlineStore.(db,finder: finder);
    // List<MainLineData> list =  mainlineSnapshot.map((snapshot) {
    //   final item = MainLineData.fromJson(snapshot.value);
    //   return item;
    // }).toList();
    //print(year);
    return year.reversed.toList();
  }

  Future<List<String>> getSeriesMainlinrOfYear(int year) async{
    Database db = await openDatabase();
    final mainlineStore = intMapStoreFactory.store('mainline');
    List<String> series = [];
    final finder = Finder(filter: Filter.custom((record) {
      var data = record.value as Map;
      String s = data['Series'].toString();
      int yearinDB = data['YEAR'];

      if(data['Exclusive'].length > 1){
        print(data['id']);
      }

      if(series.contains(s)){
        return false;
      }
      else if( yearinDB==year){
        series.add(s);
        return true;  
      }
      return false;
    }));
    await mainlineStore.find(db,finder: finder);
    db.close();

    series.sort((item1,item2) => item1.compareTo(item2));

    return series;
  }

}
