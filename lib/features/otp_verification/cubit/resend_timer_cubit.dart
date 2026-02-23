import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'resend_timer_state.dart';

class ResendTimerCubit extends Cubit<ResendTimerState> {
  ResendTimerCubit() : super(ResendTimerInitial());

  getResendTime(int counter) {
    int resendTime = 60;
    if (counter < 61) {
      emit(ResendTimeLeftState(
          resendTimeLeft: resendTime - counter, resend: false));
    } else {
      emit(ResendTimeLeftState(resendTimeLeft: 0, resend: true));
    }
  }
}
