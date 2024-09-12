import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_dialog.dart';
import 'package:school_club/src/core/app_image_view.dart';
import 'package:school_club/src/core/app_input_field.dart';
import 'package:school_club/src/core/app_loader.dart';
import 'package:school_club/src/core/app_tap_widget.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/common_space.dart';
import 'package:school_club/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:school_club/src/core/drop_down/drop_list_model.dart';
import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/data/blocs/classes_bloc/classes_bloc.dart';
import 'package:school_club/src/data/blocs/groups_bloc/groups_bloc.dart';
import 'package:school_club/src/data/blocs/student_bloc/student_bloc.dart';
import 'package:school_club/src/data/models/students_model.dart';
import 'package:school_club/src/data/network/http_service.dart';
import 'package:school_club/src/extension/app_extension.dart';
import 'package:school_club/src/ui/dashboard/drawer/drawer_screen.dart';
import 'package:school_club/src/ui/dashboard/drawer/student_filter_drawer.dart';
import 'package:school_club/src/ui/dashboard/students/student_detail_screen.dart';
import 'package:school_club/src/ui/register/register_screen.dart';
import 'package:school_club/src/ui/register/student_registration/register_one.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';
import 'package:school_club/src/ui/register/student_registration/student_register_screen.dart';
import 'package:school_club/src/ui/register/student_registration/student_update_screen.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_club/src/utility/decoration_util.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  ScrollController scrollController = ScrollController();
  List<Datum> studentsList = [];

  @override
  void initState() {
    AppData.studentMap["college_id"] =
        AppData.userModel.data?.data.college.id ?? "";
    AppData.studentMap["session"] = DateTime.now().year;
    AppData.studentMap["page"] = 1;
    context.read<StudentBloc>().add(ClearStudentEvent(map: AppData.studentMap));

    context.read<ClassesBloc>().add(EmptyClassEvent()) ;

    // AppData.studentMap["class_group_id"] = "42";
    // AppData.studentMap["class_id"] = "131";
    // context.read<StudentBloc>().add(GetStudentEvent(map: AppData.studentMap));

    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (AppData.loadMore) {
          print("addListener>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
          AppData.studentMap["page"] = AppData.studentMap["page"] + 1;
          context
              .read<StudentBloc>()
              .add(LoadMoreStudentEvent(map: AppData.studentMap));
        }
      }
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    return Scaffold(
      key: _key,
      // endDrawer: Container(width: 250.w, child: StudentFilterDrawer()),
      // endDrawerEnableOpenDragGesture: false,
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
          text: "studentsList",
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: (size.width / 2)-20.w ,

                child: BlocConsumer<GroupsBloc, GroupsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GroupsSuccess) {
                      printLog(
                          "builder >>>>>>>>>>>>>>>>>${state is GroupsSuccess}");
                      List<DropListModel> list = [];
                      state.data.forEach((element) {
                        list.add(DropListModel(
                            id: "${element.id}", name: "${element.groupName}"));
                      });
                      return CustomDropdown<DropListModel>(
                        hintText: tr("selectGroup"),
                        items: list,
                        excludeSelected: false,

                        decoration: customDropdownDecoration,
                        onChanged: (item) {
                          AppData.studentMap["class_group_id"] = item!.id;

                          var data = state.data.firstWhere(
                                (element) => element.id.toString() == item!.id,
                          );
                          context
                              .read<ClassesBloc>()
                              .add(GetClassEvent(groupItem: data));
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),

              Container(
                width: (size.width / 2)-20.w,
                child: BlocConsumer<ClassesBloc, ClassesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ClassesGetSuccess) {
                      printLog(
                          "builder >>>>>>>>>>>>>>>>>${state is GroupsSuccess}");
                      List<DropListModel> list = [];
                      state.data.forEach((element) {
                        list.add(DropListModel(
                            id: "${element.id}", name: "${element.className}"));
                      });
                      return CustomDropdown<DropListModel>(
                        hintText: tr("selectClass"),
                        items: list,

                        decoration: customDropdownDecoration,
                        excludeSelected: false,
                        onChanged: (item) {
                          AppData.studentMap["class_id"] = item!.id;
                          AppData.studentMap["page"] = 1 ;
                          context
                              .read<StudentBloc>()
                              .add(GetStudentEvent(map: AppData.studentMap));
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),

            ],),
        ),
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
                    onChanged: (e) {
                      if(AppData.studentMap.containsKey("class_id")){
                        AppData.studentMap["page"] = 1;
                        AppData.studentMap["search"] = e;
                        context
                            .read<StudentBloc>()
                            .add(SearchStudentEvent(map: AppData.studentMap));
                      }


                    },
                    preffixicon: Icon(Icons.search),
                    // suffixicon: TapWidget(
                    //     onTap: () {
                    //       _key.currentState!.openEndDrawer();
                    //     },
                    //     child: Icon(Icons.filter_list)),
                    hintFontWeight: FontWeight.w400,
                    hintTextColor: colorGray.withOpacity(0.6)),
              ),
            ],
          ),
        ),



        BlocConsumer<StudentBloc, StudentState>(
          listener: (context, state) {},
          builder: (context, state) {
            final List<Datum> list;

            if (state is StudentGetSuccess) {
              list = state.studentsModel.data;
              AppData.loadMore = state.loadMore;
              return list.isEmpty
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
                          padding: EdgeInsets.only(bottom: 50),
                          physics: BouncingScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (c, i) {
                            return TapWidget(
                              onTap: () {
                                // context.pushScreen(
                                //     nextScreen: StudentDetailScreen(
                                //   student: list[i],
                                // ));
                              },
                              child: Card(
                                elevation: 10.h,
                                margin: EdgeInsets.all(10.r),
                                shadowColor: colorPrimary,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          list[i].image == ""
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
                                                      "${ApisEndpoints.imagesPathStudent}${list[i].image}")),
                                          spaceHorizontal(space: 10.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextView(
                                                  text: "${list[i].name}",
                                                  color: colorPrimary,
                                                  textSize: 15.sp,
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyleEnum.bold,
                                                  fontFamily: Family.medium,
                                                  lineHeight: 1.3,
                                                ),
                                                spaceVertical(space: 1.h),
                                                TextView(
                                                  text: "${list[i].mobileNo}",
                                                  color: colorBlack
                                                      .withOpacity(0.6),
                                                  textSize: 13.sp,
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      AppTextStyleEnum.medium,
                                                  fontFamily: Family.medium,
                                                  lineHeight: 1.3,
                                                ),
                                                spaceVertical(space: 1.h),
                                                TextView(
                                                  text: "${list[i].father}",
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
                                                      "${list[i].finalClassGroupName} ( ${list[i].finalClassName} )",
                                                  color: colorBlack
                                                      .withOpacity(0.4),
                                                  textSize: 10.sp,
                                                  maxlines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      AppTextStyleEnum.medium,
                                                  fontFamily: Family.medium,
                                                  lineHeight: 1.3,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: TextView(
                                          text: "Roll No : ${list[i].rollNo}",
                                          color: colorBlack.withOpacity(0.6),
                                          textSize: 13.sp,
                                          textAlign: TextAlign.start,
                                          style: AppTextStyleEnum.medium,
                                          fontFamily: Family.medium,
                                          lineHeight: 1.3,
                                        ),
                                      ),
                                      Positioned(
                                          right: 5,
                                          bottom: 0,
                                          child: Row(
                                            children: [
                                              TapWidget(
                                                onTap: () {
                                                  StudentData.editStudent(
                                                      student: state
                                                          .studentsModel
                                                          .data[i]);
                                                  context.pushScreen(
                                                      nextScreen:
                                                          StudentUpdateScreen());
                                                },
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: AssetImage(
                                                      AppAssets.editBg),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // TapWidget(
                                              //   onTap: () {
                                              //     StudentData.editStudent(
                                              //         student: state
                                              //             .studentsModel
                                              //             .data[i]);
                                              //     context.pushScreen(
                                              //         nextScreen:
                                              //             StudentUpdateScreen());
                                              //   },
                                              //   child: CircleAvatar(
                                              //     radius: 20,
                                              //     backgroundColor:
                                              //         Colors.transparent,
                                              //     backgroundImage: AssetImage(
                                              //         AppAssets.deleteBg),
                                              //     child: Padding(
                                              //       padding:
                                              //           const EdgeInsets.only(
                                              //               bottom: 10),
                                              //       child: Icon(
                                              //         Icons.delete,
                                              //         size: 15,
                                              //         color: Colors.white,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
            } else if (state is StudentGetLoading) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: CircularProgressIndicator(strokeWidth: 1),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushScreen(nextScreen: StudentRegisterScreen());
          // context.pushScreen(nextScreen: RegisterScreen());
        },
        child: Icon(Icons.add, color: colorWhite),
        backgroundColor: colorPrimary,
      ),
    );
  }
}
