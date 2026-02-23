part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class UserLoginEvent extends LoginEvent {
  final Map<String, dynamic> formData;

  UserLoginEvent({required this.formData});
}
