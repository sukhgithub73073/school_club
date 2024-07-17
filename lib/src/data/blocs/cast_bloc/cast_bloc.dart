import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_club/src/data/models/cast_model.dart';
import 'package:school_club/src/data/repository/register_repo.dart';
import 'package:get_it/get_it.dart';

part 'cast_event.dart';

part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  var registerRepository = GetIt.I<RegisterRepository>();

  CastBloc() : super(CastInitial()) {
    on<GetCastEvent>(_getCastApi);
  }

  FutureOr<void> _getCastApi(GetCastEvent event, Emitter<CastState> emit) {
    try {
      emit(CastLoading());

    } catch (e) {
      emit(CastError(error: e.toString()));
    }
  }
}
