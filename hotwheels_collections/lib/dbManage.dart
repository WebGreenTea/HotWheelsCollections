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
    await dbIsLastVer(db);
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
      await importDB();
      print('impot database success');
    }

    return true;
  }

}
