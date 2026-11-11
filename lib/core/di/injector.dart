import 'package:get_it/get_it.dart';
import 'package:noteapp/features/chat/service/chat_service.dart';

Future<void> setUpDi(String baseUrl) async {
  getIt.registerLazySingleton<DioClient>(() => DioClient(baseUrl: baseUrl));
  getIt.registerLazySingleton<ImageUploadService>(
    () => ImageUploadService(getIt()),
  );
  getIt.registerLazySingleton<SignupService>(() => SignupService(getIt()));
  getIt.registerLazySingleton<LoginService>(() => LoginService(getIt()));
  getIt.registerLazySingleton<GoogleLoginService>(
    () => GoogleLoginService(getIt()),
  );
  getIt.registerLazySingleton<NoteServices>(() => NoteServices(getIt()));
  getIt.registerLazySingleton<ChatService>(() => ChatService(getIt()));
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
