part of 'role_bloc.dart';

abstract class RoleState extends Equatable {
  const RoleState();
}

class RoleInitial extends RoleState {
  @override
  List<Object> get props => [];
}

class RoleLoading extends RoleState {
  @override
  List<Object> get props => [];
}

class RolePrincipal extends RoleState {
  

  RolePrincipal();

  @override
  List<Object> get props => [];
}

class RoleStaff extends RoleState {


  RoleStaff();

  @override
  List<Object> get props => [];
}

class RoleStudent extends RoleState {
  

  RoleStudent();

  @override
  List<Object> get props => [];
}
