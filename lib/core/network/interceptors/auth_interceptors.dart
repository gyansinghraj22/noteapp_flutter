import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/navigation_service/navigation_service.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String token = SharedPref.getStringValue(KeyString.authTokenKey.name);
    if (options.data is FormData) {
      // options.headers['Content-type'] = "multipart/form-data";
    } else {
      options.headers['Accept'] = "*/*";
      options.headers['Content-type'] = "application/json";
    }
    if (_needAuthorizationHeader(options)) {
      log('Bearer $token');
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // refreshToken(noAuth: false, response: response);
    if (response.statusCode == 401) {
      NavigationService.logOutUser();
    }

    return super.onResponse(response, handler);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    for (final String path in noAuthPaths) {
      if (options.path.contains(path)) {
        return false;
      }
    }
    return true;
  }

  refreshToken({required bool noAuth, required response}) async {
    if (response.headers.contains("X-XSRF-TOKEN")) {
      var xsrfToken = response.headers["X-XSRF-TOKEN"]![0].toString();
      await SharedPref.setStringValue(KeyString.authTokenKey.name, xsrfToken);
    }
  }
}
