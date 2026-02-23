part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent {}

class ResetPasswordInitialEvent extends ResetPasswordEvent {}

class SetResetPasswordEvent extends ResetPasswordEvent {
  final Map<String, dynamic> formData;

  SetResetPasswordEvent({required this.formData});
}
