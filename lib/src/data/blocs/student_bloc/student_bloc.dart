import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/models/students_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/repository/student_repo.dart';
import 'package:get_it/get_it.dart';

part 'student_event.dart';

part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  var studentRepository = GetIt.I<StudentRepository>();

  StudentBloc() : super(StudentInitial()) {
    on<GetStudentEvent>(_getStudentApi);
    on<CreateStudentEvent>(_createStudentApi);
  }

  Future<FutureOr<void>> _getStudentApi(
      GetStudentEvent event, Emitter<StudentState> emit) async {
    try {
      emit(StudentGetLoading());
      var responseModel = await studentRepository.getStudentApi(event.map);
      emit(StudentGetLoadingDismiss());
      StudentsModel studentsModel = StudentsModel.fromJson(responseModel.data) ;

      emit(StudentGetSuccess(studentsList: studentsModel.data));
    } catch (e,t) {
      print("sdsdfsdfsds $t");
      emit(StudentGetError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _createStudentApi(
      CreateStudentEvent event, Emitter<StudentState> emit) async {
    try {
      emit(StudentCreateLoading());
      var responseModel = await studentRepository.createClassApi(event.map);
      emit(StudentCreateLoadingDismiss());
      if (responseModel.status == "${RepoResponseStatus.success}") {
        emit(StudentCreateSuccess(responseModel: responseModel));
      } else {
        emit(StudentCreateError(error: responseModel.message));
      }
    } catch (e) {
      emit(StudentCreateError(error: e.toString()));
    }
  }
}
