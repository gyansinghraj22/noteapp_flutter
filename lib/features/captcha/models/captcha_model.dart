import 'package:equatable/equatable.dart';

class CaptchaModel extends Equatable {
  final String captchaId;
  final String question;
  final int expiresInSeconds;

  const CaptchaModel({
    required this.captchaId,
    required this.question,
    required this.expiresInSeconds,
  });

  // Convert JSON from backend to CaptchaModel
  factory CaptchaModel.fromJson(Map<String, dynamic> json) {
    return CaptchaModel(
      captchaId: json['captchaId']?.toString() ?? '',
      question: json['question']?.toString() ?? '',
      expiresInSeconds: _toInt(json['expiresInSeconds']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  // Convert CaptchaModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'captchaId': captchaId,
      'question': question,
      'expiresInSeconds': expiresInSeconds,
    };
  }

  @override
  List<Object?> get props => [captchaId, question, expiresInSeconds];
}
