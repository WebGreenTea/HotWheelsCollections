import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class MainLineData {
  final String id;
  final String ToyID;
  final int YEAR;
  final String img_url;
  final String Series;
  final String SeriesNumber;
  final String NumbersInYear;
  final String ModelName;
  final List<String> NewCar;
  final List<String> ChaseCar;
  final List<String> Exclusive;
  bool have = false;

  MainLineData({
    required this.id,
    required this.ToyID,
    required this.YEAR,
    required this.img_url,
    required this.Series,
    required this.SeriesNumber,
    required this.NumbersInYear,
    required this.ModelName,
    required this.ChaseCar,
    required this.NewCar,
    required this.Exclusive,
  }) {
    //print(this.ModelName);
  }

  MainLineData.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          ToyID: json['ToyID']! as String,
          YEAR: json['YEAR']! as int,
          img_url: json['img_url']! as String,
          Series: json['Series']! as String,
          SeriesNumber: json['SeriesNumber']! as String,
          NumbersInYear: json['NumbersInYear']! as String,
          ModelName: json['ModelName']! as String,
          ChaseCar: (json['ChaseCar'] as List<dynamic>).cast<String>(),
          Exclusive: (json['Exclusive'] as List<dynamic>).cast<String>(),
          NewCar: (json['NewCar'] as List<dynamic>).cast<String>(),
        );

  Map<String, Object?> toJson() => {
        'id':id,
        'ToyID': ToyID,
        'YEAR': YEAR,
        'img_url': img_url,
        'Series': Series,
        'SeriesNumber': SeriesNumber,
        'NumberInYear': NumbersInYear,
        'ModelName': ModelName,
      };
}
