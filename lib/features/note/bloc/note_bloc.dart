import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/note/services/note_services.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    final noteService = GetIt.instance.get<NoteServices>();
    on<NoteEvent>((event, emit) async {
      if (event is NoteInitialEvent) {
        emit(NoteInitial());
      } else if (event is NoteGetEvent) {
        emit(NoteLoadingState());
        var result = await noteService.getNotes();
        result.fold(
          (l) {
            emit(NoteGetSuccessState(response: l));
          },
          (r) {
            emit(
              NoteGetErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is NoteCreateEvent) {
        emit(NoteLoadingState());
        var result = await noteService.createNote(formData: event.formData);
        result.fold(
          (l) {
            emit(NoteCreateSuccessState(response: l));
          },
          (r) {
            emit(
              NoteCreateErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is NoteDeleteEvent) {
        emit(NoteLoadingState());
        var result = await noteService.deleteNote(
          noteId: event.formData['noteId'],
        );
        result.fold(
          (l) {
            emit(NoteDeleteSuccessState(response: l));
          },
          (r) {
            emit(
              NoteDeleteErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
