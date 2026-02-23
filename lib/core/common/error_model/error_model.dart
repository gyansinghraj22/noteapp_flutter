class ErrorModel {
  int? code;
  String? message;

  ErrorModel({this.code, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = code;
    data['message'] = message;
    return data;
  }
}
