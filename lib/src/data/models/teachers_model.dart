// To parse this JSON data, do
//
//     final teachersModel = teachersModelFromJson(jsonString);

import 'dart:convert';

TeachersModel teachersModelFromJson(String str) => TeachersModel.fromJson(json.decode(str));

String teachersModelToJson(TeachersModel data) => json.encode(data.toJson());

class TeachersModel {
  int currentPage;
  List<Datum> data;

  TeachersModel({
    required this.currentPage,
    required this.data,
  });

  factory TeachersModel.fromJson(Map<String, dynamic> json) => TeachersModel(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int collegeId;
  int userId;
  int session;
  String name;
  DateTime dob;
  String gender;
  String father;
  String designation;
  String qualification;
  String email;
  String mobileNo;
  String image;
  String alternateMobileNo;
  String pinCode;
  String state;
  String district;
  String tehsil;
  String villageMohalla;
  String religion;
  dynamic casteId;
  dynamic subCasteId;
  String bankName;
  String ifscCode;
  String accountNumber;
  String confirmAccountNumber;
  String accountHolderName;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  User user;
  dynamic caste;
  dynamic subcaste;

  Datum({
    required this.id,
    required this.collegeId,
    required this.userId,
    required this.session,
    required this.name,
    required this.dob,
    required this.gender,
    required this.father,
    required this.designation,
    required this.qualification,
    required this.email,
    required this.mobileNo,
    required this.image,
    required this.alternateMobileNo,
    required this.pinCode,
    required this.state,
    required this.district,
    required this.tehsil,
    required this.villageMohalla,
    required this.religion,
    required this.casteId,
    required this.subCasteId,
    required this.bankName,
    required this.ifscCode,
    required this.accountNumber,
    required this.confirmAccountNumber,
    required this.accountHolderName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.user,
    required this.caste,
    required this.subcaste,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    collegeId: json["college_id"],
    userId: json["user_id"],
    session: json["session"],
    name: json["name"],
    dob: DateTime.parse(json["dob"] =="" ? DateTime.now().toString():json["dob"]),
    gender: json["gender"],
    father: json["father"],
    designation: json["designation"],
    qualification: json["qualification"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    image: json["image"],
    alternateMobileNo: json["alternate_mobile_no"],
    pinCode: json["pin_code"],
    state: json["state"],
    district: json["district"],
    tehsil: json["tehsil"],
    villageMohalla: json["village_mohalla"],
    religion: json["religion"],
    casteId: json["caste_id"],
    subCasteId: json["sub_caste_id"],
    bankName: json["bank_name"],
    ifscCode: json["ifsc_code"],
    accountNumber: json["account_number"],
    confirmAccountNumber: json["confirm_account_number"],
    accountHolderName: json["account_holder_name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    user: User.fromJson(json["user"]),
    caste: json["caste"],
    subcaste: json["subcaste"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "college_id": collegeId,
    "user_id": userId,
    "session": session,
    "name": name,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "father": father,
    "designation": designation,
    "qualification": qualification,
    "email": email,
    "mobile_no": mobileNo,
    "image": image,
    "alternate_mobile_no": alternateMobileNo,
    "pin_code": pinCode,
    "state": state,
    "district": district,
    "tehsil": tehsil,
    "village_mohalla": villageMohalla,
    "religion": religion,
    "caste_id": casteId,
    "sub_caste_id": subCasteId,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "account_number": accountNumber,
    "confirm_account_number": confirmAccountNumber,
    "account_holder_name": accountHolderName,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "user": user.toJson(),
    "caste": caste,
    "subcaste": subcaste,
  };
}

class CasteClass {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  int? casteId;

  CasteClass({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.casteId,
  });

  factory CasteClass.fromJson(Map<String, dynamic> json) => CasteClass(
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

class User {
  int id;
  String name;
  String uniqueId;
  String mobileNumber;
  String mobileVerifiedAt;
  String accessType;
  String parentUserId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;

  User({
    required this.id,
    required this.name,
    required this.uniqueId,
    required this.mobileNumber,
    required this.mobileVerifiedAt,
    required this.accessType,
    required this.parentUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    uniqueId: json["unique_id"],
    mobileNumber: json["mobile_number"],
    mobileVerifiedAt: json["mobile_verified_at"],
    accessType: json["access_type"],
    parentUserId: json["parent_user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "unique_id": uniqueId,
    "mobile_number": mobileNumber,
    "mobile_verified_at": mobileVerifiedAt,
    "access_type": accessType,
    "parent_user_id": parentUserId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
