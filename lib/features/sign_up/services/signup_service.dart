import 'package:dartz/dartz.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

class SignupService {
  final DioClient apiCall;
  SignupService(this.apiCall);

  // Future<Either<GoogleSignInAuthentication, ErrorModel>>
  //     signupWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       return right(
  //           ErrorModel(code: 400, message: "google authentication cancelled"));
  //     }
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     return left(googleAuth);
  //   } catch (e) {
  //     return right(
  //         ErrorModel(code: 400, message: "google authentication failed"));
  //   }
  // }

  Future<Either<dynamic, ErrorModel>> signupWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null) {
        return left(loginResult);
      } else {
        return right(
          ErrorModel(code: 400, message: "facebook authenication failed"),
        );
      }
    } catch (e) {
      return right(
        ErrorModel(code: 400, message: "facebook authenication failed"),
      );
    }
  }

  Future<Either<dynamic, ErrorModel>> registerUser({
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.postData(ApiUrls.register, formData);
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
      return right(ErrorModel(code: 400, message: "user registration failed"));
    }
  }

  Future<Either<dynamic, ErrorModel>> savedUserInfoData({
    required Map<String, dynamic> formData,
  }) async {
    String email = SharedPref.getStringValue(KeyString.userEmail.name);
    String userId = SharedPref.getStringValue(KeyString.userID.name);

    Map<String, dynamic> requiestBody = {
      ...formData,
      "email": email,
      "userId": userId,
    };

    try {
      var response = await apiCall.postData(
        ApiUrls.saveUserInfoData,
        requiestBody,
      );
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
      return right(
        ErrorModel(code: 400, message: "Saved User Information failed"),
      );
    }
  }
}
