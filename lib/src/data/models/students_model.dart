// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromJson(jsonString);

import 'dart:convert';

StudentsModel studentsModelFromJson(String str) =>
    StudentsModel.fromJson(json.decode(str));

String studentsModelToJson(StudentsModel data) => json.encode(data.toJson());

class StudentsModel {
  List<Datum> data;

  StudentsModel({
    required this.data,
  });

  factory StudentsModel.fromJson(Map<String, dynamic> json) => StudentsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int userId;
  int collegeId;
  String session;
  int classGroupId;
  int datumClass;
  String serialNo;
  String rollNo;
  DateTime admissionDate;
  String mobileNo;
  String alternateMobileNo;
  String name;
  DateTime dob;
  String gender;
  String image;
  String imagePng;
  String father;
  String fatherQualification;
  String fatherOccupation;
  String fatherAadhar;
  String mother;
  String motherQualification;
  String motherOccupation;
  String motherAadhar;
  String pinCode;
  String district;
  String state;
  String tehsil;
  String villageMohalla;
  String aadhaarNumber;
  String religion;
  String previousSchool;
  String email;
  String reverifyData;
  String reverifyDate;
  String reverifierId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  dynamic casteId;
  dynamic subCasteId;
  String uniqueId;
  String promotionClassId;
  String promotionClassGroupId;
  int finalClassId;
  int finalClassGroupId;
  String finalClassName;
  String finalClassGroupName;
  User user;
  Attachments attachments;
  Guardian guardian;
  Details details;
  dynamic caste;
  dynamic subCaste;

  Datum({
    required this.id,
    required this.userId,
    required this.collegeId,
    required this.session,
    required this.classGroupId,
    required this.datumClass,
    required this.serialNo,
    required this.rollNo,
    required this.admissionDate,
    required this.mobileNo,
    required this.alternateMobileNo,
    required this.name,
    required this.dob,
    required this.gender,
    required this.image,
    required this.imagePng,
    required this.father,
    required this.fatherQualification,
    required this.fatherOccupation,
    required this.fatherAadhar,
    required this.mother,
    required this.motherQualification,
    required this.motherOccupation,
    required this.motherAadhar,
    required this.pinCode,
    required this.district,
    required this.state,
    required this.tehsil,
    required this.villageMohalla,
    required this.aadhaarNumber,
    required this.religion,
    required this.previousSchool,
    required this.email,
    required this.reverifyData,
    required this.reverifyDate,
    required this.reverifierId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.casteId,
    required this.subCasteId,
    required this.uniqueId,
    required this.promotionClassId,
    required this.promotionClassGroupId,
    required this.finalClassId,
    required this.finalClassGroupId,
    required this.finalClassName,
    required this.finalClassGroupName,
    required this.user,
    required this.attachments,
    required this.guardian,
    required this.details,
    required this.caste,
    required this.subCaste,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        collegeId: json["college_id"],
        session: json["session"] ?? "",
        classGroupId: json["class_group_id"] ?? "",
        datumClass: json["class"] ?? "",
        serialNo: json["serial_no"] ?? "",
        rollNo: (json["roll_no"]??"").toString(),
        admissionDate: DateTime.parse(json["admission_date"] =="" ? DateTime.now().toString():json["admission_date"]),
        mobileNo: json["mobile_no"] ?? "",
        alternateMobileNo: json["alternate_mobile_no"] ?? "",
        name: json["name"] ?? "",
        dob: DateTime.parse(json["dob"] =="" ? DateTime.now().toString():json["dob"]),
        gender: json["gender"] ?? "",
        image: json["image"] ?? "",
        imagePng: json["image_png"] ?? "",
        father: json["father"] ?? "",
        fatherQualification: json["father_qualification"] ?? "",
        fatherOccupation: json["father_occupation"] ?? "",
        fatherAadhar: json["father_aadhar"] ?? "",
        mother: json["mother"] ?? "",
        motherQualification: json["mother_qualification"] ?? "",
        motherOccupation: json["mother_occupation"] ?? "",
        motherAadhar: json["mother_aadhar"] ?? "",
        pinCode: json["pin_code"] ?? "",
        district: json["district"] ?? "",
        state: json["state"] ?? "",
        tehsil: json["tehsil"] ?? "",
        villageMohalla: json["village_mohalla"] ?? "",
        aadhaarNumber: json["aadhaar_number"] ?? "",
        religion: json["religion"] ?? "",
        previousSchool: json["previous_school"] ?? "",
        email: json["email"] ?? "",
        reverifyData: json["reverify_data"] ?? "",
        reverifyDate: json["reverify_date"] ?? "",
        reverifierId: json["reverifier_id"] ?? "",
        status: json["status"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] ?? "",
        casteId: json["caste_id"] ?? "",
        subCasteId: json["sub_caste_id"] ?? "",
        uniqueId: json["unique_id"] ?? "",
        promotionClassId: json["promotion_class_id"].toString() ?? "",
        promotionClassGroupId:
            json["promotion_class_group_id"].toString() ?? "",
        finalClassId: json["final_class_id"] ?? "",
        finalClassGroupId: json["final_class_group_id"] ?? "",
        finalClassName: json["final_class_name"] ?? "",
        finalClassGroupName: json["final_class_group_name"] ?? "",
        user: User.fromJson(json["user"]),
        attachments: Attachments.fromJson(
            json["attachments"] == "" ? {} : json["attachments"]),
        guardian:
            Guardian.fromJson(json["guardian"] == "" ? {} : json["guardian"]),
        details: Details.fromJson(json["details"] == "" ? {} : json["details"]),
        caste: json["caste"] ?? "",
        subCaste: json["sub_caste"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "college_id": collegeId,
        "session": session,
        "class_group_id": classGroupId,
        "class": datumClass,
        "serial_no": serialNo,
        "roll_no": rollNo,
        "admission_date":
            "${admissionDate.year.toString().padLeft(4, '0')}-${admissionDate.month.toString().padLeft(2, '0')}-${admissionDate.day.toString().padLeft(2, '0')}",
        "mobile_no": mobileNo,
        "alternate_mobile_no": alternateMobileNo,
        "name": name,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "image": image,
        "image_png": imagePng,
        "father": father,
        "father_qualification": fatherQualification,
        "father_occupation": fatherOccupation,
        "father_aadhar": fatherAadhar,
        "mother": mother,
        "mother_qualification": motherQualification,
        "mother_occupation": motherOccupation,
        "mother_aadhar": motherAadhar,
        "pin_code": pinCode,
        "district": district,
        "state": state,
        "tehsil": tehsil,
        "village_mohalla": villageMohalla,
        "aadhaar_number": aadhaarNumber,
        "religion": religion,
        "previous_school": previousSchool,
        "email": email,
        "reverify_data": reverifyData,
        "reverify_date": reverifyDate,
        "reverifier_id": reverifierId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "caste_id": casteId,
        "sub_caste_id": subCasteId,
        "unique_id": uniqueId,
        "promotion_class_id": promotionClassId,
        "promotion_class_group_id": promotionClassGroupId,
        "final_class_id": finalClassId,
        "final_class_group_id": finalClassGroupId,
        "final_class_name": finalClassName,
        "final_class_group_name": finalClassGroupName,
        "user": user.toJson(),
        "attachments": attachments.toJson(),
        "guardian": guardian.toJson(),
        "details": details.toJson(),
        "caste": caste,
        "sub_caste": subCaste,
      };
}

class Attachments {
  int id;
  int studentId;
  String applicantSign;
  String studentAadharFront;
  String studentAadharBack;
  String fatherAadharFront;
  String fatherAadharBack;
  String motherAadharFront;
  String motherAadharBack;
  String studentTc;
  String studentMarksheet;


  Attachments({
    required this.id,
    required this.studentId,
    required this.applicantSign,
    required this.studentAadharFront,
    required this.studentAadharBack,
    required this.fatherAadharFront,
    required this.fatherAadharBack,
    required this.motherAadharFront,
    required this.motherAadharBack,
    required this.studentTc,
    required this.studentMarksheet,

  });

  factory Attachments.fromJson(Map<String, dynamic> json) => Attachments(
        id: json["id"] ?? 0,
        studentId: json["student_id"] ?? 0,
        applicantSign: json["applicant_sign"] ?? "",
        studentAadharFront: json["student_aadhar_front"] ?? "",
        studentAadharBack: json["student_aadhar_back"] ?? "",
        fatherAadharFront: json["father_aadhar_front"] ?? "",
        fatherAadharBack: json["father_aadhar_back"] ?? "",
        motherAadharFront: json["mother_aadhar_front"] ?? "",
        motherAadharBack: json["mother_aadhar_back"] ?? "",
        studentTc: json["student_tc"] ?? "",
        studentMarksheet: json["student_marksheet"] ?? "",

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "applicant_sign": applicantSign,
        "student_aadhar_front": studentAadharFront,
        "student_aadhar_back": studentAadharBack,
        "father_aadhar_front": fatherAadharFront,
        "father_aadhar_back": fatherAadharBack,
        "mother_aadhar_front": motherAadharFront,
        "mother_aadhar_back": motherAadharBack,
        "student_tc": studentTc,
        "student_marksheet": studentMarksheet,

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

class Details {
  int id;
  int studentId;
  int collegeId;
  String academicYear;
  int applicationNo;
  String previousSchoolName;
  String previousPassedClass;
  String group;
  String timePeriodOfResidence;
  String bankName;
  String ifscCode;
  String branchAddress;
  String accountNumber;
  String accountHolderName;
  String applicantSign;
  String udisePen;
  int disabilityStatus;
  String disabilityType;
  String disabilityPercentage;
  String lastAcademicResult;
  String obtainedMarks;
  dynamic attendedDays;
  String studentBloodGroup;
  String studentWeight;
  String studentHeight;
  String createdAt;
  String updatedAt;

  Details({
    required this.id,
    required this.studentId,
    required this.collegeId,
    required this.academicYear,
    required this.applicationNo,
    required this.previousSchoolName,
    required this.previousPassedClass,
    required this.group,
    required this.timePeriodOfResidence,
    required this.bankName,
    required this.ifscCode,
    required this.branchAddress,
    required this.accountNumber,
    required this.accountHolderName,
    required this.applicantSign,
    required this.udisePen,
    required this.disabilityStatus,
    required this.disabilityType,
    required this.disabilityPercentage,
    required this.lastAcademicResult,
    required this.obtainedMarks,
    required this.attendedDays,
    required this.studentBloodGroup,
    required this.studentWeight,
    required this.studentHeight,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"]??0,
        studentId: json["student_id"]??0,
        collegeId: json["college_id"]??0,
        academicYear: json["academic_year"]??"",
        applicationNo: json["application_no"]??0,
        previousSchoolName: json["previous_school_name"] ?? "",
        previousPassedClass: json["previous_passed_class"] ?? "",
        group: json["group"] ?? "",
        timePeriodOfResidence: json["time_period_of_residence"] ?? "",
        bankName: json["bank_name"] ?? "",
        ifscCode: json["ifsc_code"] ?? "",
        branchAddress: json["branch_address"] ?? "",
        accountNumber: json["account_number"] ?? "",
        accountHolderName: json["account_holder_name"] ?? "",
        applicantSign: json["applicant_sign"] ?? "",
        udisePen: json["udise_pen"] ?? "",
        disabilityStatus: json["disability_status"] ?? 0,
        disabilityType: json["disability_type"] ?? "",
        disabilityPercentage: json["disability_percentage"] ?? "",
        lastAcademicResult: json["last_academic_result"] ?? "",
        obtainedMarks: json["obtained_marks"] ?? "",
        attendedDays: json["attended_days"] ?? "",
        studentBloodGroup: json["student_blood_group"] ?? "",
        studentWeight: json["student_weight"] ?? "",
        studentHeight: json["student_height"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "college_id": collegeId,
        "academic_year": academicYear,
        "application_no": applicationNo,
        "previous_school_name": previousSchoolName,
        "previous_passed_class": previousPassedClass,
        "group": group,
        "time_period_of_residence": timePeriodOfResidence,
        "bank_name": bankName,
        "ifsc_code": ifscCode,
        "branch_address": branchAddress,
        "account_number": accountNumber,
        "account_holder_name": accountHolderName,
        "applicant_sign": applicantSign,
        "udise_pen": udisePen,
        "disability_status": disabilityStatus,
        "disability_type": disabilityType,
        "disability_percentage": disabilityPercentage,
        "last_academic_result": lastAcademicResult,
        "obtained_marks": obtainedMarks,
        "attended_days": attendedDays,
        "student_blood_group": studentBloodGroup,
        "student_weight": studentWeight,
        "student_height": studentHeight,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Guardian {
  int id;
  int studentId;
  String guardianName;
  String guardianMobile;
  String guardianAlternateMobile;
  String guardianEmail;
  String relationshipWithStudent;
  String guardianAddress;
  String guardianPinCode;
  String guardianState;
  String guardianDistrict;
  String guardianTehsil;
  String guardianVillageMohalla;
  String guardianSign;
  String createdAt;
  String updatedAt;

  Guardian({
    required this.id,
    required this.studentId,
    required this.guardianName,
    required this.guardianMobile,
    required this.guardianAlternateMobile,
    required this.guardianEmail,
    required this.relationshipWithStudent,
    required this.guardianAddress,
    required this.guardianPinCode,
    required this.guardianState,
    required this.guardianDistrict,
    required this.guardianTehsil,
    required this.guardianVillageMohalla,
    required this.guardianSign,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        id: json["id"]??0,
        studentId: json["student_id"]??0,
        guardianName: json["guardian_name"] ?? "",
        guardianMobile: json["guardian_mobile"] ?? "",
        guardianAlternateMobile: json["guardian_alternate_mobile"] ?? "",
        guardianEmail: json["guardian_email"] ?? "",
        relationshipWithStudent: json["relationship_with_student"] ?? "",
        guardianAddress: json["guardian_address"] ?? "",
        guardianPinCode: json["guardian_pin_code"] ?? "",
        guardianState: json["guardian_state"] ?? "",
        guardianDistrict: json["guardian_district"] ?? "",
        guardianTehsil: json["guardian_tehsil"] ?? "",
        guardianVillageMohalla: json["guardian_village_mohalla"] ?? "",
        guardianSign: json["guardian_sign"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "guardian_name": guardianName,
        "guardian_mobile": guardianMobile,
        "guardian_alternate_mobile": guardianAlternateMobile,
        "guardian_email": guardianEmail,
        "relationship_with_student": relationshipWithStudent,
        "guardian_address": guardianAddress,
        "guardian_pin_code": guardianPinCode,
        "guardian_state": guardianState,
        "guardian_district": guardianDistrict,
        "guardian_tehsil": guardianTehsil,
        "guardian_village_mohalla": guardianVillageMohalla,
        "guardian_sign": guardianSign,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class User {
  int id;
  String name;
  String uniqueId;
  String mobileNumber;
  String mobileVerifiedAt;
  String accessType;
  int parentUserId;
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

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
