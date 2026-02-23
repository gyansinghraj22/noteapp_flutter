part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationState {}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationSuccessState extends OtpVerificationState {
  final dynamic response;

  OtpVerificationSuccessState({required this.response});
}

class OtpVerificationErrorState extends OtpVerificationState {
  final ErrorModel errorModel;

  OtpVerificationErrorState({required this.errorModel});
}

class PasswordOtpVerificationSuccessState extends OtpVerificationState {
  final dynamic response;

  PasswordOtpVerificationSuccessState({required this.response});
}

class PasswordOtpVerificationErrorState extends OtpVerificationState {
  final ErrorModel errorModel;

  PasswordOtpVerificationErrorState({required this.errorModel});
}

class SendOtpSuccessState extends OtpVerificationState {
  final dynamic response;

  SendOtpSuccessState({required this.response});
}

class SendOtpErrorState extends OtpVerificationState {
  final ErrorModel errorModel;

  SendOtpErrorState({required this.errorModel});
}


