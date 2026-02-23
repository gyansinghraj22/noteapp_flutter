part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class GetProfileInfoEvent extends ProfileEvent {}

class UpdateProfileInfoEvent extends ProfileEvent {
  final Map<String, dynamic> formData;

  UpdateProfileInfoEvent({required this.formData});
}
