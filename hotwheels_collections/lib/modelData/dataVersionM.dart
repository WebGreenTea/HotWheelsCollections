import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class DataVersion {
  final String docName;
  final int dataVersion;
  

  DataVersion({
    required this.docName,
    required this.dataVersion,

  }) {
    //print(this.ModelName);
  }

  DataVersion.fromJson(Map<String, Object?> json)
      : this(
          docName: json['docName']! as String,
          dataVersion: json['dataVersion']! as int,
        );

  Map<String, Object?> toJson() => {
        'docName': docName,
        'dataVersion': dataVersion,
      };
}
