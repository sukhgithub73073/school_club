import 'package:flutter/foundation.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:school_club/src/core/app_assets.dart';
import 'package:school_club/src/core/app_dialog.dart';
import 'package:school_club/src/core/app_image_view.dart';
import 'package:school_club/src/core/app_loader.dart';
import 'package:school_club/src/core/app_strings.dart';
import 'package:school_club/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:school_club/src/data/blocs/cast_bloc/cast_bloc.dart';
import 'package:school_club/src/data/blocs/groups_bloc/groups_bloc.dart';
import 'package:school_club/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:school_club/src/enums/role_enum.dart';
import 'package:school_club/src/ui/choose_language_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_club/src/core/app_button.dart';
import 'package:school_club/src/core/app_colors.dart';
import 'package:school_club/src/core/app_input_field.dart';
import 'package:school_club/src/core/app_text_style.dart';
import 'package:school_club/src/core/common_space.dart';
import 'package:school_club/src/core/text_view.dart';
import 'package:school_club/src/data/blocs/login_bloc/login_bloc.dart';
import 'package:school_club/src/extension/app_extension.dart';
import 'package:school_club/src/ui/dashboard/main_screen.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:school_club/src/utility/validation_util.dart';
import 'package:upgrader/upgrader.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //var emailController = TextEditingController(text: "C0e3c2eb");
  //var emailController = TextEditingController(text: "COL62A8");
  //var passwordController = TextEditingController(text: "12345678");

  //var emailController = TextEditingController(text: "COL62A8");
  var emailController = TextEditingController(text: "");
  var passwordController = TextEditingController(text: "");
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    getHiveStorage.write(key: "LOGIN_RESPONSE", value: "");
    if (kDebugMode) {
      emailController.text = "C0e3c2eb";
      passwordController.text = "12345678";
    }
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      showReleaseNotes: false,
      cupertinoButtonTextStyle: TextStyle(color: colorPrimary),
      showLater: false,
      showIgnore: false,
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: BlocConsumer<RoleBloc, RoleState>(
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
                  spaceVertical(space: 10.h),
                  TextView(
                    text: "secureLogin",
                    color: colorPrimary,
                    textSize: 20.sp,
                    textAlign: TextAlign.center,
                    style: AppTextStyleEnum.bold,
                    fontFamily: Family.bold,
                    lineHeight: 1.3,
                  ),
                  spaceVertical(space: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            paddingHorizontal: 20.0,
                            hasViewHight: false,
                            labelText: "loginId",
                            hintText: "",
                            numberOfLines: 1,
                            hintFontWeight: FontWeight.w400,
                            hintTextColor: colorGray.withOpacity(0.6)),
                        spaceVertical(space: 20.h),
                        CustomTextField(
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            paddingHorizontal: 20.0,
                            hasViewHight: false,
                            labelText: "password",
                            hintText: "***********",
                            obsecureText: _isObscured,
                            numberOfLines: 1,
                            suffixicon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                            borderColor: colorInputBorder,
                            hintFontWeight: FontWeight.w400,
                            hintTextColor: colorInputBorder.withOpacity(0.6)),
                        spaceVertical(space: 10.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextView(
                            text: "forgotPassword",
                            color: colorGray,
                            textSize: 13.sp,
                            textAlign: TextAlign.end,
                            style: AppTextStyleEnum.medium,
                            fontFamily: Family.medium,
                            lineHeight: 1.3,
                          ),
                        ),
                        spaceVertical(space: 30.h),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) async {
                            if (state is LoginLoading) {
                              appLoader(context);
                            } else if (state is LoginSuccess) {
                              context.dissmissLoading();
                              context.read<RoleBloc>().add(ChangeRoleEvent(
                                  roleEnum: state.userModel.data!.data.college
                                              .id !=
                                          0
                                      ? RoleEnum.principle
                                      : state.userModel.data!.data.staff.id != 0
                                          ? RoleEnum.staff
                                          : RoleEnum.student));

                              context.pushReplacementScreen(
                                  nextScreen: MainScreen());
                            } else if (state is LoginError) {
                              context.dissmissLoading();
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
                              decoration: BoxDecoration(
                                  color: colorPrimary,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: AppSimpleButton(
                                onDoneFuction: () async {
                                  if (!ValidationUtil.emailValidation(
                                      email: emailController.text)) {
                                  } else if (!ValidationUtil.passwordValidation(
                                      password: passwordController.text)) {
                                  } else {
                                    var map = {
                                      "role_type": roleState is RolePrincipal
                                          ? "School"
                                          : roleState is RoleStaff
                                              ? "Teacher"
                                              : "Student",
                                      "email": emailController.text,
                                      "unique_id": emailController.text,
                                      "password": passwordController.text,
                                    };
                                    context
                                        .read<LoginBloc>()
                                        .add(DoLoginEvent(map: map));
                                  }
                                },
                                buttonBackgroundColor: colorPrimary,
                                nameText: "login",
                                textSize: 18.sp,
                              ),
                            );
                          },
                        ),
                        spaceVertical(space: 30.h),
                        // TapWidget(
                        //   onTap: () {
                        //     context.pushScreen(nextScreen: SchoolCodeScreen());
                        //   },
                        //   child: TextView(
                        //     text: "dontHaveAnAccountRegister",
                        //     color: colorGray,
                        //     textSize: 12.sp,
                        //     textAlign: TextAlign.center,
                        //     style: AppTextStyleEnum.medium,
                        //     fontFamily: Family.medium,
                        //     lineHeight: 1.3,
                        //   ),
                        // ),
                        // spaceVertical(space: 10.h),
                        // TapWidget(
                        //   onTap: () {
                        //     context.pushScreen(
                        //         nextScreen: SchoolRegisterScreen());
                        //   },
                        //   child: Container(
                        //     height: 50,
                        //     margin: EdgeInsets.symmetric(vertical: 20),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.all(Radius.circular(10)),
                        //     ),
                        //     child: Row(
                        //       children: <Widget>[
                        //         Expanded(
                        //           flex: 5,
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //               color: Color(0xff2872ba),
                        //               borderRadius: BorderRadius.only(
                        //                   bottomRight: Radius.circular(5.r),
                        //                   topRight: Radius.circular(5.r)),
                        //             ),
                        //             alignment: Alignment.center,
                        //             child: Text('registerNewSchool',
                        //                 style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontSize: 16.sp,
                        //                     fontWeight: FontWeight.w400)),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ]),
                Positioned(
                    right: 20.w,
                    top: 35.h,
                    child: IconButton(
                      icon: Icon(
                        Icons.g_translate,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        context.pushScreen(
                            nextScreen:
                                ChooseLanguageScreen(fromWhere: "LoginScreen"));
                      },
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
