import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';
import '../models/captcha_model.dart';

class CaptchaService {
  final DioClient apiCall;

  CaptchaService(this.apiCall);

  Map<String, dynamic>? _extractCaptchaPayload(dynamic data) {
    if (data is Map<String, dynamic>) {
      final nested = data['data'];
      if (nested is Map<String, dynamic>) {
        return nested;
      }
      return data;
    }

    if (data is Map) {
      final payload = Map<String, dynamic>.from(data);
      final nested = payload['data'];
      if (nested is Map) {
        return Map<String, dynamic>.from(nested);
      }
      return payload;
    }

    return null;
  }

  /// Fetch CAPTCHA from backend
  /// Returns [CaptchaModel] on success or [ErrorModel] on failure
  Future<Either<CaptchaModel, ErrorModel>> fetchCaptcha() async {
    try {
      var response = await apiCall.getData(ApiUrls.captchaChallenge);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final payload = _extractCaptchaPayload(response.data);
        if (payload == null) {
          return right(
            ErrorModel(
              code: response.statusCode,
              message: 'Invalid CAPTCHA response',
            ),
          );
        }

        return left(CaptchaModel.fromJson(payload));
      } else {
        return right(
          ErrorModel(
            code: response.statusCode,
            message: response.data['message'] ?? 'Failed to fetch CAPTCHA',
          ),
        );
      }
    } catch (e) {
      return right(ErrorModel(code: 400, message: 'Failed to fetch CAPTCHA'));
    }
  }

  /// Validate CAPTCHA answer
  /// [captchaId] - The CAPTCHA ID from the backend
  /// [answer] - The user's answer to the CAPTCHA question
  /// Returns response data on success or [ErrorModel] on failure
  Future<Either<dynamic, ErrorModel>> validateCaptcha({
    required String captchaId,
    required String answer,
  }) async {
    try {
      final formData = {'captchaId': captchaId, 'answer': answer};

      var response = await apiCall.postData(ApiUrls.captchaChallenge, formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return left(response.data);
      } else {
        return right(
          ErrorModel(
            code: response.statusCode,
            message: response.data['message'] ?? 'Failed to validate CAPTCHA',
          ),
        );
      }
    } catch (e) {
      return right(ErrorModel(code: 400, message: 'CAPTCHA validation failed'));
    }
  }

  /// Check if CAPTCHA is expired
  bool isCaptchaExpired(DateTime fetchedTime, int expiresInSeconds) {
    final currentTime = DateTime.now();
    final elapsedSeconds = currentTime.difference(fetchedTime).inSeconds;
    return elapsedSeconds >= expiresInSeconds;
  }
}
