import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class ImageUploadService {
  final DioClient apiCall;
  ImageUploadService(this.apiCall);

  Future<Either<String, ErrorModel>> imageUpload({
    required File image,
    required String apiUrl,
  }) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType("image", "*"),
        ),
      });
      var response = await apiCall.postData(apiUrl, formData);
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
        ErrorModel(code: 400, message: "I'm unable to upload image"),
      );
    }
  }
}
