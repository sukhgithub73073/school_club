import 'package:dropdown_search/dropdown_search.dart';
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
import 'package:school_club/src/extension/app_extension.dart';
import 'package:school_club/src/ui/dashboard/drawer/drawer_screen.dart';
import 'package:school_club/src/ui/dashboard/drawer/student_filter_drawer.dart';
import 'package:school_club/src/ui/dashboard/students/student_detail_screen.dart';
import 'package:school_club/src/ui/register/register_screen.dart';
import 'package:school_club/src/ui/register/student_registration/register_one.dart';
import 'package:school_club/src/ui/register/student_registration/student_register_screen.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  void initState() {

    AppData.studentMap["college_id"] = AppData.userModel.data?.data.college.id??"" ;
    AppData.studentMap["session"] = "2024" ;

    // context.read<StudentBloc>().add(GetStudentEvent(map: {
    //   'class_group_id': '135',
    //   'class_id': '405',
    //   'session': '2023',
    //   'college_id': '${AppData.userModel.data?.data.college.id??""}'
    //     }));

    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: Container(width: 250.w, child: StudentFilterDrawer()),
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        leading: TapWidget(
          onTap: () {},
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
                    suffixicon: TapWidget(
                        onTap: () {
                          _key.currentState!.openEndDrawer();
                        },
                        child: Icon(Icons.filter_list)),
                    hintFontWeight: FontWeight.w400,
                    hintTextColor: colorGray.withOpacity(0.6)),
              ),
            ],
          ),
        ),


        BlocConsumer<StudentBloc, StudentState>(
          listener: (context, state) {
            printLog("Create listener>>>>>>>>>>>${state.toString()}");

            if (state is StudentGetLoading) {
              // appLoader(context);
            } else if (state is StudentGetLoadingDismiss) {
              // context.dissmissLoading();
            }
          },
          builder: (context, state) {
            if (state is StudentGetSuccess) {
              return state.studentsList.isEmpty
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
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: state.studentsList.length,
                          itemBuilder: (c, i) {
                            return TapWidget(
                              onTap: (){
                                context.pushScreen(nextScreen: StudentDetailScreen(student: state.studentsList[i],));

                              },
                              child: Card(
                                elevation: 10.h,
                                margin: EdgeInsets.all(10.r),
                                shadowColor: colorPrimary,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            style: BorderStyle.solid,
                                            color: colorPrimary,
                                            // Specify the border color
                                            width: 2, // Specify the border width
                                          ),
                                        ),
                                        child: Center(
                                          child: ImageView(
                                            size: 70,
                                            url: AppAssets.logo,
                                            imageType: ImageType.asset,
                                          ),
                                        ),
                                      ),
                                      spaceHorizontal(space: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextView(
                                              text:
                                                  "${state.studentsList[i].name} (${state.studentsList[i].mobileNo})",
                                              color: colorPrimary,
                                              textSize: 15.sp,
                                              textAlign: TextAlign.start,
                                              style: AppTextStyleEnum.bold,
                                              fontFamily: Family.medium,
                                              lineHeight: 1.3,
                                            ),
                                            spaceVertical(space: 5.h),
                                            TextView(
                                              text:
                                                  "${state.studentsList[i].father}",
                                              color: colorBlack.withOpacity(0.6),
                                              textSize: 13.sp,
                                              textAlign: TextAlign.start,
                                              style: AppTextStyleEnum.medium,
                                              fontFamily: Family.medium,
                                              lineHeight: 1.3,
                                            ),


                                            TextView(
                                              text:
                                                  "${state.studentsList[i].finalClassGroupName} ( ${state.studentsList[i].finalClassName} )",
                                              color: colorBlack.withOpacity(0.4),
                                              textSize: 10.sp,
                                              maxlines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: AppTextStyleEnum.medium,
                                              fontFamily: Family.medium,
                                              lineHeight: 1.3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
          context.pushScreen(nextScreen: StudentRegisterScreen());
          // context.pushScreen(nextScreen: RegisterScreen());
        },
        child: Icon(Icons.add, color: colorWhite),
        backgroundColor: colorPrimary,
      ),
    );
  }
}
