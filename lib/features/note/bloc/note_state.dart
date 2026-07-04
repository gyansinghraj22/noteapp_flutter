part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteGetSuccessState extends NoteState {
  final dynamic response;

  NoteGetSuccessState({required this.response});
}

class NoteGetErrorState extends NoteState {
  final ErrorModel errorModel;

  NoteGetErrorState({required this.errorModel});
}

class NoteCreateSuccessState extends NoteState {
  final dynamic response;

  NoteCreateSuccessState({required this.response});
}

class NoteCreateErrorState extends NoteState {
  final ErrorModel errorModel;

  NoteCreateErrorState({required this.errorModel});
}

class NoteDeleteSuccessState extends NoteState {
  final dynamic response;

  NoteDeleteSuccessState({required this.response});
}


class NoteUpdateSuccessState extends NoteState {
  final dynamic response;

  NoteUpdateSuccessState({required this.response});
}
class NoteUpdateErrorState extends NoteState {
  final ErrorModel errorModel;

  NoteUpdateErrorState({required this.errorModel});
}
class NoteDeleteErrorState extends NoteState {
  final ErrorModel errorModel;

  NoteDeleteErrorState({required this.errorModel});
}
