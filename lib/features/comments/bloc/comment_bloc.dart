import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/comments/service/comment_service.dart';

part 'comment_state.dart';
part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    final commentService = GetIt.instance.get<CommentService>();
    on<CommentEvent>((event, emit) async {
      if (event is CommentInitialEvent) {
        emit(CommentInitial());
      } else if (event is CommentGetEvent) {
        emit(CommentLoadingState());
        var result = await commentService.getComments(
          noteId: event.formData['noteId'],
        );
        result.fold(
          (l) {
            emit(CommentGetSuccessState(response: l));
          },
          (r) {
            emit(
              CommentGetErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is CommentCreateEvent) {
        emit(CommentLoadingState());
        var result = await commentService.createComment(
          noteId: event.formData['noteId'],
          formData: event.formData,
        );
        result.fold(
          (l) {
            emit(CommentCreateSuccessState(response: l));
          },
          (r) {
            emit(
              CommentCreateErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is CommentDeleteEvent) {
        emit(CommentLoadingState());
        var result = await commentService.deleteComment(
          noteId: event.formData['noteId'],
          commentId: event.formData['commentId'],
        );
        result.fold(
          (l) {
            emit(CommentDeleteSuccessState(response: l));
          },
          (r) {
            emit(
              CommentDeleteErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
