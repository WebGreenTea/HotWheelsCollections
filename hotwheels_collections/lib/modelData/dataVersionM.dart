import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class DataVersion {
  final int dataVersion;
  

  DataVersion({
    required this.dataVersion,
  }) {
    //print(this.ModelName);
  }

  DataVersion.fromJson(Map<String, Object?> json)
      : this(
          dataVersion: json['dataVersion']! as int,
        );

  Map<String, Object?> toJson() => {
        'dataVersion': dataVersion,
      };
}
