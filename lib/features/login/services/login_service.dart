import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

class LoginService {
  final DioClient apiCall;
  LoginService(this.apiCall);

  Future<Either<dynamic, ErrorModel>> userLogin({
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.postData(ApiUrls.login, formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPref.setStringValue(
          KeyString.authTokenKey.name,
          response.data['token'],
        );
        await SharedPref.setStringValue(
          KeyString.userEmail.name,
          response.data['userName'],
        );
        await SharedPref.setStringValue(
          KeyString.userID.name,
          response.data['userId'].toString(),
        );
        await SharedPref.setBoolValue(KeyString.isLoginUser.name, true);
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
      return right(ErrorModel(code: 400, message: "Login failed"));
    }
  }
}
