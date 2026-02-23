import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/reset_password/services/reset_password_service.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    final resetPasswordService = GetIt.instance.get<ResetPasswordService>();
    on<ResetPasswordEvent>((event, emit) async {
      if (event is ResetPasswordInitialEvent) {
        emit(ResetPasswordInitial());
      } else if (event is SetResetPasswordEvent) {
        var result = await resetPasswordService.resetPassword(
          formData: event.formData,
        );
        result.fold(
          (l) {
            emit(ResetPasswordSuccessState(response: l));
          },
          (r) {
            emit(
              ResetPasswordErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
