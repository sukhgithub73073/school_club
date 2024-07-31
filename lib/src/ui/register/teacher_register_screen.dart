import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_dialog.dart';
import 'package:school_club/src/core/app_strings.dart';
import 'package:school_club/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:school_club/src/core/dialog_widgets/success_message_dialog.dart';
import 'package:school_club/src/core/drop_down/drop_list_model.dart';
import 'package:school_club/src/data/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:school_club/src/data/blocs/pincode_bloc/pincode_bloc.dart';
import 'package:school_club/src/data/blocs/register_bloc/register_bloc.dart';
import 'package:school_club/src/data/models/pincode_model.dart';
import 'package:school_club/src/enums/role_enum.dart';
import 'package:school_club/src/enums/snack_type_enum.dart';
import 'package:school_club/src/ui/dashboard/main_screen.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:school_club/src/utility/decoration_util.dart';
import 'package:school_club/src/utility/firestore_table.dart';
import 'package:school_club/src/utility/validation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_club/src/core/app_button.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_image_view.dart';
import 'package:school_club/src/core/app_input_field.dart';
import 'package:school_club/src/core/app_tap_widget.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/common_space.dart';
import 'dart:math';

import 'package:school_club/src/core/custom_clipper.dart';
import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/extension/app_extension.dart';

class TeacherRegisterScreen extends StatefulWidget {
  TeacherRegisterScreen({super.key});

  @override
  State<TeacherRegisterScreen> createState() => _TeacherRegisterScreenState();
}

class _TeacherRegisterScreenState extends State<TeacherRegisterScreen> {
  var nameController = TextEditingController(text: "");
  var mobileController = TextEditingController(text: "");
  var fatherController = TextEditingController(text: "");
  var motherController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var dobController = TextEditingController(text: "");
  var pincodeController = TextEditingController(text: "");
  var stateController = TextEditingController(text: "");
  var districtController = TextEditingController(text: "");
  var tehsilController = TextEditingController(text: "");
  var villMohallaController = TextEditingController(text: "");
  var selectedPostOfficeAddress;
  DropListModel? selectedDesignations;
  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    StudentData.resetImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: _registerFormKey,
            child: Stack(
              children: [
                ImageView(
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
                            border:
                                Border.all(color: colorSecendry, width: 3.w),
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
                            CustomTextField(
                                controller: nameController,
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
                                controller: mobileController,
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
                            CustomTextField(
                                controller: fatherController,
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
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                paddingHorizontal: 20.0,
                                hasViewHight: false,
                                labelText: "email",
                                hintText: "emailHere",
                                numberOfLines: 1,
                                hintFontWeight: FontWeight.w400,
                                hintTextColor: colorGray.withOpacity(0.6)),
                            spaceVertical(space: 20.h),
                            TapWidget(
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          primaryColor: colorPrimary,
                                          colorScheme: ColorScheme.light(
                                              primary: colorPrimary),
                                          buttonTheme: ButtonThemeData(
                                            textTheme: ButtonTextTheme.primary,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                if (selectedDate != null) {
                                  String formattedDate =
                                      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                                  dobController.text =
                                      formattedDate; // Uprdate the text field with the selected date
                                }
                              },
                              child: CustomTextField(
                                  controller: dobController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  paddingHorizontal: 20.0,
                                  hasViewHight: false,
                                  labelText: "dob",
                                  hintText: "dobHere",
                                  numberOfLines: 1,
                                  enabled: false,
                                  hintFontWeight: FontWeight.w400,
                                  hintTextColor: colorGray.withOpacity(0.6)),
                            ),
                            spaceVertical(space: 20.h),
                            CustomDropdown<DropListModel>(
                              hintText: tr("designations"),
                              items: getDesignationsList(),
                              decoration: customDropdownDecoration,
                              excludeSelected: false,
                              onChanged: (item) {
                                selectedDesignations = item;
                              },
                            ),
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
                                        controller: pincodeController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        paddingHorizontal: 20.0,
                                        hasViewHight: false,
                                        labelText: "pincode",
                                        hintText: "pincodeHere",
                                        numberOfLines: 1,
                                        hintFontWeight: FontWeight.w400,
                                        onChanged: (e) {
                                          if (pincodeController.text.length ==
                                              6) {
                                            context.read<PincodeBloc>().add(
                                                GetInfoPincodeEvent(
                                                    pincode: pincodeController
                                                        .text));
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

                                  stateController.text = postOffice.state;
                                  districtController.text = postOffice.district;
                                  return Column(
                                    children: [
                                      spaceVertical(space: 20.h),
                                      CustomTextField(
                                          controller: stateController,
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
                                          controller: districtController,
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
                                          controller: tehsilController,
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
                                controller: villMohallaController,
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
                                  decoration:
                                      BoxDecoration(color: colorPrimary),
                                  child: AppSimpleButton(
                                    onDoneFuction: () async {
                                      if (nameController.text.isEmpty) {
                                        context.showSnackBar(
                                            title: tr("error"),
                                            message: tr("nameError"),
                                            snackTypeEnum: SnackTypeEnum.error);
                                      } else if (mobileController.text.length !=
                                          10) {
                                        context.showSnackBar(
                                            title: tr("error"),
                                            message: tr("mobileError"),
                                            snackTypeEnum: SnackTypeEnum.error);
                                      } else {
                                        var map = {
                                          'college_id':
                                              '${AppData.userModel.data?.data.college.id ?? ""}',
                                          'user_id':
                                              '${AppData.userModel.data?.data.id ?? ""}',
                                          'session': "${DateTime.now().year}",
                                          'name': nameController.text,
                                          'dob': dobController.text,
                                          'gender': '',
                                          'father': fatherController.text,
                                          'designation':
                                              selectedDesignations == null
                                                  ? "CLASS TEACHER"
                                                  : selectedDesignations?.name,
                                          'qualification': '',
                                          'email': emailController.text,
                                          'mobile_no': mobileController.text,
                                          'alternate_mobile_no': "",
                                          'pin_code': pincodeController.text,
                                          'state': stateController.text,
                                          'district': districtController.text,
                                          'tehsil': tehsilController.text,
                                          'village_mohalla':
                                              villMohallaController.text,
                                          'religion': '',
                                          'caste_id': '',
                                          'sub_caste_id': '',
                                          'bank_name': '',
                                          'ifsc_code': '',
                                          'status': 'Active',
                                          'account_number': '',
                                          'confirm_account_number': '',
                                          'account_holder_name': '',
                                          "TYPE": RoleEnum.teacher.name
                                        };
                                        context
                                            .read<RegisterBloc>()
                                            .add(DoRegisterEvent(map: map));
                                      }
                                    },
                                    buttonBackgroundColor: colorPrimary,
                                    nameText: "register",
                                    textSize: 18.sp,
                                  ),
                                );
                              },
                            ),
                            spaceVertical(space: 10.h),
                          ],
                        ),
                      )
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//
