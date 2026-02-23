import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class ProfileService {
  final DioClient apiCall;
  ProfileService(this.apiCall);
  Future<Either<dynamic, ErrorModel>> getProfileInfo() async {
    try {
      var response = await apiCall.getData(ApiUrls.getProfileInfo);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return left(response.data['data']);
      } else {
        return right(
          ErrorModel(
            code: response.statusCode,
            message: response.data['message'],
          ),
        );
      }
    } catch (e) {
      return right(ErrorModel(code: 400, message: "Profile Info Failed"));
    }
  }

  Future<Either<dynamic, ErrorModel>> updateProdileInfo({
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.putData(ApiUrls.updateProfileInfo, formData);
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
      return right(ErrorModel(code: 400, message: "Login failed"));
    }
  }
}
