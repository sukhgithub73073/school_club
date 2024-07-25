import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/models/user_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/repository/login%20_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:school_club/src/utility/app_data.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  var loginRepository = GetIt.I<LoginRepository>();

  LoginBloc() : super(LoginInitial()) {
    on<DoLoginEvent>(_login);
  }

  Future<FutureOr<void>> _login(
      DoLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      ResponseModel responseModel = await loginRepository.loginApi(event.map);

      var userModel = userModelFromJson(jsonEncode(responseModel.data));

      if (userModel.status == "${RepoResponseStatus.success}") {
        AppData.userModel = userModel;
        AppData.authToken = userModel.data?.token ?? "";
        emit(LoginSuccess(responseModel: responseModel));
      } else {
        emit(LoginError(error: responseModel.message));
      }
    } catch (e, t) {
      print("$e>>>$t");
      emit(LoginError(error: e.toString()));
    }
  }
}
