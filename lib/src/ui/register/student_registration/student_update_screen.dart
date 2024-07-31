import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_button.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_dialog.dart';
import 'package:school_club/src/core/app_image_view.dart';
import 'package:school_club/src/core/app_input_field.dart';
import 'package:school_club/src/core/app_tap_widget.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/common_space.dart';
import 'package:school_club/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:school_club/src/core/dialog_widgets/success_message_dialog.dart';
import 'package:school_club/src/core/drop_down/drop_list_model.dart';
import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/data/blocs/cast_bloc/cast_bloc.dart';
import 'package:school_club/src/data/blocs/classes_bloc/classes_bloc.dart';
import 'package:school_club/src/data/blocs/groups_bloc/groups_bloc.dart';
import 'package:school_club/src/data/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:school_club/src/data/blocs/pincode_bloc/pincode_bloc.dart';
import 'package:school_club/src/data/blocs/update_bloc/update_bloc.dart';
import 'package:school_club/src/data/models/group_class_model.dart';
import 'package:school_club/src/data/models/pincode_model.dart';
import 'package:school_club/src/data/network/http_service.dart';
import 'package:school_club/src/enums/role_enum.dart';
import 'package:school_club/src/extension/app_extension.dart';
import 'package:school_club/src/ui/dashboard/main_screen.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:school_club/src/utility/date_time_util.dart';
import 'package:school_club/src/utility/decoration_util.dart';

class StudentUpdateScreen extends StatefulWidget {
  const StudentUpdateScreen({super.key});

  @override
  State<StudentUpdateScreen> createState() => _StudentUpdateScreenState();
}

class _StudentUpdateScreenState extends State<StudentUpdateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              ImageView(
                  imageType: ImageType.asset,
                  url: AppAssets.topRound,
                  width: double.maxFinite,
                  height: 150.h,
                  fit: BoxFit.fill),
              ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorSecendry, width: 3.w),
                          color: colorWhite,
                          shape: BoxShape.circle),
                      child: Center(
                        child: Stack(
                          children: [
                            BlocConsumer<ImagePickBloc, ImagePickState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                {
                                  if (state is ImagePickSuccess) {
                                    StudentData.selectedImage = state.file;
                                    return CircleAvatar(
                                      radius: 100,
                                      backgroundImage:
                                          FileImage(File(state.file.path)),
                                    );
                                  } else {
                                    return (StudentData
                                                .selectedStudent?.image) !=
                                            ""
                                        ? CircleAvatar(
                                            radius: 100,
                                            backgroundImage: NetworkImage(
                                                "${ApisEndpoints.imagesPathStudent}${StudentData.selectedStudent?.image}"),
                                          )
                                        : CircleAvatar(
                                            radius: 100,
                                            backgroundImage:
                                                AssetImage(AppAssets.logo),
                                          );
                                  }
                                }
                              },
                            ),
                            Positioned(
                                bottom: 0,
                                right: 10,
                                child: TapWidget(
                                  onTap: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Wrap(
                                            children: <Widget>[
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title: Text('Gallery'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  context
                                                      .read<ImagePickBloc>()
                                                      .add(
                                                          ChangeImagePickEvent());
                                                },
                                              ),
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_camera),
                                                title: Text('Camera'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  context
                                                      .read<ImagePickBloc>()
                                                      .add(
                                                          CaptureImagePickEvent());
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: colorBlack, width: 1.w),
                                          color: colorWhite,
                                          shape: BoxShape.circle),
                                      child: Icon(Icons.camera_alt)),
                                ))
                          ],
                        ),
                      ),
                    ),
                    spaceVertical(space: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          spaceVertical(space: 20.h),
                          CustomTextField(
                              controller: StudentData.rollNoController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              paddingHorizontal: 20.0,
                              hasViewHight: false,
                              labelText: "rollNo",
                              hintText: "rollNoHere",
                              numberOfLines: 1,
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 20.h),
                          CustomTextField(
                              controller: StudentData.nameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              paddingHorizontal: 20.0,
                              hasViewHight: false,
                              labelText: "name",
                              hintText: "nameHere",
                              numberOfLines: 1,
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 20.h),
                          CustomTextField(
                              controller: StudentData.nameControllerFather,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              paddingHorizontal: 20.0,
                              hasViewHight: false,
                              labelText: "fatherName",
                              hintText: "fatherNameHere",
                              numberOfLines: 1,
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 20.h),
                          CustomTextField(
                              controller: StudentData.nameControllerMother,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              paddingHorizontal: 20.0,
                              hasViewHight: false,
                              labelText: "motherName",
                              hintText: "motherNameHere",
                              numberOfLines: 1,
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 20.h),
                          BlocConsumer<PincodeBloc, PincodeState>(
                            listener: (context, state) {
                              if (state is PincodeError) {
                                appDialog(
                                    context: context,
                                    child: ErrorDailog(
                                      title: "invalidPincode",
                                      onTap: () {
                                        context.back();
                                      },
                                      message: "${state.error}",
                                    ));
                              }
                            },
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  CustomTextField(
                                      controller: StudentData.pincodeController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      paddingHorizontal: 20.0,
                                      hasViewHight: false,
                                      labelText: "pincode",
                                      hintText: "pincodeHere",
                                      numberOfLines: 1,
                                      hintFontWeight: FontWeight.w400,
                                      onChanged: (e) {
                                        if (StudentData.pincodeController.text
                                                .length ==
                                            6) {
                                          context.read<PincodeBloc>().add(
                                              GetInfoPincodeEvent(
                                                  pincode: StudentData
                                                      .pincodeController.text));
                                        }
                                      },
                                      hintTextColor:
                                          colorGray.withOpacity(0.6)),
                                  state is PincodeLoading
                                      ? Positioned(
                                          bottom: 10,
                                          top: 10,
                                          right: 10,
                                          child: SizedBox(
                                            width: 25.0.w,
                                            height: 30.0.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3.0,
                                              color: colorPrimary,
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<PincodeBloc, PincodeState>(
                            builder: (context, state) {
                              if (state is PincodeSuccess) {
                                PostOffice postOffice =
                                    state.responseModel.data[0].postOffice[0];
                                print(
                                    ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                StudentData.stateController.text =
                                    postOffice.state;
                                StudentData.districtController.text =
                                    postOffice.district;
                                return Column(
                                  children: [
                                    spaceVertical(space: 20.h),
                                    CustomTextField(
                                        controller: StudentData.stateController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        paddingHorizontal: 20.0,
                                        hasViewHight: false,
                                        readOnly: true,
                                        labelText: "state",
                                        hintText: "state",
                                        numberOfLines: 1,
                                        hintFontWeight: FontWeight.w400,
                                        hintTextColor:
                                            colorGray.withOpacity(0.6)),
                                    spaceVertical(space: 20.h),
                                    CustomTextField(
                                        controller:
                                            StudentData.districtController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        paddingHorizontal: 20.0,
                                        hasViewHight: false,
                                        readOnly: true,
                                        labelText: "district",
                                        hintText: "district",
                                        numberOfLines: 1,
                                        hintFontWeight: FontWeight.w400,
                                        hintTextColor:
                                            colorGray.withOpacity(0.6)),
                                    spaceVertical(space: 20.h),
                                    CustomTextField(
                                        controller:
                                            StudentData.tehsilController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        paddingHorizontal: 20.0,
                                        hasViewHight: false,
                                        labelText: "selectTehsil",
                                        hintText: "tehsil",
                                        numberOfLines: 1,
                                        hintFontWeight: FontWeight.w400,
                                        hintTextColor:
                                            colorGray.withOpacity(0.6)),
                                  ],
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                          spaceVertical(space: 20.h),
                          CustomTextField(
                              controller: StudentData.villMohallaController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              paddingHorizontal: 20.0,
                              hasViewHight: false,
                              labelText: "villMohalla",
                              hintText: "villMohalla",
                              numberOfLines: 1,
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 30.h),
                          CustomTextField(
                              controller: StudentData.mobileGaurdianCtrl,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              paddingHorizontal: 20.0,
                              hasViewHight: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              labelText: "mobileNumber",
                              hintText: "mobileNumber",
                              numberOfLines: 1,
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 20.h),
                          spaceVertical(space: 30.h),
                          BlocConsumer<UpdateBloc, UpdateState>(
                            listener: (context, state) {
                              if (state is UpdateSuccess) {
                                appDialog(
                                    context: context,
                                    child: SuccessDailog(
                                      title: "successfully",
                                      onTap: () {
                                        context.pushReplacementScreen(
                                            nextScreen: MainScreen());
                                      },
                                      message:
                                          "Successfully update your record",
                                    ));
                              } else if (state is UpdateError) {
                                appDialog(
                                    context: context,
                                    child: ErrorDailog(
                                      title: "error",
                                      onTap: () {
                                        context.back();
                                      },
                                      message: "${state.error}",
                                    ));
                              }
                            },
                            builder: (context, state) {
                              return Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(color: colorPrimary),
                                child: AppSimpleButton(
                                  onDoneFuction: () async {
                                    var map = {
                                      "roll_no":
                                          StudentData.rollNoController.text,
                                      "name": StudentData.nameController.text,
                                      "father":
                                          StudentData.nameControllerFather.text,
                                      "mother":
                                          StudentData.nameControllerMother.text,
                                      "pin_code":
                                          StudentData.pincodeController.text,
                                      "district":
                                          StudentData.selectedStudent?.district,
                                      "state":
                                          StudentData.selectedStudent?.state,
                                      "tehsil":
                                          StudentData.tehsilController.text,
                                      "village_mohalla": StudentData
                                          .villMohallaController.text,
                                      "mobile_no":
                                          StudentData.mobileGaurdianCtrl.text,

                                      'college_id':
                                          '${StudentData.selectedStudent?.collegeId}',
                                      "class_group_id": StudentData
                                          .selectedStudent?.classGroupId,
                                      "class": StudentData
                                          .selectedStudent?.finalClassId,

                                      "serial_no":
                                          StudentData.selectedStudent?.serialNo,
                                      "session":
                                          StudentData.selectedStudent?.session,
                                      //"application_no": "APP123",
                                      "aadhaar_number": StudentData
                                          .selectedStudent?.aadhaarNumber,
                                      //"admission_date": DateTimeUtil.getCurrentDate(),
                                      "dob": StudentData.selectedStudent?.dob
                                          .toLocal(),
                                      "gender": "",
                                      "religion":
                                          StudentData.selectedStudent?.religion,
                                      "caste_id":
                                          StudentData.selectedStudent?.casteId,
                                      "sub_caste_id": StudentData
                                          .selectedStudent?.subCasteId,

                                      "father_occupation": StudentData
                                          .selectedStudent?.fatherOccupation,

                                      "mother_occupation": StudentData
                                          .selectedStudent?.motherOccupation,

                                      "guardian_name": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianName,
                                      "relationship_with_student": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .relationshipWithStudent,
                                      "guardian_mobile": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianMobile,
                                      "guardian_pin_code": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianPinCode,
                                      "guardian_district": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianDistrict,
                                      "guardian_tehsil": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianTehsil,
                                      "guardian_village_mohalla": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianVillageMohalla,
                                      "guardian_address": "Guardian Address",
                                      "guardian_alternate_mobile": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianAlternateMobile,
                                      "guardian_email": StudentData
                                          .selectedStudent
                                          ?.guardian
                                          .guardianEmail,
                                      "previous_school": StudentData
                                          .selectedStudent?.previousSchool,
                                      "group": StudentData
                                          .selectedStudent?.finalClassGroupName,
                                      "previous_passed_class": StudentData
                                          .selectedStudent
                                          ?.details
                                          .previousPassedClass,
                                      "time_period_of_residence": StudentData
                                          .selectedStudent
                                          ?.details
                                          .timePeriodOfResidence,
                                      "academic_year": StudentData
                                          .selectedStudent
                                          ?.details
                                          .academicYear,
                                      "bank_name": StudentData
                                          .selectedStudent?.details.bankName,
                                      "ifsc_code": StudentData
                                          .selectedStudent?.details.ifscCode,
                                      "branch_address": StudentData
                                          .selectedStudent
                                          ?.details
                                          .branchAddress,
                                      "account_number": StudentData
                                          .selectedStudent
                                          ?.details
                                          .accountNumber,
                                      "account_holder_name": StudentData
                                          .selectedStudent
                                          ?.details
                                          .accountHolderName,
                                      "udise_pen": StudentData
                                          .selectedStudent?.details.udisePen,
                                      "disability_status": StudentData
                                          .selectedStudent
                                          ?.details
                                          .disabilityStatus,
                                      "disability_type": StudentData
                                          .selectedStudent
                                          ?.details
                                          .disabilityType,
                                      "disability_percentage": StudentData
                                          .selectedStudent
                                          ?.details
                                          .disabilityPercentage,
                                      "last_academic_result": StudentData
                                          .selectedStudent
                                          ?.details
                                          .lastAcademicResult,
                                      "obtained_marks": StudentData
                                          .selectedStudent
                                          ?.details
                                          .obtainedMarks,
                                      "attended_days": StudentData
                                          .selectedStudent
                                          ?.details
                                          .attendedDays,
                                      "student_blood_group": StudentData
                                          .selectedStudent
                                          ?.details
                                          .studentBloodGroup,
                                      "student_weight": StudentData
                                          .selectedStudent
                                          ?.details
                                          .studentWeight,
                                      "student_height": StudentData
                                          .selectedStudent
                                          ?.details
                                          .studentHeight
                                    };
                                    context
                                        .read<UpdateBloc>()
                                        .add(UpdateStudentEvent(map: map));
                                  },
                                  buttonBackgroundColor: colorPrimary,
                                  nameText: "submit",
                                  textSize: 18.sp,
                                ),
                              );
                            },
                          ),
                          spaceVertical(space: 10.h),
                        ],
                      ),
                    ),
                    spaceVertical(space: 10.h),
                  ]),
              Positioned(
                top: 5.h,
                left: 5.w,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(color: colorWhite, Icons.arrow_back),
                      onPressed: () {
                        context.back();
                      },
                    ),
                    TextView(
                      text: "studentsUpdateForm",
                      color: colorWhite,
                      textSize: 16.sp,
                      textAlign: TextAlign.center,
                      style: AppTextStyleEnum.medium,
                      fontFamily: Family.medium,
                      lineHeight: 1.3,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
