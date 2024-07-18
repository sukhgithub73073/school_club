import 'dart:io';

import 'package:camera/camera.dart';
import 'package:school_club/src/data/blocs/cast_bloc/cast_bloc.dart';
import 'package:school_club/src/data/blocs/login_bloc/login_bloc.dart';
import 'package:school_club/src/data/models/cast_model.dart';
import 'package:school_club/src/ui/register/student_registration/register_parent.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';
import 'package:school_club/src/ui/register/student_registration/take_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_dialog.dart';
import 'package:school_club/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:school_club/src/core/dialog_widgets/success_message_dialog.dart';
import 'package:school_club/src/core/drop_down/drop_list_model.dart';

import 'package:school_club/src/data/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:school_club/src/data/blocs/register_bloc/register_bloc.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:school_club/src/utility/decoration_util.dart';
import 'package:flutter/cupertino.dart';
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

class RegisterOne extends StatefulWidget {
  const RegisterOne({super.key});

  @override
  State<RegisterOne> createState() => _RegisterOneState();
}

class _RegisterOneState extends State<RegisterOne> {
  @override
  void initState() {
    super.initState();
    context
        .read<CastBloc>()
        .add(GetCastEvent());

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
                                    context.pushScreen(
                                        nextScreen: CameraExampleHome());

                                    // context
                                    //     .read<ImagePickBloc>()
                                    //     .add(ChangeImagePickEvent());
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
                          Container(
                            height: 40.h,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                      color: colorPrimary.withOpacity(0.8),
                                      blurRadius: 10,
                                      blurStyle: BlurStyle.outer)
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TapWidget(
                                    onTap: () {
                                      setState(() {
                                        StudentData.admissionType = "new";
                                      });
                                    },
                                    child: Container(
                                      height: double.maxFinite,
                                      decoration: BoxDecoration(
                                          color:
                                              StudentData.admissionType == "new"
                                                  ? colorPrimary
                                                  : colorWhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: TextView(
                                          text: "newAddmission",
                                          color:
                                              StudentData.admissionType == "new"
                                                  ? colorWhite
                                                  : colorGray,
                                          textSize: 16.sp,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyleEnum.medium,
                                          fontFamily: Family.medium,
                                          lineHeight: 1.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TapWidget(
                                    onTap: () {
                                      setState(() {
                                        StudentData.admissionType = "old";
                                      });
                                    },
                                    child: Container(
                                      height: double.maxFinite,
                                      decoration: BoxDecoration(
                                          color:
                                              StudentData.admissionType == "old"
                                                  ? colorPrimary
                                                  : colorWhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: TextView(
                                          text: "oldAddmission",
                                          color:
                                              StudentData.admissionType == "old"
                                                  ? colorWhite
                                                  : colorGray,
                                          textSize: 16.sp,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyleEnum.medium,
                                          fontFamily: Family.medium,
                                          lineHeight: 1.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          spaceVertical(space: 20.h),
                          if (StudentData.admissionType == "old") ...[
                            CustomTextField(
                                controller: StudentData.srnoController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                paddingHorizontal: 20.0,
                                hasViewHight: false,
                                labelText: "srNo",
                                hintText: "srNoHere",
                                numberOfLines: 1,
                                hintFontWeight: FontWeight.w400,
                                hintTextColor: colorGray.withOpacity(0.6)),
                            spaceVertical(space: 20.h),
                          ],
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
                              controller: StudentData.aadhaarController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12),
                              ],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              paddingHorizontal: 20.0,
                              hasViewHight: false,
                              labelText: "aadhaarNumber",
                              hintText: "aadhaarNumberHere",
                              numberOfLines: 1,
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 20.h),
                          CustomTextField(
                              controller: StudentData.dobController,
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
                              hintFontWeight: FontWeight.w400,
                              hintTextColor: colorGray.withOpacity(0.6)),
                          spaceVertical(space: 20.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RadioGroup(
                              controller: StudentData.myController,
                              values: [tr("male"), tr("female"), tr("other")],
                              indexOfDefault: 0,
                              orientation: RadioGroupOrientation.horizontal,
                              decoration: RadioGroupDecoration(
                                spacing: 10.0,
                                labelStyle: TextStyle(
                                  color: colorBlack,
                                ),
                                activeColor: colorPrimary,
                              ),
                            ),
                          ),
                          spaceVertical(space: 20.h),
                          CustomDropdown<DropListModel>.search(
                            hintText: tr("selectReligion"),
                            items: getReligionList(),
                            decoration: customDropdownDecoration,
                            excludeSelected: false,
                            onChanged: (item) {},
                          ),
                          spaceVertical(space: 20.h),
                          BlocConsumer<CastBloc, CastState>(
                            listener: (context, state) {
                              print(">>>>>>>>>>>>>>>>>>>>>>>>>>.${state.toString()}");
                            },
                            builder: (context, state) {
                              return state is CastLoaded
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: CustomDropdown<Caste>(
                                            hintText: tr("selectCaste"),
                                            items: state.casteModel.data.caste,
                                            decoration:
                                                customDropdownDecoration,
                                            excludeSelected: false,
                                            onChanged: (item) {
                                              AppData.subCastList.clear();
                                              AppData.subCastList.addAll(state
                                                  .casteModel.data.subCaste
                                                  .where((s) =>
                                                      s.casteId == item!.id));
                                            },
                                          ),
                                        ),
                                        spaceHorizontal(space: 10.w),
                                        Expanded(
                                          child: CustomDropdown<
                                              Caste>.search(
                                            hintText: tr("selectSubCaste"),
                                            items: AppData.subCastList,
                                            decoration:
                                                customDropdownDecoration,
                                            excludeSelected: false,
                                            onChanged: (item) {},
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink();
                            },
                          ),
                          spaceVertical(space: 20.h),
                          spaceVertical(space: 30.h),
                          BlocConsumer<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              return Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(color: colorPrimary),
                                child: AppSimpleButton(
                                  onDoneFuction: () async {
                                    context.pushScreen(
                                        nextScreen: RegisterParent());
                                  },
                                  buttonBackgroundColor: colorPrimary,
                                  nameText: "submit",
                                  textSize: 18.sp,
                                ),
                              );
                            },
                            listener:
                                (BuildContext context, RegisterState state) {},
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
