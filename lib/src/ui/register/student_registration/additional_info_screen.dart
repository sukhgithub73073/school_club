import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_dialog.dart';
import 'package:school_club/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:school_club/src/core/dialog_widgets/success_message_dialog.dart';
import 'package:school_club/src/core/drop_down/drop_list_model.dart';
import 'package:school_club/src/data/blocs/classes_bloc/classes_bloc.dart';
import 'package:school_club/src/data/blocs/groups_bloc/groups_bloc.dart';
import 'package:school_club/src/data/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:school_club/src/data/blocs/pincode_bloc/pincode_bloc.dart';
import 'package:school_club/src/data/blocs/register_bloc/register_bloc.dart';
import 'package:school_club/src/data/models/pincode_model.dart';
import 'package:school_club/src/ui/register/parent_detail_screen.dart';
import 'package:school_club/src/ui/register/student_registration/register_gaurdian_screen.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:school_club/src/utility/decoration_util.dart';
import 'package:school_club/src/utility/validation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_club/src/core/app_button.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_image_view.dart';
import 'package:school_club/src/core/app_input_field.dart';
import 'package:school_club/src/core/app_tap_widget.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/common_space.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/extension/app_extension.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

class AdditionalInfoScreen extends StatefulWidget {
  AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        leading: TapWidget(
          onTap: () {},
          child: Icon(
            Icons.arrow_back,
            color: colorWhite,
            size: 15.h,
          ),
        ),
        title: TextView(
          text: "additionalInfo",
          color: colorWhite,
          textSize: 16.sp,
          textAlign: TextAlign.center,
          style: AppTextStyleEnum.medium,
          fontFamily: Family.medium,
          lineHeight: 1.3,
        ),
        actions: [
          TapWidget(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextView(
                text: "skip",
                color: colorWhite,
                textSize: 14.sp,
                textAlign: TextAlign.center,
                style: AppTextStyleEnum.medium,
                fontFamily: Family.medium,
                lineHeight: 1.3,
              ),
            ),
          )
        ],
      ),
      body: ListView(shrinkWrap: true, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceVertical(space: 10.h),
              CustomTextField(
                  controller: StudentData.penCtrl,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  paddingHorizontal: 20.0,
                  hasViewHight: false,
                  labelText: "udisePen",
                  hintText: "udisePen",
                  numberOfLines: 1,
                  hintFontWeight: FontWeight.w400,
                  hintTextColor: colorGray.withOpacity(0.6)),
              spaceVertical(space: 15.h),
              Row(
                children: [
                  TextView(
                    text: "disability",
                    color: colorBlack,
                    textSize: 14.sp,
                    textAlign: TextAlign.center,
                    style: AppTextStyleEnum.regular,
                    fontFamily: Family.regular,
                    lineHeight: 1.3,
                  ),
                  spaceHorizontal(space: 10.w),
                  RadioGroup(
                    controller: StudentData.disabilityRadioController,
                    values: ["Yes", "No"],
                    indexOfDefault: 0,
                    orientation: RadioGroupOrientation.horizontal,
                    decoration: RadioGroupDecoration(
                      spacing: 10.0,
                      labelStyle: TextStyle(
                        color: colorBlack,
                      ),
                      activeColor: colorPrimary,
                    ),
                  )
                ],
              ),
              spaceVertical(space: 15.h),
              CustomDropdown<DropListModel>(
                hintText: tr("selectDisabilityType"),
                items: StudentData.disabilityTypeList,
                decoration: customDropdownDecoration,
                excludeSelected: false,
                onChanged: (item) {},
              ),
              spaceVertical(space: 15.h),
              CustomTextField(
                  controller: StudentData.disabilityCtrl,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  paddingHorizontal: 20.0,
                  hasViewHight: false,
                  labelText: "disabilityPercent",
                  hintText: "disabilityPercent",
                  numberOfLines: 1,
                  hintFontWeight: FontWeight.w400,
                  hintTextColor: colorGray.withOpacity(0.6)),
              spaceVertical(space: 15.h),
              Row(
                children: [
                  TextView(
                    text: "result",
                    color: colorBlack,
                    textSize: 14.sp,
                    textAlign: TextAlign.center,
                    style: AppTextStyleEnum.regular,
                    fontFamily: Family.regular,
                    lineHeight: 1.3,
                  ),
                  spaceHorizontal(space: 10.w),
                  RadioGroup(
                    controller: StudentData.resultRadioController,
                    values: [tr("pass"), tr("fail"), tr("noResult")],
                    indexOfDefault: 0,
                    orientation: RadioGroupOrientation.horizontal,
                    decoration: RadioGroupDecoration(
                      spacing: 10.0,
                      labelStyle: TextStyle(
                        color: colorBlack,
                      ),
                      activeColor: colorPrimary,
                    ),
                  )
                ],
              ),
              spaceVertical(space: 15.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        controller: StudentData.obtainMarksCtrl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(12),
                        ],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        paddingHorizontal: 20.0,
                        hasViewHight: false,
                        labelText: "obtainMarks",
                        hintText: "obtainMarks",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: colorGray.withOpacity(0.6)),
                  ),
                  spaceHorizontal(space: 10.w),
                  Expanded(
                    child: CustomTextField(
                        controller: StudentData.attendedDaysCtrl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(12),
                        ],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        paddingHorizontal: 20.0,
                        hasViewHight: false,
                        labelText: "attendedDays",
                        hintText: "attendedDays",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: colorGray.withOpacity(0.6)),
                  ),
                ],
              ),
              spaceVertical(space: 15.h),
              CustomTextField(
                  controller: StudentData.emailCtrl,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  paddingHorizontal: 20.0,
                  hasViewHight: false,
                  labelText: "email",
                  hintText: "emailHere",
                  numberOfLines: 1,
                  hintFontWeight: FontWeight.w400,
                  hintTextColor: colorGray.withOpacity(0.6)),
              spaceVertical(space: 15.h),
              CustomDropdown<DropListModel>(
                hintText: tr("selectBloodGroup"),
                items: StudentData.bloodGroupList,
                decoration: customDropdownDecoration,
                excludeSelected: false,
                onChanged: (item) {},
              ),
              spaceVertical(space: 15.h),
              CustomTextField(
                  controller: StudentData.weightCtrl,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  paddingHorizontal: 20.0,
                  hasViewHight: false,
                  labelText: "studentWeight",
                  hintText: "studentWeight",
                  numberOfLines: 1,
                  hintFontWeight: FontWeight.w400,
                  hintTextColor: colorGray.withOpacity(0.6)),
              spaceVertical(space: 15.h),
              CustomTextField(
                  controller: StudentData.heightCtrl,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  paddingHorizontal: 20.0,
                  hasViewHight: false,
                  labelText: "studentHeight",
                  hintText: "studentHeight",
                  numberOfLines: 1,
                  hintFontWeight: FontWeight.w400,
                  hintTextColor: colorGray.withOpacity(0.6)),
              spaceVertical(space: 15.h),
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    appDialog(
                        context: context,
                        child: SuccessDailog(
                          title: "successfully",
                          onTap: () {
                            context.back();
                            context.back();
                          },
                          message: "${state.userModel.message}",
                        ));
                  } else if (state is RegisterError) {
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
                        context.read<RegisterBloc>().add(DoRegisterEvent(map: {
                              "college_id": 4,
                              "class_group_id": 1,
                              "class": 10,
                              "name": StudentData.nameController.text,
                              "mobile_no": StudentData.mobileGaurdianCtrl.text,
                              "roll_no": 123,
                              "father": StudentData.nameControllerFather.text,
                              "serial_no": "SR123",
                              "session": "2023-2024",
                              "application_no": "APP123",
                              "aadhaar_number": 123456789012,
                              "admission_date": "2023-06-27",
                              "dob": "2005-01-01",
                              "gender": "Male",
                              "religion": "Christianity",
                              "caste_id": 1,
                              "sub_caste_id": 4,
                              "father_occupation": "Engineer",
                              "mother": "Jane Doe",
                              "mother_occupation": "Teacher",
                              "pin_code": 123456,
                              "district": "District Name",
                              "state": "State Name",
                              "tehsil": "Tehsil Name",
                              "village_mohalla": "Village Name",
                              "guardian_name": "Guardian Name",
                              "relationship_with_student": "Uncle",
                              "guardian_address": "Guardian Address",
                              "guardian_pin_code": 654321,
                              "guardian_district": "Guardian District",
                              "guardian_tehsil": "Guardian Tehsil",
                              "guardian_village_mohalla": "Guardian Village",
                              "guardian_mobile": 9876543210,
                              "guardian_alternate_mobile": 0123456789,
                              "previous_school": "Previous School Name",
                              "previous_passed_class": 9,
                              "group": "Science",
                              "time_period_of_residence": "5 years",
                              "bank_name": "Bank Name",
                              "ifsc_code": "IFSC1234",
                              "branch_address": "Branch Address",
                              "account_number": 1234567890,
                              "account_holder_name": "John Doe",
                              "guardian_email": "john.doe@example.com",
                              "udise_pen": "UDISE12345",
                              "academic_year": "2023-2024",
                              "disability_status": 1,
                              "disability_type": "Visual Impairment",
                              "disability_percentage": 40.5,
                              "last_academic_result": "Passed",
                              "obtained_marks": 85.5,
                              "attended_days": 180,
                              "student_blood_group": "O+",
                              "student_weight": 60.5,
                              "student_height": 170.5
                            }));

                        appDialog(
                            context: context,
                            child: SuccessDailog(
                              title: "successfully",
                              onTap: () {
                                context.back();
                              },
                              message: "Successfully student register",
                            ));
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
    );
  }
}
//
