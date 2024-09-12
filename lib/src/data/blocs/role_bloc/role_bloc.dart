import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/enums/role_enum.dart';
import 'package:school_club/src/utility/app_util.dart';

part 'role_event.dart';

part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<ChangeRoleEvent>(_doChangeRole);
    on<UpdateRoleEventData>(_updateRoleData);
  }

  FutureOr<void> _doChangeRole(ChangeRoleEvent event, Emitter<RoleState> emit) {
    getHiveStorage.write(key: "CURRENT_ROLE", value: event.roleEnum.name);
    emit(RoleLoading());
    if (event.roleEnum == RoleEnum.principle) {
      emit(RolePrincipal());
    } else if (event.roleEnum == RoleEnum.staff) {
      emit(RoleStaff());
    } else {
      emit(RoleStudent());
    }
  }

  FutureOr<void> _updateRoleData(
      UpdateRoleEventData event, Emitter<RoleState> emit) {
    printLog(">>>>>>>>>>>>>>>>>>>");
    try {
      emit(RoleLoading());
      if (event.roleEnum == RoleEnum.principle) {
        emit(RolePrincipal());
      } else if (event.roleEnum == RoleEnum.staff) {
        emit(RoleStaff());
      } else {
        emit(RoleStudent());
      }
    } catch (e) {
      printLog(">>>>>>>>>>>>>>>Exception>$e");
    }
  }
}
