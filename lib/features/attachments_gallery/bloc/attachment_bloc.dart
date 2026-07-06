import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/attachments_gallery/service/attachment_service.dart';

part 'attachment_state.dart';
part 'attachment_event.dart';

class AttachmentBloc extends Bloc<AttachmentEvent, AttachmentState> {
  AttachmentBloc() : super(AttachmentInitial()) {
    final attachmentService = GetIt.instance.get<AttachmentService>();
    on<AttachmentEvent>((event, emit) async {
      if (event is AttachmentInitialEvent) {
        emit(AttachmentInitial());
      } else if (event is AttachmentGetEvent) {
        emit(AttachmentLoadingState());
        var result = await attachmentService.getAttachmentsByNote(
          noteId: event.formData['noteId'],
        );
        result.fold(
          (l) {
            emit(AttachmentGetSuccessState(response: l));
          },
          (r) {
            emit(
              AttachmentGetErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is AttachmentCreateEvent) {
        emit(AttachmentLoadingState());
        var result = await attachmentService.uploadAttachment(
          noteId: event.formData['noteId'],
          formData: event.formData,
        );
        result.fold(
          (l) {
            emit(AttachemenUploadSuccessState(response: l));
          },
          (r) {
            emit(
              AttachmentUploadErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is AttachmentDeleteEvent) {
        emit(AttachmentLoadingState());
        var result = await attachmentService.deleteAttachment(
          noteId: event.formData['noteId'],
          attachmentId: event.formData['attachmentId'],
        );
        result.fold(
          (l) {
            emit(AttachmentDeleteSuccessState(response: l));
          },
          (r) {
            emit(
              AttachmentDeleteErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
