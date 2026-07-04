import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/captcha_service.dart';
import 'captcha_event.dart';
import 'captcha_state.dart';

class CaptchaBloc extends Bloc<CaptchaEvent, CaptchaState> {
  final CaptchaService captchaService;
  DateTime? _captchaFetchedTime;

  CaptchaBloc({required this.captchaService}) : super(const CaptchaInitial()) {
    on<FetchCaptchaEvent>(_onFetchCaptcha);
    on<SubmitCaptchaAnswerEvent>(_onSubmitCaptchaAnswer);
    on<RefreshCaptchaEvent>(_onRefreshCaptcha);
    on<ResetCaptchaEvent>(_onResetCaptcha);
  }

  /// Handle FetchCaptchaEvent
  Future<void> _onFetchCaptcha(
    FetchCaptchaEvent event,
    Emitter<CaptchaState> emit,
  ) async {
    emit(const CaptchaLoading());
    final result = await captchaService.fetchCaptcha();

    result.fold(
      (captcha) {
        _captchaFetchedTime = DateTime.now();
        emit(
          CaptchaLoaded(captcha: captcha, fetchedTime: _captchaFetchedTime!),
        );
      },
      (error) {
        emit(CaptchaError(errorMessage: error.message ?? 'Unknown error'));
      },
    );
  }

  /// Handle SubmitCaptchaAnswerEvent
  Future<void> _onSubmitCaptchaAnswer(
    SubmitCaptchaAnswerEvent event,
    Emitter<CaptchaState> emit,
  ) async {
    // Check if CAPTCHA is expired
    if (_captchaFetchedTime != null) {
      final currentState = state;
      int expiresInSeconds = 300; // Default

      if (currentState is CaptchaLoaded) {
        expiresInSeconds = currentState.captcha.expiresInSeconds;
      }

      if (captchaService.isCaptchaExpired(
        _captchaFetchedTime!,
        expiresInSeconds,
      )) {
        emit(const CaptchaExpired());
        return;
      }
    }

    final currentState = state;
    if (currentState is CaptchaLoaded) {
      emit(CaptchaValidating(captcha: currentState.captcha));
    }

    final result = await captchaService.validateCaptcha(
      captchaId: event.captchaId,
      answer: event.answer,
    );

    result.fold(
      (response) {
        final isValid = response['isValid'] as bool? ?? false;
        if (isValid) {
          emit(const CaptchaValidationSuccess());
        } else {
          emit(
            const CaptchaValidationFailure(
              errorMessage: 'Incorrect answer. Please try again.',
            ),
          );
        }
      },
      (error) {
        emit(
          CaptchaValidationFailure(
            errorMessage: error.message ?? 'Validation failed',
          ),
        );
      },
    );
  }

  /// Handle RefreshCaptchaEvent
  Future<void> _onRefreshCaptcha(
    RefreshCaptchaEvent event,
    Emitter<CaptchaState> emit,
  ) async {
    add(const FetchCaptchaEvent());
  }

  /// Handle ResetCaptchaEvent
  Future<void> _onResetCaptcha(
    ResetCaptchaEvent event,
    Emitter<CaptchaState> emit,
  ) async {
    _captchaFetchedTime = null;
    emit(const CaptchaInitial());
  }
}
