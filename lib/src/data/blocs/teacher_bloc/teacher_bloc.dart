import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/models/teachers_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/repository/teacher_repo.dart';

import 'package:get_it/get_it.dart';

part 'teacher_event.dart';

part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  var teacherRepository = GetIt.I<TeacherRepository>();

  TeacherBloc() : super(TeacherInitial()) {
    on<GetTeacherEvent>(_getTeacherApi);
    on<LoadMoreTeacherEvent>(_loadMoreTeacherApi);
    on<CreateTeacherEvent>(_createTeacherApi);
  }

  Future<FutureOr<void>> _getTeacherApi(
      GetTeacherEvent event, Emitter<TeacherState> emit) async {
    try {
      emit(TeacherGetLoading());
      var responseModel = await teacherRepository.getTeacherApi(event.map);
      emit(TeacherGetLoadingDismiss());
      TeachersModel teachersModel = TeachersModel.fromJson(responseModel.data["staffs"]) ;
      emit(TeacherGetSuccess(teachersModel: teachersModel,loadMore: teachersModel.data.length > 19));
    } catch (e ,t) {
      print("ssssssssssss$t") ;
      emit(TeacherGetError(error: e.toString()));
    }
  }



  Future<FutureOr<void>> _createTeacherApi(
      CreateTeacherEvent event, Emitter<TeacherState> emit) async {
    try {
      emit(TeacherCreateLoading());
      var responseModel = await teacherRepository.createClassApi(event.map);
      emit(TeacherCreateLoadingDismiss());
      if (responseModel.status == "${RepoResponseStatus.success}") {
        emit(TeacherCreateSuccess(responseModel: responseModel));
      } else {
        emit(TeacherCreateError(error: responseModel.message));
      }
    } catch (e) {
      emit(TeacherCreateError(error: e.toString()));
    }
  }
  FutureOr<void> _loadMoreTeacherApi(LoadMoreTeacherEvent event, Emitter<TeacherState> emit) async {

    try {
      if (state is! TeacherGetSuccess) return;
      final cast = state as TeacherGetSuccess;
      List<Datum> list = cast.teachersModel.data ?? <Datum>[];
      var responseModel = await teacherRepository.getTeacherApi(event.map);
      TeachersModel studentsModel =
      TeachersModel.fromJson(responseModel.data["staffs"]);
      list.addAll(studentsModel.data);
      emit(TeacherGetSuccess(
          teachersModel: studentsModel.copyWith(data: list),
          loadMore: studentsModel.data.length == 20));
    } catch (e, t) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>$t");
      emit(TeacherGetError(error: e.toString()));
    }


  }
}
