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

class UpdateDB {
  String dbName = "AllModel.db";
  List<String> allDoc = ['mainline'];

  // Future<List<MainLineData>> updateDB() async{
  //   final jsondata = await rootBundle.rootBundle.loadString('assets/mainline.json');
  //   final list = json.decode(jsondata) as List<dynamic>;

  //   List<MainLineData> dataFromJsonFile = list.map((e) => MainLineData.fromJson(e)).toList();

  // }
  Future<List<dynamic>> getJsonDataDoc(String docName) async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/${docName}.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list;
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

  void loadDataVersion() async {
    //load doc DataVersion
    Database db = await this.openDatabase();
    var dataVersion = intMapStoreFactory.store('DataVersion');
    var snapshot = await dataVersion.find(db);

    //load JSON DataVersion
    List<DataVersion> JsonDataVersion = await this.loadJSONDataVersion();

    if (snapshot.length == 0) {//ไม่มี doc ชื่อ DataVersion ใน db
      print('dataVersion is emty');
      //SYNC
    } else {//มี doc ชื่อ DataVersion ใน db
      int index = 0;
      for (var record in snapshot) {
        // if (record['docName'] as String == JsonDataVersion[index].docName) {//ชื่อ doc บน json กับ db ตรงกัน
        //   if (record['dataversion'] as int < await JsonDataVersion[index].dataVersion) {
        //     //SYNC***  
        //   } else {//doc ทีมี เป็นเวอร์ชั่นล่าสุด
        //     print('dataVersion is latest');
        //   }
        // } else {//ชื่อ doc บน json กับ db ไม่ตรงกัน
        //   //SYNC
        //   break;
        // }
        index++;
      }
    }

    // if(snapshot.length == 0){//ไม่มี db หรือ เวอร์ชั่นเก่าไป ต้อง update
    //   print('emtydb');
    // }else{//db ทีมี เป็นเวอร์ชั่นล่าสุด
    //   print('havedb');
    // }
  }

  Future<List<DataVersion>> loadJSONDataVersion() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/data/DataVersion.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => DataVersion.fromJson(e)).toList();
  }

  syncDBwithJson(Database db) async{
    //ลบ db ตัวเก่าทิ้ง
    await this.deleteDB(db);
    //สร้าง db ตัวใหม่
    db = await this.openDatabase();



  }

  deleteDB(Database db) async{
    db.close();
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    await databaseFactoryIo.deleteDatabase(dbLocation);
  }
}
