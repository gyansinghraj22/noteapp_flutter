import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/sign_up/services/signup_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    final signupService = GetIt.instance.get<SignupService>();

    on<SignupEvent>((event, emit) async {
      if (event is SignupInitialEvent) {
        emit(SignupInitial());
        // } else if (event is SignupWithGoogleEvent) {
        //   var result = await signupService.signupWithGoogle();
        //   result.fold((l) {
        //     emit(SignupWithGoogleSuccessState(response: l));
        //   }, (r) {
        //     emit(SignupWithGoogleErrorState(
        //         errorModel: ErrorModel(
        //       code: r.code,
        //       message: r.message,
        //     )));
        //   });
      } else if (event is SignupWithFacebookEvent) {
        var result = await signupService.signupWithFacebook();
        result.fold(
          (l) {
            emit(SignupWithFacebookSuccessState(response: l));
          },
          (r) {
            emit(
              SignupWithFacebookErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is SignupWithPassword) {
        var result = await signupService.registerUser(formData: event.formData);
        result.fold(
          (l) {
            emit(SignupWithPasswordSuccessState(response: l));
          },
          (r) {
            emit(
              SignupWithPasswordErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is SavedUserInfoData) {
        var result = await signupService.savedUserInfoData(
          formData: event.formData,
        );
        result.fold(
          (l) {
            emit(SavedUserInfoDataSuccessState(response: l));
          },
          (r) {
            emit(
              SavedUserInfoDataErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
