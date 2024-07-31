import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/models/students_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/repository/student_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:school_club/src/utility/app_data.dart';

part 'student_event.dart';

part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  var studentRepository = GetIt.I<StudentRepository>();

  StudentBloc() : super(StudentInitial()) {
    on<GetStudentEvent>(_getStudentApi);
    on<ClearStudentEvent>(_clearStudentApi);
    on<SearchStudentEvent>(_searchStudentApi);
    on<CreateStudentEvent>(_createStudentApi);
  }

  Future<FutureOr<void>> _getStudentApi(
      GetStudentEvent event, Emitter<StudentState> emit) async {
    try {
      emit(StudentGetLoading());
      var responseModel = await studentRepository.getStudentApi(event.map);
      emit(StudentGetLoadingDismiss());
      StudentsModel studentsModel =
          StudentsModel.fromJson(responseModel.data["students"]);
      if (event.map["page"] == 1) {
        AppData.studentList.clear();
      }

      AppData.studentList.addAll(studentsModel.data);
      emit(StudentGetSuccess(studentsList: AppData.studentList));
    } catch (e, t) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>$t");
      emit(StudentGetError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _searchStudentApi(
      SearchStudentEvent event, Emitter<StudentState> emit) async {
    try {
      emit(StudentGetLoading());
      var filterList = AppData.studentList
          .where(
            (element) => element.name.contains(event.map["query"]),
          )
          .toList();
      emit(StudentGetLoadingDismiss());
      emit(StudentGetSuccess(studentsList: filterList));
    } catch (e, t) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>$t");
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

  FutureOr<void> _clearStudentApi(
      ClearStudentEvent event, Emitter<StudentState> emit) {
    emit(StudentCreateLoading());
    emit(StudentGetSuccess(studentsList: []));
  }
}
