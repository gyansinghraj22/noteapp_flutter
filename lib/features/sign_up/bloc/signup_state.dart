part of 'signup_bloc.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupWithGoogleSuccessState extends SignupState {
  final dynamic response;

  SignupWithGoogleSuccessState({required this.response});
}

class SignupWithGoogleErrorState extends SignupState {
  final dynamic errorModel;

  SignupWithGoogleErrorState({required this.errorModel});
}

class SignupWithFacebookSuccessState extends SignupState {
  final dynamic response;

  SignupWithFacebookSuccessState({required this.response});
}

class SignupWithFacebookErrorState extends SignupState {
  final dynamic errorModel;

  SignupWithFacebookErrorState({required this.errorModel});
}

class SignupWithPasswordSuccessState extends SignupState {
  final dynamic response;

  SignupWithPasswordSuccessState({required this.response});
}

class SignupWithPasswordErrorState extends SignupState {
  final dynamic errorModel;

  SignupWithPasswordErrorState({required this.errorModel});
}

class SavedUserInfoDataSuccessState extends SignupState {
  final dynamic response;

  SavedUserInfoDataSuccessState({required this.response});
}

class SavedUserInfoDataErrorState extends SignupState {
  final dynamic errorModel;

  SavedUserInfoDataErrorState({required this.errorModel});
}
