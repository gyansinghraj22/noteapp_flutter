import 'package:equatable/equatable.dart';

abstract class CaptchaEvent extends Equatable {
  const CaptchaEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch a new CAPTCHA from the backend
class FetchCaptchaEvent extends CaptchaEvent {
  const FetchCaptchaEvent();
}

/// Event to submit the user's CAPTCHA answer
class SubmitCaptchaAnswerEvent extends CaptchaEvent {
  final String captchaId;
  final String answer;

  const SubmitCaptchaAnswerEvent({
    required this.captchaId,
    required this.answer,
  });

  @override
  List<Object?> get props => [captchaId, answer];
}

/// Event to refresh/reload the CAPTCHA
class RefreshCaptchaEvent extends CaptchaEvent {
  const RefreshCaptchaEvent();
}

/// Event to reset the CAPTCHA state
class ResetCaptchaEvent extends CaptchaEvent {
  const ResetCaptchaEvent();
}
