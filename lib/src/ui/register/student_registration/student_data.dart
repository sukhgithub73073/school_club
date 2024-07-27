import 'package:camera/camera.dart';
import 'package:school_club/src/core/drop_down/drop_list_model.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';

import '../../../data/models/cast_model.dart';

class StudentData{
  static XFile selectedImage = XFile("") ;


  static var nameController = TextEditingController(text: "");
  static var aadhaarController = TextEditingController(text: "");
  static var dobController = TextEditingController(text: "");
  static var srnoController = TextEditingController(text: "");
  static var rollNoController = TextEditingController(text: "");
  static var admissionType = "new";
  static var genderCtrl = RadioGroupController();
  static DropListModel? selectedReligion ;
  static Caste? selectedCast ;
  static Caste? selectedSubCast ;
  static DropListModel? selectFatherOcc ;
  static DropListModel? selectFatherQualification ;
  static DropListModel? selectMotherOcc ;
  static DropListModel? selectMotherQualification ;


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
  static var villMohallaController = TextEditingController(text: "");
  static var pincodeAddressController = TextEditingController(text: "");
  static var selectedPostOfficeAddress;

  static var stateGaurdianCtrl = TextEditingController(text: "");
  static var districtGaurdianCtrl = TextEditingController(text: "");
  static var villageMohalaGaurdianCtrl = TextEditingController(text: "");

  static var pincodeGaurdianCtrl = TextEditingController(text: "");
  static var nameGaurdianCtrl = TextEditingController(text: "");
  static var relationshipGaurdianCtrl = TextEditingController(text: "");
  static var mobileGaurdianCtrl = TextEditingController(text: "");
  static var selectedPostOfficeGaurdian;

  static var previosSchoolCtrl = TextEditingController(text: "");
  static var timeCtrl = TextEditingController(text: "");
  static DropListModel? selectedGroup;
  static DropListModel? selectedClass;

  static var selectedPreviosGroup;
  static var selectedPreviosClass;
  static var bankNameCtrl= TextEditingController(text: "");
  static var ifscCtrl= TextEditingController(text: "");
  static var branchAddressCtrl= TextEditingController(text: "");
  static var accountCtrl= TextEditingController(text: "");
  static var holderNameCtrl= TextEditingController(text: "");

  static var penCtrl = TextEditingController(text: "");
  static var selectDisabilityType ;
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

  static DropListModel? selectedBloodGroup;

  static void resetImage() {
    selectedImage = XFile("") ;
  }
  static void clearStudentData() {
    selectedImage = XFile("") ;
    nameController.clear();
    aadhaarController.clear();
    dobController.clear();
    srnoController.clear();
    rollNoController.clear();
    admissionType = "new"; // Assuming this is the default value
    genderCtrl = RadioGroupController(); // Reset the radio group controller
    selectedReligion = null;
    selectedCast = null;
    selectedSubCast = null;
    selectFatherOcc = null;
    selectFatherQualification = null;
    selectMotherOcc = null;
    selectMotherQualification = null;

    addressController.clear();
    pincodeController.clear();
    selectedPostOffice = null;
    nameControllerFather.clear();
    aadharControllerFather.clear();
    nameControllerMother.clear();
    aadharControllerMother.clear();
    occupationList = getOccupationList(); // Reload the default occupation list
    qualificationList = getQualificationList(); // Reload the default qualification list

    stateController.clear();
    districtController.clear();
    tehsilController.clear();
    villMohallaController.clear();
    pincodeAddressController.clear();
    selectedPostOfficeAddress = null;

    stateGaurdianCtrl.clear();
    districtGaurdianCtrl.clear();
    villageMohalaGaurdianCtrl.clear();
    pincodeGaurdianCtrl.clear();
    nameGaurdianCtrl.clear();
    relationshipGaurdianCtrl.clear();
    mobileGaurdianCtrl.clear();
    selectedPostOfficeGaurdian = null;

    previosSchoolCtrl.clear();
    timeCtrl.clear();
    selectedGroup = null;
    selectedClass = null;

    selectedPreviosGroup = null;
    selectedPreviosClass = null;
    bankNameCtrl.clear();
    ifscCtrl.clear();
    branchAddressCtrl.clear();
    accountCtrl.clear();
    holderNameCtrl.clear();

    penCtrl.clear();
    selectDisabilityType = null;
    obtainMarksCtrl.clear();
    attendedDaysCtrl.clear();
    emailCtrl.clear();
    disabilityCtrl.clear();
    weightCtrl.clear();
    heightCtrl.clear();
    bloodGroupList = getBloodGroupList(); // Reload the default blood group list
    disabilityTypeList = getDisabilityTypeList(); // Reload the default disability type list
    disabilityRadioController = RadioGroupController(); // Reset the disability radio controller
    resultRadioController = RadioGroupController(); // Reset the result radio controller
    selectedBloodGroup = null;
  }




}