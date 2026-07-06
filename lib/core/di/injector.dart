import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/network/dio_client.dart';
import 'package:noteapp/core/services/image_upload_service.dart';
import 'package:noteapp/features/captcha/bloc/catpcha_bloc.dart';
import 'package:noteapp/features/captcha/service/captcha_service.dart';
import 'package:noteapp/features/login/services/login_service.dart';
import 'package:noteapp/features/note/bloc/note_bloc.dart';
import 'package:noteapp/features/note/services/note_services.dart';
import 'package:noteapp/features/tags/bloc/tag_bloc.dart';
import 'package:noteapp/features/tags/service/tag_service.dart';
import 'package:noteapp/features/otp_verification/services/otp_verification_service.dart';
import 'package:noteapp/features/profile/services/profile_service.dart';
import 'package:noteapp/features/reset_password/services/reset_password_service.dart';
import 'package:noteapp/features/sign_up/services/signup_service.dart';

final getIt = GetIt.instance;

Future<void> setUpDi(String baseUrl) async {
  // dio client
  getIt.registerLazySingleton<DioClient>(() => DioClient(baseUrl: baseUrl));
  getIt.registerLazySingleton<ImageUploadService>(
    () => ImageUploadService(getIt()),
  );
  getIt.registerLazySingleton<SignupService>(() => SignupService(getIt()));
  getIt.registerLazySingleton<LoginService>(() => LoginService(getIt()));
  getIt.registerLazySingleton<NoteServices>(() => NoteServices(getIt()));
  getIt.registerLazySingleton<TagService>(() => TagService(getIt()));
  getIt.registerLazySingleton<CaptchaService>(() => CaptchaService(getIt()));
  getIt.registerSingleton<LoadingOverlay>(LoadingOverlay());
  getIt.registerSingleton<ResetPasswordService>(ResetPasswordService(getIt()));
  getIt.registerSingleton<OTPVerificationService>(
    OTPVerificationService(getIt()),
  );
  getIt.registerSingleton<ProfileService>(ProfileService(getIt()));
  getIt.registerSingleton<CaptchaBloc>(
    CaptchaBloc(captchaService: getIt<CaptchaService>()),
  );
  getIt.registerFactory<NoteBloc>(() => NoteBloc());
  getIt.registerFactory<TagBloc>(() => TagBloc());
}
