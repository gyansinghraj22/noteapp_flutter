class ApiResponse<T> {
  bool? success;
  T? data;
  String? error;
  String? message;

  ApiResponse(
      {this.success = false, this.data, this.error = '', this.message = ''});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      data: json['data'],
      error: json['error'] ?? "",
      message: json['message'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'error': error,
      'message': message,
    };
  }
}
