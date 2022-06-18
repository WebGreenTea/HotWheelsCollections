import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:hotwheels_collections/modelData/mainlineData.dart';

class JsonManagement{
  
  Future<List<MainLineData>> read(String filename) async{
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/${filename}');
    final list =  json.decode(jsondata) as List<dynamic>;
    return list.map((e) => MainLineData.fromJson(e)).toList();
  }






  
}