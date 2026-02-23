import 'package:dio/dio.dart';
import 'package:noteapp/core/network/api_response.dart';

class ErrorHandler {
  Future<String> handleError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive Timeout';
      case DioExceptionType.sendTimeout:
        return 'Send Timeout';
      case DioExceptionType.cancel:
        return 'Request Cancelled';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.unknown:
        return 'Unknown Error Occurred';
      default:
        return 'Something Went Wrong';
    }
  }

  String _handleBadResponse(DioException error) {
    switch (error.response?.statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        try {
          final apiResponse = ApiResponse.fromJson(error.response?.data);
          return apiResponse.message ?? 'Failed to load Data';
        } catch (e) {
          return 'Something went wrong (${error.response?.statusCode})';
        }
    }
  }
}
