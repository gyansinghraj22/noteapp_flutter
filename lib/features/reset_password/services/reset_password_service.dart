import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class ResetPasswordService {
  final DioClient apiCall;
  ResetPasswordService(this.apiCall);

  Future<Either<dynamic, ErrorModel>> resetPassword({
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.postData(ApiUrls.resetPassword, formData);
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
      return right(ErrorModel(code: 400, message: "Change Password Error"));
    }
  }
}
