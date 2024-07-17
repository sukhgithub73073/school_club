import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';

class StudentData{


  static var nameController = TextEditingController(text: "");
  static var aadhaarController = TextEditingController(text: "");
  static var dobController = TextEditingController(text: "");
  static var srnoController = TextEditingController(text: "");
  static var admissionType = "new";
  static RadioGroupController myController = RadioGroupController();

  static var addressController = TextEditingController(text: "");
  static var pincodeController = TextEditingController(text: "");
  static var selectedPostOffice;
  static var nameControllerFather = TextEditingController(text: "");
  static var aadharControllerFather = TextEditingController(text: "");
  static var nameControllerMother = TextEditingController(text: "");
  static var aadharControllerMother = TextEditingController(text: "");
  static var occupationList = getOccupationList();
  static var qualificationList = getQualificationList();

  static var stateController = TextEditingController(text: "");
  static var districtController = TextEditingController(text: "");
  static var tehsilController = TextEditingController(text: "");
  static var addressAddressController = TextEditingController(text: "");
  static var pincodeAddressController = TextEditingController(text: "");
  static var selectedPostOfficeAddress;

  static var stateGaurdianCtrl = TextEditingController(text: "");
  static var districtGaurdianCtrl = TextEditingController(text: "");
  static var addressGaurdianCtrl = TextEditingController(text: "");
  static var pincodeGaurdianCtrl = TextEditingController(text: "");
  static var nameGaurdianCtrl = TextEditingController(text: "");
  static var relationshipGaurdianCtrl = TextEditingController(text: "");
  static var mobileGaurdianCtrl = TextEditingController(text: "");
  static var selectedPostOfficeGaurdian;

  static var previosSchoolCtrl = TextEditingController(text: "");
  static var timeCtrl = TextEditingController(text: "");
  static var selectedGroup;
  static var selectedClass;
  static var bankNameCtrl= TextEditingController(text: "");
  static var ifscCtrl= TextEditingController(text: "");
  static var branchAddressCtrl= TextEditingController(text: "");
  static var accountCtrl= TextEditingController(text: "");
  static var holderNameCtrl= TextEditingController(text: "");

  static var penCtrl = TextEditingController(text: "");
  static var obtainMarksCtrl = TextEditingController(text: "");
  static var attendedDaysCtrl = TextEditingController(text: "");
  static var emailCtrl = TextEditingController(text: "");
  static var disabilityCtrl = TextEditingController(text: "");
  static var weightCtrl = TextEditingController(text: "");
  static var heightCtrl = TextEditingController(text: "");
  static var bloodGroupList = getBloodGroupList();
  static var disabilityTypeList = getDisabilityTypeList();
  static RadioGroupController disabilityRadioController = RadioGroupController();
  static RadioGroupController resultRadioController = RadioGroupController();



}