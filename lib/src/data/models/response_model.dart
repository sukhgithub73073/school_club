import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  String status;
  dynamic data;
  String message;
  dynamic errors;

  ResponseModel({
    required this.status,
    required this.data,
    required this.message,
    required this.errors,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    status: json["status"],
    data: json["data"],
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "message": message,
    "errors": errors,
  };
}
