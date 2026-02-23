part of 'resend_timer_cubit.dart';

@immutable
class ResendTimerState {}

class ResendTimerInitial extends ResendTimerState {}

class ResendTimeLeftState extends ResendTimerState {
  final int resendTimeLeft;
  final bool resend;

  ResendTimeLeftState({this.resend = false, required this.resendTimeLeft});
}

class ResendState extends ResendTimerState {
  final bool resend;

  ResendState({required this.resend});
}
