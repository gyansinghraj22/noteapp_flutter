import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class TagService {
  final DioClient apiCall;
  TagService(this.apiCall);
  Future<Either<dynamic, ErrorModel>> getTags() async {
    try {
      var response = await apiCall.getData(ApiUrls.tags);
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
      return right(ErrorModel(code: 400, message: "Failed to fetch tags"));
    }
  }

  Future<Either<dynamic, ErrorModel>> createTag({
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.postData("tags", formData);
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
      return right(ErrorModel(code: 400, message: "Failed to create tag"));
    }
  }

  Future<Either<dynamic, ErrorModel>> deleteTag({required String tagId}) async {
    try {
      var response = await apiCall.deleteData("tags/$tagId");
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
      return right(ErrorModel(code: 400, message: "Failed to delete tag"));
    }
  }
}
