import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_dialog.dart';
import 'package:school_club/src/core/app_image_view.dart';
import 'package:school_club/src/core/app_loader.dart';
import 'package:school_club/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:school_club/src/core/dialog_widgets/success_message_dialog.dart';
import 'package:school_club/src/core/drop_down/drop_list_model.dart';
import 'package:school_club/src/data/blocs/classes_bloc/classes_bloc.dart';
import 'package:school_club/src/data/blocs/groups_bloc/groups_bloc.dart';
import 'package:school_club/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_club/src/core/app_button.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_input_field.dart';
import 'package:school_club/src/core/app_tap_widget.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/common_space.dart';
import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/extension/app_extension.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateClassesScreen extends StatefulWidget {
  CreateClassesScreen({super.key});

  @override
  State<CreateClassesScreen> createState() => _CreateClassesScreenState();
}

class _CreateClassesScreenState extends State<CreateClassesScreen> {
  var nameController = TextEditingController(text: "Middle");
  DropListModel? selectedGroup;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoleBloc, RoleState>(
      listener: (context, state) {},
      builder: (context, roleState) {
        return Scaffold(
          body: Stack(
            children: [
              ImageView(
                  url: AppAssets.topRound,
                  width: double.maxFinite,
                  height: 150.h,
                  fit: BoxFit.fill),
              ListView(children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  height: 150.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: colorSecendry, width: 3.w),
                      color: colorWhite,
                      shape: BoxShape.circle),
                  child: Center(
                    child: ImageView(
                      margin: EdgeInsets.all(20.w),
                      url: AppAssets.logo,
                      imageType: ImageType.asset,
                    ),
                  ),
                ),
                spaceVertical(space: 20.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextView(
                              text: "welcomeMessage",
                              color: colorWhite,
                              textSize: 15.sp,
                              textAlign: TextAlign.left,
                              style: AppTextStyleEnum.regular,
                              fontFamily: Family.regular,
                              lineHeight: 1.3,
                            ),
                            spaceHorizontal(space: 10.w),
                            Icon(
                              Icons.arrow_forward,
                              color: colorWhite,
                            )
                          ],
                        ),
                        spaceVertical(space: 10.h),
                        TextView(
                          text:
                              "welcomeDescription",
                          color: colorWhite,
                          textSize: 13.sp,
                          textAlign: TextAlign.left,
                          style: AppTextStyleEnum.small,
                          fontFamily: Family.regular,
                          lineHeight: 1.3,
                        ),
                      ]),
                ),
                spaceVertical(space: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [

                      BlocConsumer<GroupsBloc, GroupsState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is GroupsSuccess) {
                            printLog(
                                "builder >>>>>>>>>>>>>>>>>${state is GroupsSuccess}");
                            List<DropListModel> list = [];
                            state.responseModel.data.forEach((element) {
                              list.add(DropListModel(
                                  id: "${element["group_id"]}",
                                  name: "${element["group_name"]}"));
                            });
                            return CustomDropdown<DropListModel>.search(
                              hintText: tr("selectGroup"),
                              items: list,
                              excludeSelected: false,
                              onChanged: (item) {selectedGroup = item;},
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),

                      spaceVertical(space: 20.h),
                      CustomTextField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          paddingHorizontal: 20.0,
                          hasViewHight: false,
                          labelText: "classesName",
                          hintText: "classesNameHere",
                          numberOfLines: 1,
                          hintFontWeight: FontWeight.w400,
                          hintTextColor: colorGray.withOpacity(0.6)),
                      spaceVertical(space: 20.h),
                      spaceVertical(space: 30.h),
                      BlocConsumer<ClassesBloc, ClassesState>(
                        listener: (context, state) {
                          if (state is ClassesCreateLoading) {
                            printLog("listener>>>>>>>>>>>ClassesCreateLoading");
                            appLoader(context);
                          } else if (state is ClassesCreateLoadingDismiss) {
                            printLog(
                                "listener>>>>>>>>>>>ClassesCreateLoadingDismiss");
                            context.dissmissLoading();
                          } else if (state is ClassesCreateSuccess) {
                            printLog("listener>>>>>>>>>>>ClassesSuccess");

                            appDialog(
                                context: context,
                                child: SuccessDailog(
                                  title: "successfully",
                                  onTap: () {
                                    context.back();
                                    context.back();
                                  },
                                  message: "${state.responseModel.message}",
                                ));
                          } else if (state is ClassesCreateError) {
                            printLog("listener>>>>>>>>>>>ClassesError");

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
                                {
                                  context
                                      .read<ClassesBloc>()
                                      .add(CreateClassesEvent(map: {
                                        "school_code": "GSSS19543",
                                        "class_name": nameController.text,
                                        "class_id": getRandomId(
                                            text: nameController.text),
                                        "group_id": selectedGroup?.id ?? "",
                                      }));
                                }
                              },
                              buttonBackgroundColor: colorPrimary,
                              nameText: "create",
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 10.0),
                child: Row(
                  children: [
                    TapWidget(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back,
                        color: colorWhite,
                        size: 20.h,
                      ),
                    ),
                    spaceHorizontal(space: 10.w),
                    TextView(
                      text: "createClasses",
                      color: colorWhite,
                      textSize: 16.sp,
                      textAlign: TextAlign.center,
                      style: AppTextStyleEnum.medium,
                      fontFamily: Family.medium,
                      lineHeight: 1.3,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
