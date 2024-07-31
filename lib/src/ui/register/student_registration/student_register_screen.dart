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
import 'package:school_club/src/data/blocs/register_bloc/register_bloc.dart';
import 'package:school_club/src/data/models/group_class_model.dart';
import 'package:school_club/src/data/models/pincode_model.dart';
import 'package:school_club/src/enums/role_enum.dart';
import 'package:school_club/src/extension/app_extension.dart';
import 'package:school_club/src/ui/dashboard/main_screen.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';
import 'package:school_club/src/ui/register/student_registration/take_image_screen.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:school_club/src/utility/date_time_util.dart';
import 'package:school_club/src/utility/decoration_util.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  @override
  void initState() {
    super.initState();
    StudentData.clearStudentData();
    context.read<RegisterBloc>().add(GetSerialNoEvent());
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
                                if (state is ImagePickRemoveBg) {
                                  return Image.memory(state.file);
                                } else {
                                  if (state is ImagePickSuccess) {
                                    StudentData.selectedImage = state.file;
                                    return CircleAvatar(
                                      radius: 100,
                                      backgroundImage:
                                          FileImage(File(state.file.path)),
                                    );
                                  } else {
                                    return CircleAvatar(
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
                          // Container(
                          //   height: 40.h,
                          //   width: double.maxFinite,
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey),
                          //       boxShadow: [
                          //         BoxShadow(
                          //             color: colorPrimary.withOpacity(0.8),
                          //             blurRadius: 10,
                          //             blurStyle: BlurStyle.outer)
                          //       ],
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Expanded(
                          //         child: TapWidget(
                          //           onTap: () {
                          //             setState(() {
                          //               StudentData.admissionType = "new";
                          //             });
                          //           },
                          //           child: Container(
                          //             height: double.maxFinite,
                          //             decoration: BoxDecoration(
                          //                 color:
                          //                     StudentData.admissionType == "new"
                          //                         ? colorPrimary
                          //                         : colorWhite,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Center(
                          //               child: TextView(
                          //                 text: "newAddmission",
                          //                 color:
                          //                     StudentData.admissionType == "new"
                          //                         ? colorWhite
                          //                         : colorGray,
                          //                 textSize: 16.sp,
                          //                 textAlign: TextAlign.center,
                          //                 style: AppTextStyleEnum.medium,
                          //                 fontFamily: Family.medium,
                          //                 lineHeight: 1.3,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: TapWidget(
                          //           onTap: () {
                          //             setState(() {
                          //               StudentData.admissionType = "old";
                          //             });
                          //           },
                          //           child: Container(
                          //             height: double.maxFinite,
                          //             decoration: BoxDecoration(
                          //                 color:
                          //                     StudentData.admissionType == "old"
                          //                         ? colorPrimary
                          //                         : colorWhite,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Center(
                          //               child: TextView(
                          //                 text: "oldAddmission",
                          //                 color:
                          //                     StudentData.admissionType == "old"
                          //                         ? colorWhite
                          //                         : colorGray,
                          //                 textSize: 16.sp,
                          //                 textAlign: TextAlign.center,
                          //                 style: AppTextStyleEnum.medium,
                          //                 fontFamily: Family.medium,
                          //                 lineHeight: 1.3,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // spaceVertical(space: 20.h),
                          // CustomTextField(
                          //     controller: StudentData.srnoController,
                          //     textInputAction: TextInputAction.next,
                          //     keyboardType: TextInputType.text,
                          //     paddingHorizontal: 20.0,
                          //     hasViewHight: false,
                          //     labelText: "srNo",
                          //     hintText: "srNoHere",
                          //     numberOfLines: 1,
                          //     enabled: false,
                          //     hintFontWeight: FontWeight.w400,
                          //     hintTextColor: colorGray.withOpacity(0.6)),
                          // spaceVertical(space: 20.h),

                          BlocConsumer<GroupsBloc, GroupsState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is GroupsSuccess) {
                                printLog(
                                    "builder >>>>>>>>>>>>>>>>>${state is GroupsSuccess}");
                                List<DropListModel> list = [];
                                state.data.forEach((element) {
                                  list.add(DropListModel(
                                      id: "${element.id}",
                                      name: "${element.groupName}"));
                                });
                                return CustomDropdown<DropListModel>.search(
                                  hintText: tr("selectGroup"),
                                  items: list,
                                  excludeSelected: false,
                                  decoration: customDropdownDecoration,
                                  onChanged: (item) {
                                    StudentData.selectedPreviosGroup = item;
                                    print("sdssssssssssss${item!.id}");

                                    var data = state.data.firstWhere(
                                      (element) =>
                                          element.id.toString() == item!.id,
                                    );

                                    StudentData.selectedPreviosGroup = item;
                                    context
                                        .read<ClassesBloc>()
                                        .add(GetClassEvent(groupItem: data));

                                    // context.read<ClassesBloc>().add(GetClassesByGroupEvent(
                                    //     map: {
                                    //       'college_id':
                                    //       '${AppData.userModel.data?.data.college.id ?? ""}',
                                    //       'session': DateTime.now().year,
                                    //       'class_group_id': '${item?.id ?? ""}'
                                    //     }));
                                  },
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                          spaceVertical(space: 10.h),
                          BlocConsumer<ClassesBloc, ClassesState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is ClassesGetSuccess) {
                                printLog(
                                    "builder >>>>>>>>>>>>>>>>>${state is GroupsSuccess}");
                                List<DropListModel> list = [];
                                state.data.forEach((element) {
                                  list.add(DropListModel(
                                      id: "${element.id}",
                                      name: "${element.className}"));
                                });
                                return CustomDropdown<DropListModel>.search(
                                  hintText: tr("selectClass"),
                                  items: list,
                                  decoration: customDropdownDecoration,
                                  excludeSelected: false,
                                  onChanged: (item) {
                                    StudentData.selectedPreviosClass = item;
                                  },
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
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

                                    // FormField<String>(
                                    //   builder: (FormFieldState<String> s) {
                                    //     return InputDecorator(
                                    //       decoration: InputDecoration(
                                    //           contentPadding:
                                    //               EdgeInsets.fromLTRB(
                                    //                   12, 10, 20, 20),
                                    //           errorStyle: TextStyle(
                                    //               color: Colors.redAccent,
                                    //               fontSize: 16.0),
                                    //           border: OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       10.0))),
                                    //       child: DropdownButtonHideUnderline(
                                    //         child: DropdownButton<PostOffice>(
                                    //           style: TextStyle(
                                    //             fontSize: 16,
                                    //             color: Colors.grey,
                                    //           ),
                                    //           hint: Text(
                                    //             tr("selectTehsil"),
                                    //             style: TextStyle(
                                    //               color: Colors.grey,
                                    //               fontSize: 16,
                                    //             ),
                                    //           ),
                                    //           items: state.responseModel.data[0]
                                    //               .postOffice
                                    //               .map<
                                    //                       DropdownMenuItem<
                                    //                           PostOffice>>(
                                    //                   (PostOffice value) {
                                    //             return DropdownMenuItem(
                                    //               value: value,
                                    //               child: Row(
                                    //                 children: [
                                    //                   TextView(
                                    //                     text: "${value.name}",
                                    //                     color: colorGray,
                                    //                     textSize: 12.sp,
                                    //                     textAlign:
                                    //                         TextAlign.center,
                                    //                     style: AppTextStyleEnum
                                    //                         .medium,
                                    //                     fontFamily:
                                    //                         Family.medium,
                                    //                     lineHeight: 1.3,
                                    //                   )
                                    //                 ],
                                    //               ),
                                    //             );
                                    //           }).toList(),
                                    //           isExpanded: true,
                                    //           isDense: true,
                                    //           onChanged: (selectedItem) {
                                    //             setState(() {
                                    //               StudentData
                                    //                       .selectedPostOfficeAddress =
                                    //                   selectedItem;
                                    //             });
                                    //           },
                                    //           value: StudentData
                                    //               .selectedPostOfficeAddress,
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
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
                              controller: StudentData.mobileController,
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
                          // TapWidget(
                          //   onTap: () async {
                          //     DateTime? selectedDate = await showDatePicker(
                          //         context: context,
                          //         initialDate: DateTime.now(),
                          //         firstDate: DateTime(1900),
                          //         lastDate: DateTime.now(),
                          //         builder:
                          //             (BuildContext context, Widget? child) {
                          //           return Theme(
                          //             data: ThemeData.light().copyWith(
                          //               primaryColor: colorPrimary,
                          //               colorScheme: ColorScheme.light(
                          //                   primary: colorPrimary),
                          //               buttonTheme: ButtonThemeData(
                          //                 textTheme: ButtonTextTheme.primary,
                          //               ),
                          //             ),
                          //             child: child!,
                          //           );
                          //         });
                          //     if (selectedDate != null) {
                          //       String formattedDate =
                          //           "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                          //       StudentData.dobController.text =
                          //           formattedDate; // Uprdate the text field with the selected date
                          //     }
                          //   },
                          //   child: CustomTextField(
                          //       controller: StudentData.dobController,
                          //       inputFormatters: [
                          //         FilteringTextInputFormatter.digitsOnly,
                          //         LengthLimitingTextInputFormatter(12),
                          //       ],
                          //       textInputAction: TextInputAction.next,
                          //       keyboardType: TextInputType.number,
                          //       paddingHorizontal: 20.0,
                          //       hasViewHight: false,
                          //       labelText: "dob",
                          //       hintText: "dobHere",
                          //       numberOfLines: 1,
                          //       enabled: false,
                          //       hintFontWeight: FontWeight.w400,
                          //       hintTextColor: colorGray.withOpacity(0.6)),
                          // ),
                          // spaceVertical(space: 20.h),
                          spaceVertical(space: 30.h),
                          BlocConsumer<RegisterBloc, RegisterState>(
                            listener: (context, state) {
                              if (state is RegisterSuccess) {
                                appDialog(
                                    context: context,
                                    child: SuccessDailog(
                                      title: "successfully",
                                      onTap: () {
                                        context.pushReplacementScreen(
                                            nextScreen: MainScreen());
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
                                    var map = {
                                      'college_id':
                                          '${AppData.userModel.data?.data.college.id ?? ""}',
                                      "class_group_id":
                                          StudentData.selectedPreviosGroup.id,
                                      "class": StudentData
                                              .selectedPreviosClass?.id ??
                                          "",
                                      "name": StudentData.nameController.text,
                                      "mobile_no":
                                          StudentData.mobileController.text,
                                      "roll_no":
                                          StudentData.rollNoController.text,
                                      "serial_no":
                                          StudentData.srnoController.text,
                                      "father":
                                          StudentData.nameControllerFather.text,
                                      'session': DateTime.now().year,
                                      'aadhaar_number': '',
                                      "admission_date":
                                          DateTimeUtil.getCurrentDate(),
                                      "dob": StudentData.dobController.text,
                                      'gender': 'Male',
                                      "religion":
                                          StudentData.selectedReligion?.name ??
                                              "",
                                      'caste_id': '',
                                      'sub_caste_id': '',
                                      'father_occupation': '',
                                      'mother':
                                          StudentData.nameControllerMother.text,
                                      'mother_occupation': '',
                                      "pin_code":
                                          StudentData.pincodeController.text,
                                      "district":
                                          StudentData.districtController.text,
                                      "state": StudentData.stateController.text,
                                      "tehsil":
                                          StudentData.tehsilController.text,
                                      "village_mohalla": StudentData
                                          .villMohallaController.text,
                                      'guardian_name': '',
                                      'relationship_with_student': '',
                                      'guardian_address': '',
                                      'guardian_pin_code': '',
                                      'guardian_district': '',
                                      'guardian_tehsil': '',
                                      'guardian_village_mohalla': '',
                                      'guardian_mobile': '',
                                      'guardian_alternate_mobile': '',
                                      'previous_school': '',
                                      'previous_passed_class': '',
                                      'group': '',
                                      'time_period_of_residence': '',
                                      'bank_name': '',
                                      'ifsc_code': '',
                                      'branch_address': "",
                                      'account_number': "",
                                      'account_holder_name': "",
                                      'guardian_email': "",
                                      'udise_pen': "",
                                      'academic_year': "",
                                      'disability_status': "",
                                      'disability_type': "",
                                      'disability_percentage': "",
                                      'last_academic_result': "",
                                      'obtained_marks': "",
                                      'attended_days': "",
                                      'student_blood_group': "",
                                      'student_weight': "",
                                      'student_height': "",
                                      'image': "",
                                      'student_aadhar_front': "",
                                      'student_aadhar_back': "",
                                      'father_aadhar_front': "",
                                      'father_aadhar_back': "",
                                      'mother_aadhar_front': "",
                                      'mother_aadhar_back': "",
                                      'student_tc': "",
                                      'student_marksheet': "",
                                      "TYPE": RoleEnum.student.name
                                    };

                                    log(jsonEncode(map));

                                    context
                                        .read<RegisterBloc>()
                                        .add(DoRegisterEvent(map: map));
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
                      text: "studentsRegistrationForm",
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
