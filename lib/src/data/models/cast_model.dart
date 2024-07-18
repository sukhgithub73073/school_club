// To parse this JSON data, do
//
//     final casteModel = casteModelFromJson(jsonString);

import 'dart:convert';

CasteModel casteModelFromJson(String str) => CasteModel.fromJson(json.decode(str));

String casteModelToJson(CasteModel data) => json.encode(data.toJson());

class CasteModel {
  String status;
  Data data;
  String message;
  dynamic errors;

  CasteModel({
    required this.status,
    required this.data,
    required this.message,
    required this.errors,
  });

  factory CasteModel.fromJson(Map<String, dynamic> json) => CasteModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
    "errors": errors,
  };
}

class Data {
  List<Caste> caste;
  List<Caste> subCaste;

  Data({
    required this.caste,
    required this.subCaste,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    caste: List<Caste>.from(json["caste"].map((x) => Caste.fromJson(x))),
    subCaste: List<Caste>.from(json["subCaste"].map((x) => Caste.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "caste": List<dynamic>.from(caste.map((x) => x.toJson())),
    "subCaste": List<dynamic>.from(subCaste.map((x) => x.toJson())),
  };
}

class Caste {
  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;
  int? casteId;

  Caste({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.casteId,
  });
  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
  factory Caste.fromJson(Map<String, dynamic> json) => Caste(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    casteId: json["caste_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "caste_id": casteId,
  };
}
