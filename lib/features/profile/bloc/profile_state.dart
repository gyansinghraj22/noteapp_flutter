part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileInfoSuccessState extends ProfileState {
  final dynamic reposnse;

  GetProfileInfoSuccessState({required this.reposnse});
}

class GetProfileInfoErrorState extends ProfileState {
  final ErrorModel errorModel;

  GetProfileInfoErrorState({required this.errorModel});
}

class UpdateProfileSuccessState extends ProfileState {
  final dynamic reposnse;

  UpdateProfileSuccessState({required this.reposnse});
}

class UpdateProfileErrorState extends ProfileState {
  final ErrorModel errorModel;

  UpdateProfileErrorState({required this.errorModel});
}
