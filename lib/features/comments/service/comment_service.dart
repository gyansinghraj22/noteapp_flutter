import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class CommentService {
  final DioClient apiCall;
  CommentService(this.apiCall);
  Future<Either<dynamic, ErrorModel>> getComments({
    required String noteId,
  }) async {
    try {
      var response = await apiCall.getData("ApiUrls.notes/{$noteId}/comments");
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
      return right(ErrorModel(code: 400, message: "Failed to fetch comments"));
    }
  }

  Future<Either<dynamic, ErrorModel>> createComment({
    required String noteId,
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.postData(
        "ApiUrls.notes/{$noteId}/comments",
        formData,
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
      return right(ErrorModel(code: 400, message: "Failed to create comment"));
    }
  }

  Future<Either<dynamic, ErrorModel>> deleteComment({
    required String noteId,
    required String commentId,
  }) async {
    try {
      var response = await apiCall.deleteData("api/comments/{$commentId}");
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
      return right(ErrorModel(code: 400, message: "Failed to delete comment"));
    }
  }
}
