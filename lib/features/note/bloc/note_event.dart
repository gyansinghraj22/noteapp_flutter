part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class NoteInitialEvent extends NoteEvent {}

class NoteGetEvent extends NoteEvent {
  final Map<String, dynamic> formData;

  NoteGetEvent({required this.formData});
}

class NoteCreateEvent extends NoteEvent {
  final Map<String, dynamic> formData;

  NoteCreateEvent({required this.formData});
}

class NoteUpdateEvent extends NoteEvent {
  final Map<String, dynamic> formData;
  NoteUpdateEvent({required this.formData});
}

class NoteDeleteEvent extends NoteEvent {
  final Map<String, dynamic> formData;
  NoteDeleteEvent({required this.formData});
}
