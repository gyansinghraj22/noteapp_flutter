import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/features/tags/service/tag_service.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(TagInitial()) {
    final tagService = GetIt.instance.get<TagService>();
    on<TagEvent>((event, emit) async {
      if (event is TagInitialEvent) {
        emit(TagInitial());
      } else if (event is TagGetEvent) {
        emit(TagLoadingState());
        var result = await tagService.getTags();
        result.fold(
          (l) {
            emit(TagGetSuccessState(response: l));
          },
          (r) {
            emit(
              TagGetErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is TagCreateEvent) {
        emit(TagLoadingState());
        var result = await tagService.createTag(formData: event.formData);
        result.fold(
          (l) {
            emit(TagCreateSuccessState(response: l));
          },
          (r) {
            emit(
              TagCreateErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is TagDeleteEvent) {
        emit(TagLoadingState());
        var result = await tagService.deleteTag(tagId: event.formData['tagId']);
        result.fold(
          (l) {
            emit(TagDeleteSuccessState(response: l));
          },
          (r) {
            emit(
              TagDeleteErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
