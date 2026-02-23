part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {
  final dynamic response;

  ResetPasswordSuccessState({required this.response});
}

class ResetPasswordErrorState extends ResetPasswordState {
  final ErrorModel errorModel;

  ResetPasswordErrorState({required this.errorModel});
}
