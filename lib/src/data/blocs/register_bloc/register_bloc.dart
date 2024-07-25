import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/repository/register_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  var registerRepository = GetIt.I<RegisterRepository>();

  RegisterBloc() : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
    on<GetSerialNoEvent>(_getSerialNoApi);
  }

  Future<FutureOr<void>> _doRegister(
      DoRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      var responseModel = await registerRepository.registerApi(event.map);
      if (responseModel.status == "${RepoResponseStatus.success}") {
        emit(RegisterSuccess(userModel: responseModel));
      } else {
        emit(RegisterError(error: responseModel.message));
      }
    } catch (e) {
      emit(RegisterError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _getSerialNoApi(
      GetSerialNoEvent event, Emitter<RegisterState> emit) async {
    var responseModel = await registerRepository.getSerialNoApi();
    StudentData.srnoController.text = "${responseModel.data["data"]}" ;


  }
}
