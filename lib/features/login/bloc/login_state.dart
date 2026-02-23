part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UserLoginSuccessState extends LoginState {
  final dynamic response;

  UserLoginSuccessState({required this.response});
}

class UserLoginErrorState extends LoginState {
  final ErrorModel errorModel;

  UserLoginErrorState({required this.errorModel});
}
