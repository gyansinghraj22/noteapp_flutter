import 'package:dartz/dartz.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/common/error_model/error_model.dart';
import 'package:noteapp/core/network/dio_client.dart';

class ChatService {
  final DioClient apiCall;

  ChatService(this.apiCall);

  Future<Either<List<Map<String, dynamic>>, ErrorModel>> getMyConversations() async {
    try {
      final response = await apiCall.getData(ApiUrls.chatConversations);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is List) {
          return left(
            data
                .map((item) => Map<String, dynamic>.from(item as Map<String, dynamic>))
                .toList(),
          );
        }
        return left(<Map<String, dynamic>>[]);
      }

      final message = _extractMessage(response.data);
      return right(
        ErrorModel(
          code: response.statusCode ?? 400,
          message: message,
        ),
      );
    } catch (e) {
      return right(
        ErrorModel(code: 400, message: 'Failed to load conversations'),
      );
    }
  }

  Future<Either<List<Map<String, dynamic>>, ErrorModel>> getConversationMessages(
    int conversationId,
  ) async {
    try {
      final url = '${ApiUrls.chatConversations}/$conversationId/messages';
      final response = await apiCall.getData(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is List) {
          return left(
            data
                .map((item) => Map<String, dynamic>.from(item as Map<String, dynamic>))
                .toList(),
          );
        }
        return left(<Map<String, dynamic>>[]);
      }

      final message = _extractMessage(response.data);
      return right(
        ErrorModel(
          code: response.statusCode ?? 400,
          message: message,
        ),
      );
    } catch (e) {
      return right(
        ErrorModel(code: 400, message: 'Failed to load messages'),
      );
    }
  }

  Future<Either<Map<String, dynamic>, ErrorModel>> sendMessage({
    required int conversationId,
    required String content,
  }) async {
    try {
      final response = await apiCall.postData(
        ApiUrls.chatMessages,
        {
          'conversationId': conversationId,
          'content': content,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return left(Map<String, dynamic>.from(response.data as Map));
      }

      final message = _extractMessage(response.data);
      return right(
        ErrorModel(
          code: response.statusCode ?? 400,
          message: message,
        ),
      );
    } catch (e) {
      return right(
        ErrorModel(code: 400, message: 'Failed to send message'),
      );
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data['message'] != null) {
        return data['message'].toString();
      }
      if (data['error'] != null) {
        return data['error'].toString();
      }
    }
    if (data is Map) {
      final map = data.cast<String, dynamic>();
      if (map['message'] != null) {
        return map['message'].toString();
      }
      if (map['error'] != null) {
        return map['error'].toString();
      }
    }

    return 'Something went wrong';
  }
}
