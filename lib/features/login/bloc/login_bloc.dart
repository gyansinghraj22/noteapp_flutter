import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/login/services/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final loginService = GetIt.instance.get<LoginService>();
    on<LoginEvent>((event, emit) async {
      if (event is LoginInitialEvent) {
        emit(LoginInitial());
      } else if (event is UserLoginEvent) {
        var result = await loginService.userLogin(formData: event.formData);
        result.fold(
          (l) {
            emit(UserLoginSuccessState(response: l));
          },
          (r) {
            emit(
              UserLoginErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
