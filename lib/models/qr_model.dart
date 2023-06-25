import 'package:cloud_firestore/cloud_firestore.dart';

class QrModel {
  int id;
  String description;
  Timestamp datetime;
  String qr;

  QrModel({
    required this.id,
    required this.description,
    required this.datetime,
    required this.qr,
  });

  factory QrModel.fromJson(Map<String, dynamic> json) => QrModel(
        id: json["id"] ?? 0,
        description: json["description"] ?? 0,
        datetime: json["datetime"] ?? 0,
        qr: json["qr"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "datetime": datetime,
        "qr": qr,
      };
}
