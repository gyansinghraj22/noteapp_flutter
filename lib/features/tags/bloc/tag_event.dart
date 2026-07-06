part of 'tag_bloc.dart';

@immutable
abstract class TagEvent {}

class TagInitialEvent extends TagEvent {}

class TagGetEvent extends TagEvent {
  TagGetEvent();
}

class TagCreateEvent extends TagEvent {
  final Map<String, dynamic> formData;

  TagCreateEvent({required this.formData});
}

class TagDeleteEvent extends TagEvent {
  final Map<String, dynamic> formData;
  TagDeleteEvent({required this.formData});
}
