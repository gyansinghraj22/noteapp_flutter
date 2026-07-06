import 'package:dartz/dartz.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class AttachmentService {
  final DioClient apiCall;
  AttachmentService(this.apiCall);
  Future<Either<dynamic, ErrorModel>> getAttachmentsByNote({
    required String noteId,
  }) async {
    try {
      var response = await apiCall.getData("notes/$noteId/attachments");
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
        ErrorModel(code: 400, message: "Failed to fetch attachments"),
      );
    }
  }

  Future<Either<dynamic, ErrorModel>> uploadAttachment({
    required String noteId,
    required Map<String, dynamic> formData,
  }) async {
    try {
      var response = await apiCall.postData(
        "notes/$noteId/attachments",
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
      return right(
        ErrorModel(code: 400, message: "Failed to upload attachment"),
      );
    }
  }

  Future<Either<dynamic, ErrorModel>> deleteAttachment({
    required String noteId,
    required String attachmentId,
  }) async {
    try {
      var response = await apiCall.deleteData(
        "notes/$noteId/attachments/$attachmentId",
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
        ErrorModel(code: 400, message: "Failed to delete attachment"),
      );
    }
  }
}
