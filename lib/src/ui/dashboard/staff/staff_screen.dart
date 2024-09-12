import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_image_view.dart';
import 'package:school_club/src/core/app_input_field.dart';
import 'package:school_club/src/core/app_tap_widget.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/common_space.dart';
import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/data/blocs/teacher_bloc/teacher_bloc.dart';
import 'package:school_club/src/data/network/http_service.dart';
import 'package:school_club/src/extension/app_extension.dart';
import 'package:school_club/src/ui/register/staff_registration/staff_register_screen.dart';
import 'package:school_club/src/ui/register/staff_registration/staff_update_screen.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(GetTeacherEvent(map: {
          'college_id': '${AppData.userModel.data?.data.college.id ?? ""}',
          'session': DateTime.now().year,
          "page": page
        }));

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (AppData.loadMore) {
          print("addListener>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
          page = page + 1;
          context.read<TeacherBloc>().add(LoadMoreTeacherEvent(map: {
                'college_id':
                    '${AppData.userModel.data?.data.college.id ?? ""}',
                'session': DateTime.now().year,
                "page": page
              }));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        leading: TapWidget(
          onTap: () {
            context.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: colorWhite,
            size: 20.h,
          ),
        ),
        title: TextView(
          text: "staffList",
          color: colorWhite,
          textSize: 16.sp,
          textAlign: TextAlign.center,
          style: AppTextStyleEnum.medium,
          fontFamily: Family.medium,
          lineHeight: 1.3,
        ),
        actions: [],
      ),
      body: Column(children: [
        spaceVertical(space: 5.h),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                    controller: TextEditingController(),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    paddingHorizontal: 20.0,
                    hasViewHight: false,
                    labelText: "",
                    hintText: "searchHere",
                    numberOfLines: 1,
                    preffixicon: Icon(Icons.search),
                    hintFontWeight: FontWeight.w400,
                    hintTextColor: colorGray.withOpacity(0.6)),
              ),
            ],
          ),
        ),
        BlocConsumer<TeacherBloc, TeacherState>(
          listener: (context, state) {
            printLog("Create listener>>>>>>>>>>>${state.toString()}");
          },
          builder: (context, state) {
            if (state is TeacherGetSuccess) {
              return state.teachersModel.data.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: TextView(
                        text: "noRecordsFound",
                        color: colorBlack,
                        textSize: 12.sp,
                        textAlign: TextAlign.center,
                        style: AppTextStyleEnum.medium,
                        fontFamily: Family.medium,
                        lineHeight: 1.3,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: state.teachersModel.data.length,
                          itemBuilder: (c, i) {
                            return Card(
                              elevation: 10.h,
                              margin: EdgeInsets.all(10.r),
                              shadowColor: colorPrimary,
                              child: Stack(
                                children: [
                                  state.teachersModel.data[i].status == "active"
                                      ? Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Icon(
                                            Icons.verified,
                                            color: colorPrimary,
                                          ))
                                      : SizedBox.shrink(),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        state.teachersModel.data[i].image == ""
                                            ? CircleAvatar(
                                                radius: 45,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage:
                                                    AssetImage(AppAssets.logo))
                                            : CircleAvatar(
                                                radius: 45,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: ClipOval(
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        "${ApisEndpoints.imagesPathStaff}${state.teachersModel.data[i].image}"),
                                                    placeholder: AssetImage(
                                                        AppAssets.logo),
                                                    // Path to your placeholder image
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          AppAssets.logo,
                                                          fit: BoxFit.cover);
                                                    },
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                        spaceHorizontal(space: 10.w),
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  TextView(
                                                    text:
                                                        "${state.teachersModel.data[i].name.toUpperCase()}",
                                                    color: colorPrimary,
                                                    textSize: 15.sp,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        AppTextStyleEnum.bold,
                                                    fontFamily: Family.medium,
                                                    lineHeight: 1.3,
                                                  ),
                                                  spaceVertical(space: 2.h),
                                                  TextView(
                                                    text:
                                                        "${state.teachersModel.data[i].mobileNo}",
                                                    color: colorBlack
                                                        .withOpacity(0.6),
                                                    textSize: 13.sp,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        AppTextStyleEnum.medium,
                                                    fontFamily: Family.medium,
                                                    lineHeight: 1.3,
                                                  ),
                                                  spaceVertical(space: 2.h),
                                                  TextView(
                                                    text:
                                                        "${state.teachersModel.data[i].email}",
                                                    color: colorBlack
                                                        .withOpacity(0.6),
                                                    textSize: 13.sp,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        AppTextStyleEnum.medium,
                                                    fontFamily: Family.medium,
                                                    lineHeight: 1.3,
                                                  ),
                                                  TextView(
                                                    text:
                                                    "${state.teachersModel.data[i].user.uniqueId}",
                                                    color: colorBlack
                                                        .withOpacity(0.6),
                                                    textSize: 13.sp,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                    AppTextStyleEnum.medium,
                                                    fontFamily: Family.medium,
                                                    lineHeight: 1.3,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      right: 2,
                                      bottom: 0,
                                      child: TapWidget(
                                        onTap: () {
                                          //StaffUpdateScreen
                                          context.pushScreen(
                                              nextScreen: StaffUpdateScreen(
                                                  staff: state
                                                      .teachersModel.data[i]));
                                        },
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              AssetImage(AppAssets.editBg),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Icon(
                                              Icons.edit,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }),
                    );
            }
            return SizedBox.shrink();
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushScreen(nextScreen: StaffRegisterScreen());
          // context.pushScreen(nextScreen: RegisterScreen());
        },
        child: Icon(Icons.add, color: colorWhite),
        backgroundColor: colorPrimary,
      ),
    );

    return Scaffold(
      body: ListView(
        children: [
          Stack(
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
                    BlocConsumer<TeacherBloc, TeacherState>(
                      listener: (context, state) {
                        printLog(
                            "Create listener>>>>>>>>>>>${state.toString()}");
                      },
                      builder: (context, state) {
                        if (state is TeacherGetSuccess) {
                          return state.teachersModel.data.isEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: TextView(
                                    text: "noRecordsFound",
                                    color: colorBlack,
                                    textSize: 12.sp,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyleEnum.medium,
                                    fontFamily: Family.medium,
                                    lineHeight: 1.3,
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.teachersModel.data.length,
                                  itemBuilder: (c, i) {
                                    return Card(
                                      elevation: 10.h,
                                      margin: EdgeInsets.all(10.r),
                                      shadowColor: colorPrimary,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            state.teachersModel.data[i].image ==
                                                    ""
                                                ? CircleAvatar(
                                                    radius: 45,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: AssetImage(
                                                        AppAssets.logo))
                                                : CircleAvatar(
                                                    radius: 45,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: NetworkImage(
                                                        "${state.teachersModel.data[i].image}"),
                                                  ),
                                            spaceHorizontal(space: 10.w),
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  i % 2 == 0
                                                      ? SizedBox.shrink()
                                                      : Positioned(
                                                          right: 0,
                                                          child: Icon(
                                                            Icons.verified,
                                                            color: colorPrimary,
                                                          )),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      TextView(
                                                        text:
                                                            "${state.teachersModel.data[i].name.toUpperCase()} (${getDesignationsList().firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      state
                                                                          .teachersModel
                                                                          .data[
                                                                              i]
                                                                          .designation,
                                                                ).name})",
                                                        color: colorPrimary,
                                                        textSize: 15.sp,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyleEnum
                                                            .bold,
                                                        fontFamily:
                                                            Family.medium,
                                                        lineHeight: 1.3,
                                                      ),
                                                      spaceVertical(space: 2.h),
                                                      TextView(
                                                        text:
                                                            "${state.teachersModel.data[i].mobileNo}",
                                                        color: colorBlack
                                                            .withOpacity(0.6),
                                                        textSize: 13.sp,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyleEnum
                                                            .medium,
                                                        fontFamily:
                                                            Family.medium,
                                                        lineHeight: 1.3,
                                                      ),
                                                      spaceVertical(space: 2.h),
                                                      TextView(
                                                        text:
                                                            "${state.teachersModel.data[i].email}",
                                                        color: colorBlack
                                                            .withOpacity(0.6),
                                                        textSize: 13.sp,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyleEnum
                                                            .medium,
                                                        fontFamily:
                                                            Family.medium,
                                                        lineHeight: 1.3,
                                                      ),
                                                      TextView(
                                                        text:
                                                            "${state.teachersModel.data[i].villageMohalla}",
                                                        color: colorBlack
                                                            .withOpacity(0.4),
                                                        textSize: 10.sp,
                                                        maxlines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyleEnum
                                                            .medium,
                                                        fontFamily:
                                                            Family.medium,
                                                        lineHeight: 1.3,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: [
                    TapWidget(
                      onTap: () {
                        context.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: colorWhite,
                        size: 20.h,
                      ),
                    ),
                    spaceHorizontal(space: 10.w),
                    TextView(
                      text: "staff",
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushScreen(nextScreen: StaffRegisterScreen());
        },
        child: Icon(Icons.add, color: colorWhite),
        backgroundColor: colorPrimary,
      ),
    );
  }
}
