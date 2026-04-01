import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/features/profile/services/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final profileService = GetIt.instance.get<ProfileService>();

    on<ProfileEvent>((event, emit) async {
      if (event is ProfileInitialEvent) {
        emit(ProfileInitial());
      } else if (event is GetProfileInfoEvent) {
        var result = await profileService.getProfileInfo();
        result.fold(
          (l) {
            emit(GetProfileInfoSuccessState(reposnse: l));
          },
          (r) {
            emit(
              GetProfileInfoErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      } else if (event is UpdateProfileInfoEvent) {
        var result = await profileService.updateProdileInfo(
          formData: event.formData,
        );
        result.fold(
          (l) {
            emit(UpdateProfileSuccessState(reposnse: l));
          },
          (r) {
            emit(
              UpdateProfileErrorState(
                errorModel: ErrorModel(code: r.code, message: r.message),
              ),
            );
          },
        );
      }
    });
  }
}
