part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupInitialEvent extends SignupEvent {}

class SignupWithGoogleEvent extends SignupEvent {}

class SignupWithFacebookEvent extends SignupEvent {}

class SignupWithAppleEvent extends SignupEvent {}

class SignupWithPassword extends SignupEvent {
  final Map<String, dynamic> formData;

  SignupWithPassword({required this.formData});
}

class SavedUserInfoData extends SignupEvent {
  final Map<String, dynamic> formData;

  SavedUserInfoData({required this.formData});
}
