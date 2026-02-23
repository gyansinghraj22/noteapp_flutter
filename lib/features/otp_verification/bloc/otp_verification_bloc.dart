import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/otp_verification/services/otp_verification_service.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(OtpVerificationInitial()) {
    final oTPVerificationService = GetIt.instance.get<OTPVerificationService>();

    on<OtpVerificationEvent>((event, emit) async {
      if (event is OtpVerificationInitialEvent) {
        emit(OtpVerificationInitial());
      } else if (event is OtpVerifyEvent) {
        var result = await oTPVerificationService.otpVrification(
          otpNumber: event.otpNumber,
          email: event.email,
        );
        result.fold(
          (l) {
            emit(OtpVerificationSuccessState(response: l));
          },
          (r) {
            emit(
              OtpVerificationErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is PasswordOtpVerifyEvent) {
        var result = await oTPVerificationService.passwordOtpVrification(
          otpNumber: event.otpNumber,
          email: event.email,
        );
        result.fold(
          (l) {
            emit(PasswordOtpVerificationSuccessState(response: l));
          },
          (r) {
            emit(
              PasswordOtpVerificationErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is SendOtpEvent) {
        var result = await oTPVerificationService.sendOTP(event.email);
        result.fold(
          (l) {
            emit(SendOtpSuccessState(response: l));
          },
          (r) {
            emit(
              SendOtpErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
