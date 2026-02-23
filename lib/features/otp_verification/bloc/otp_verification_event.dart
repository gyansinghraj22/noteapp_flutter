part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationEvent {}

class OtpVerificationInitialEvent extends OtpVerificationEvent {}

class OtpVerifyEvent extends OtpVerificationEvent {
  final String otpNumber;
  final String email;

  OtpVerifyEvent({
    required this.otpNumber,
    required this.email,
  });
}

class PasswordOtpVerifyEvent extends OtpVerificationEvent {
  final String otpNumber;
  final String email;

  PasswordOtpVerifyEvent({
    required this.otpNumber,
    required this.email,
  });
}

class SendOtpEvent extends OtpVerificationEvent {
  final String email;

  SendOtpEvent({required this.email});
}
