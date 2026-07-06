import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/navigation_service/navigation_service.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

class AuthorizationInterceptor extends Interceptor {
  bool _isRefreshing = false;
  final List<void Function(String)> _refreshSubscribers = [];

  void _addSubscriber(void Function(String) callback) {
    _refreshSubscribers.add(callback);
  }

  void _onRefresh(String token) {
    for (final cb in _refreshSubscribers) {
      try {
        cb(token);
      } catch (_) {}
    }
    _refreshSubscribers.clear();
  }

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
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // If backend returns 401 as a normal response (rare), log out.
    if (response.statusCode == 401) {
      NavigationService.logOutUser();
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    // Only attempt refresh for requests that require auth and when we received 401
    if (err.response?.statusCode == 401 && _needAuthorizationHeader(requestOptions)) {
      final refreshToken = SharedPref.getStringValue(KeyString.refreshTokenKey.name);

      if (refreshToken.isEmpty) {
        // No refresh token available -> logout
        NavigationService.logOutUser();
        return handler.next(err);
      }

      // If a refresh is already in progress, queue this request
      if (_isRefreshing) {
        final completer = Completer<Response>();
        _addSubscriber((String token) async {
          try {
            // retry the request with new token
            requestOptions.headers['Authorization'] = 'Bearer $token';
            final retryDio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
            final response = await retryDio.fetch(requestOptions);
            completer.complete(response);
          } catch (e) {
            completer.completeError(e);
          }
        });

        try {
          final response = await completer.future;
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }

      // Start refreshing
      _isRefreshing = true;
      try {
        final refreshDio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
        final refreshResponse = await refreshDio.post(
          ApiUrls.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        if (refreshResponse.statusCode == 200 || refreshResponse.statusCode == 201) {
          final newAccess = refreshResponse.data['accessToken'] ?? '';
          final newRefresh = refreshResponse.data['refreshToken'] ?? '';

          if (newAccess.isEmpty) {
            // Unable to refresh -> logout
            _isRefreshing = false;
            NavigationService.logOutUser();
            return handler.next(err);
          }

          await SharedPref.setStringValue(KeyString.authTokenKey.name, newAccess);
          if (newRefresh.isNotEmpty) {
            await SharedPref.setStringValue(KeyString.refreshTokenKey.name, newRefresh);
          }

          _isRefreshing = false;
          _onRefresh(newAccess);

          // Retry the original request with new access token
          requestOptions.headers['Authorization'] = 'Bearer $newAccess';
          final retryDio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
          try {
            final response = await retryDio.fetch(requestOptions);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(err);
          }
        } else {
          // Refresh endpoint returned non-success -> force logout
          _isRefreshing = false;
          NavigationService.logOutUser();
          return handler.next(err);
        }
      } catch (e) {
        // Refresh request failed -> logout
        _isRefreshing = false;
        NavigationService.logOutUser();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    for (final String path in noAuthPaths) {
      if (options.path.contains(path)) {
        return false;
      }
    }
    return true;
  }

  // keep this helper around in case the server sends token in headers
  refreshToken({required bool noAuth, required response}) async {
    if (response.headers.contains("X-XSRF-TOKEN")) {
      var xsrfToken = response.headers["X-XSRF-TOKEN"]![0].toString();
      await SharedPref.setStringValue(KeyString.authTokenKey.name, xsrfToken);
    }
  }
}

// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:noteapp/constants/api_urls.dart';
// import 'package:noteapp/constants/key_string.dart';
// import 'package:noteapp/core/navigation_service/navigation_service.dart';
// import 'package:noteapp/core/utils/shared_pref.dart';

// class AuthorizationInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     String token = SharedPref.getStringValue(KeyString.authTokenKey.name);
//     if (options.data is FormData) {
//       // options.headers['Content-type'] = "multipart/form-data";
//     } else {
//       options.headers['Accept'] = "*/*";
//       options.headers['Content-type'] = "application/json";
//     }
//     if (_needAuthorizationHeader(options)) {
//       log('Bearer $token');
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     if (response.statusCode == 401) {
//       refreshToken(noAuth: false, response: response);

//       NavigationService.logOutUser();
//     }

//     return super.onResponse(response, handler);
//   }

//   bool _needAuthorizationHeader(RequestOptions options) {
//     for (final String path in noAuthPaths) {
//       if (options.path.contains(path)) {
//         return false;
//       }
//     }
//     return true;
//   }

//   refreshToken({required bool noAuth, required response}) async {
//     if (response.headers.contains("X-XSRF-TOKEN")) {
//       var xsrfToken = response.headers["X-XSRF-TOKEN"]![0].toString();
//       await SharedPref.setStringValue(KeyString.authTokenKey.name, xsrfToken);
//     }
//   }
// }
