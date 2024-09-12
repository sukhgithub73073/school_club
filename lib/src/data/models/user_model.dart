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
  Staff staff;

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
    college: College.fromJson(json["college"]??{}),
    staff: Staff.fromJson(json["staff"]??{}),
    students: json["students"],
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
    "staff": staff.toJson(),
    "students": students,
  };
}



class Staff {
  String accountHolderName;
  String accountNumber;
  String alternateMobileNo;
  String bankName;
  String casteId;
  int collegeId;
  String confirmAccountNumber;
  String deletedAt;
  String designation;
  String district;
  String email;
  String father;
  String gender;
  int id;
  String ifscCode;
  String image;
  String mobileNo;
  String name;
  String pinCode;
  String qualification;
  String religion;
  int session;
  String state;
  String status;
  String subCasteId;
  String tehsil;
  int userId;
  String villageMohalla;

  Staff({
    required this.accountHolderName,
    required this.accountNumber,
    required this.alternateMobileNo,
    required this.bankName,
    required this.casteId,
    required this.collegeId,
    required this.confirmAccountNumber,
    required this.deletedAt,
    required this.designation,
    required this.district,
    required this.email,
    required this.father,
    required this.gender,
    required this.id,
    required this.ifscCode,
    required this.image,
    required this.mobileNo,
    required this.name,
    required this.pinCode,
    required this.qualification,
    required this.religion,
    required this.session,
    required this.state,
    required this.status,
    required this.subCasteId,
    required this.tehsil,
    required this.userId,
    required this.villageMohalla,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    accountHolderName: json["account_holder_name"]??"",
    accountNumber: json["account_number"]??"",
    alternateMobileNo: json["alternate_mobile_no"]??"",
    bankName: json["bank_name"]??"",
    casteId: json["caste_id"]??"",
    collegeId: json["college_id"]??0,
    confirmAccountNumber: json["confirm_account_number"]??"",
    deletedAt: json["deleted_at"]??"",
    designation: json["designation"]??"",
    district: json["district"]??"",
    email: json["email"]??"",
    father: json["father"]??"",
    gender: json["gender"]??"",
    id: json["id"]??0,
    ifscCode: json["ifsc_code"]??"",
    image: json["image"]??"",
    mobileNo: json["mobile_no"]??"",
    name: json["name"]??"",
    pinCode: json["pin_code"]??"",
    qualification: json["qualification"]??"",
    religion: json["religion"]??"",
    session: json["session"]??0,
    state: json["state"]??"",
    status: json["status"]??"",
    subCasteId: json["sub_caste_id"]??"",
    tehsil: json["tehsil"]??"",
    userId: json["user_id"]??0,
    villageMohalla: json["village_mohalla"]??"",
  );

  Map<String, dynamic> toJson() => {
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "alternate_mobile_no": alternateMobileNo,
    "bank_name": bankName,
    "caste_id": casteId,
    "college_id": collegeId,
    "confirm_account_number": confirmAccountNumber,
    "deleted_at": deletedAt,
    "designation": designation,
    "district": district,
    "email": email,
    "father": father,
    "gender": gender,
    "id": id,
    "ifsc_code": ifscCode,
    "image": image,
    "mobile_no": mobileNo,
    "name": name,
    "pin_code": pinCode,
    "qualification": qualification,
    "religion": religion,
    "session": session,
    "state": state,
    "status": status,
    "sub_caste_id": subCasteId,
    "tehsil": tehsil,
    "user_id": userId,
    "village_mohalla": villageMohalla,
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

    required this.formType,
    required this.deletedAt,
  });

  factory College.fromJson(Map<String, dynamic> json) => College(
    id: json["id"]??0,
    type: json["type"]??0,
    name: json["name"]??"",
    logo: json["logo"]??"",
    image: json["image"]??"",
    ownerName: json["owner_name"]??"",
    mobileNo: json["mobile_no"]??"",
    pincode: json["pincode"]??"",
    state: json["state"]??"",
    district: json["district"]??"",
    village: json["village"]??"",
    collegeCode: json["college_code"]??"",
    accessType: json["access_type"]??0,
    userId: json["user_id"]??0,
    status: json["status"]??"",

    formType: json["form_type"]??"",
    deletedAt: json["deleted_at"]??"",
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
