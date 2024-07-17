import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/repository/subject_repo.dart';
import 'package:get_it/get_it.dart';

part 'subject_event.dart';
part 'subject_state.dart';


class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  var subjectRepository = GetIt.I<SubjectRepository>();

  SubjectBloc() : super(SubjectInitial()) {
    on<GetSubjectEvent>(_getSubjectApi);
    on<CreateSubjectEvent>(_createSubjectApi);
  }

  Future<FutureOr<void>> _getSubjectApi(
      GetSubjectEvent event, Emitter<SubjectState> emit) async {
    try {
      emit(SubjectGetLoading());
      var responseModel = await subjectRepository.getSubjectApi(event.map);
      emit(SubjectGetLoadingDismiss());
      emit(SubjectGetSuccess(responseModel: responseModel));
    } catch (e) {
      emit(SubjectGetError(error: e.toString()));
    }
  }



  Future<FutureOr<void>> _createSubjectApi(
      CreateSubjectEvent event, Emitter<SubjectState> emit) async {
    try {
      emit(SubjectCreateLoading());
      var responseModel = await subjectRepository.createSubjectApi(event.map);
      emit(SubjectCreateLoadingDismiss());
      if (responseModel.status == "${RepoResponseStatus.success}") {
        emit(SubjectCreateSuccess(responseModel: responseModel));
        emit(SubjectGetSuccess(responseModel: responseModel));
      } else {
        emit(SubjectCreateError(error: responseModel.message));
      }
    } catch (e) {
      emit(SubjectCreateError(error: e.toString()));
    }
  }
}