part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();
}

class GroupsInitial extends GroupsState {
  @override
  List<Object> get props => [];
}



class GroupsLoaderShow extends GroupsState {
  @override
  List<Object> get props => [];
}

class GroupsLoaderDismiss extends GroupsState {
  @override
  List<Object> get props => [];
}


class GroupsCreateLoaderShow extends GroupsState {
  @override
  List<Object> get props => [];
}

class GroupsCreateLoaderDissmiss extends GroupsState {
  @override
  List<Object> get props => [];
}


class GroupsSuccess extends GroupsState {
  final ResponseModel responseModel;

  GroupsSuccess({required this.responseModel});

  @override
  List<Object> get props => [responseModel];
}

class GroupsError extends GroupsState {
  final String error;

  GroupsError({required this.error});

  @override
  List<Object> get props => [error];
}
