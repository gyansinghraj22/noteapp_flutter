import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class NoteServices {
  final DioClient apiCall;
  NoteServices(this.apiCall);
  Future<Either<dynamic, ErrorModel>> getNotes() async {
    try {
      var response = await apiCall.getData(ApiUrls.notes);
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
      return right(ErrorModel(code: 400, message: "Failed to fetch notes"));
    }
  }

  Future<Either<dynamic, ErrorModel>> createNote({
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.postData("notes", formData);
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
      return right(ErrorModel(code: 400, message: "Failed to create note"));
    }
  }

  Future<Either<dynamic, ErrorModel>> deleteNote({
    required String noteId,
  }) async {
    try {
      var response = await apiCall.deleteData("notes/$noteId");
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
      return right(ErrorModel(code: 400, message: "Failed to delete note"));
    }
  }

  Future<Either<dynamic, ErrorModel>> updateNote({
    required String noteId,
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.putData("notes/$noteId", formData);
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
      return right(ErrorModel(code: 400, message: "Failed to update note"));
    }
  }
}
