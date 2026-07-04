import 'package:equatable/equatable.dart';
import '../models/captcha_model.dart';

abstract class CaptchaState extends Equatable {
  const CaptchaState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CaptchaInitial extends CaptchaState {
  const CaptchaInitial();
}

/// Loading state while fetching CAPTCHA
class CaptchaLoading extends CaptchaState {
  const CaptchaLoading();
}

/// Successfully loaded CAPTCHA
class CaptchaLoaded extends CaptchaState {
  final CaptchaModel captcha;
  final DateTime fetchedTime;

  const CaptchaLoaded({required this.captcha, required this.fetchedTime});

  @override
  List<Object?> get props => [captcha, fetchedTime];
}

/// CAPTCHA validation is in progress
class CaptchaValidating extends CaptchaState {
  final CaptchaModel captcha;

  const CaptchaValidating({required this.captcha});

  @override
  List<Object?> get props => [captcha];
}

/// CAPTCHA validation succeeded
class CaptchaValidationSuccess extends CaptchaState {
  final String message;

  const CaptchaValidationSuccess({
    this.message = 'CAPTCHA verified successfully',
  });

  @override
  List<Object?> get props => [message];
}

/// CAPTCHA validation failed
class CaptchaValidationFailure extends CaptchaState {
  final String errorMessage;

  const CaptchaValidationFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

/// CAPTCHA has expired
class CaptchaExpired extends CaptchaState {
  const CaptchaExpired();
}

/// Error occurred while fetching CAPTCHA
class CaptchaError extends CaptchaState {
  final String errorMessage;

  const CaptchaError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
