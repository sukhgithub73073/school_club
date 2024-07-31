// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String status;
  UserModelData? data;
  String message;
  dynamic errors;

  UserModel({
    required this.status,
    required this.data,
    required this.message,
    required this.errors,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    data: UserModelData.fromJson(json["data"]??{}),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
    "message": message,
    "errors": errors,
  };
}

class UserModelData {
  String token;
  DataData data;

  UserModelData({
    required this.token,
    required this.data,
  });

  factory UserModelData.fromJson(Map<String, dynamic> json) => UserModelData(
    token: json["token"],
    data: DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "data": data.toJson(),
  };
}

class DataData {
  int id;
  String name;
  String uniqueId;
  String mobileNumber;
  dynamic mobileVerifiedAt;
  dynamic parentUserId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Role> roles;
  College college;
  dynamic students;
  dynamic staff;

  DataData({
    required this.id,
    required this.name,
    required this.uniqueId,
    required this.mobileNumber,
    required this.mobileVerifiedAt,
    required this.parentUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.roles,
    required this.college,
    required this.students,
    required this.staff,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    id: json["id"],
    name: json["name"],
    uniqueId: json["unique_id"],
    mobileNumber: json["mobile_number"],
    mobileVerifiedAt: json["mobile_verified_at"],
    parentUserId: json["parent_user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    college: College.fromJson(json["college"]),
    students: json["students"],
    staff: json["staff"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "unique_id": uniqueId,
    "mobile_number": mobileNumber,
    "mobile_verified_at": mobileVerifiedAt,
    "parent_user_id": parentUserId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "college": college.toJson(),
    "students": students,
    "staff": staff,
  };
}

class College {
  int id;
  int type;
  String name;
  String logo;
  String image;
  String ownerName;
  String mobileNo;
  String pincode;
  String state;
  String district;
  String village;
  String collegeCode;
  int accessType;
  int userId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String formType;
  String deletedAt;

  College({
    required this.id,
    required this.type,
    required this.name,
    required this.logo,
    required this.image,
    required this.ownerName,
    required this.mobileNo,
    required this.pincode,
    required this.state,
    required this.district,
    required this.village,
    required this.collegeCode,
    required this.accessType,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.formType,
    required this.deletedAt,
  });

  factory College.fromJson(Map<String, dynamic> json) => College(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    logo: json["logo"],
    image: json["image"],
    ownerName: json["owner_name"],
    mobileNo: json["mobile_no"],
    pincode: json["pincode"],
    state: json["state"],
    district: json["district"],
    village: json["village"],
    collegeCode: json["college_code"],
    accessType: json["access_type"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    formType: json["form_type"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "logo": logo,
    "image": image,
    "owner_name": ownerName,
    "mobile_no": mobileNo,
    "pincode": pincode,
    "state": state,
    "district": district,
    "village": village,
    "college_code": collegeCode,
    "access_type": accessType,
    "user_id": userId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "form_type": formType,
    "deleted_at": deletedAt,
  };
}

class Role {
  int id;
  int userId;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  Role({
    required this.id,
    required this.userId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    userId: json["user_id"],
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
