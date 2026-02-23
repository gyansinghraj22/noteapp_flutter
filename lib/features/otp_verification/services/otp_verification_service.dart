import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

class OTPVerificationService {
  final DioClient apiCall;
  OTPVerificationService(this.apiCall);

  Future<Either<dynamic, ErrorModel>> otpVrification({
    required String otpNumber,
    required String email,
  }) async {
    try {
      var response = await apiCall.postData(ApiUrls.verifyOTP, {
        'email': email,
        'otp': otpNumber,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPref.setStringValue(
          KeyString.authTokenKey.name,
          response.data['token'],
        );
        return left(response.data);
      } else {
        return right(
          ErrorModel(
            code: response.statusCode,
            message: response.data['message'],
          ),
        );
      }
    } catch (e) {
      return right(ErrorModel(code: 400, message: "OTP verification failed"));
    }
  }

  Future<Either<dynamic, ErrorModel>> passwordOtpVrification({
    required String otpNumber,
    required String email,
  }) async {
    try {
      var response = await apiCall.postData(ApiUrls.verifyPasswordOTP, {
        'email': email,
        'otp': otpNumber,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return left(response.data);
      } else {
        return right(
          ErrorModel(
            code: response.statusCode,
            message: response.data['message'],
          ),
        );
      }
    } catch (e) {
      return right(ErrorModel(code: 400, message: "OTP verification failed"));
    }
  }

  Future<Either<dynamic, ErrorModel>> sendOTP(String email) async {
    try {
      var otpRespose = await apiCall.postData(ApiUrls.sendOtp, {
        'email': email,
      });
      if (otpRespose.statusCode == 200 || otpRespose.statusCode == 201) {
        return left(otpRespose.data);
      } else {
        return right(
          ErrorModel(
            code: otpRespose.statusCode,
            message: otpRespose.data['message'],
          ),
        );
      }
    } catch (e) {
      return right(ErrorModel(code: 400, message: "OTP Sent failed"));
    }
  }
}
