import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

class GoogleLoginService {
  final DioClient apiCall;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  GoogleLoginService(this.apiCall);

  Future<Either<dynamic, ErrorModel>> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      final account = await _googleSignIn.authenticate();

      final idToken = account.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        return right(
          ErrorModel(code: 400, message: 'Google ID token is missing'),
        );
      }

      final response = await apiCall.postData(ApiUrls.googleLogin, {
        'idToken': idToken,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        await SharedPref.setStringValue(
          KeyString.authTokenKey.name,
          data['accessToken'],
        );
        await SharedPref.setStringValue(
          KeyString.refreshTokenKey.name,
          data['refreshToken'],
        );
        await SharedPref.setBoolValue(KeyString.isLoginUser.name, true);

        return left(data);
      }

      return right(
        ErrorModel(
          code: response.statusCode,
          message: response.data['message'] ?? 'Google login failed',
        ),
      );
    } catch (e) {
      return right(ErrorModel(code: 400, message: 'Google login failed'));
    }
  }
}
