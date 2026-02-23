import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/network/interceptors/auth_interceptors.dart';
import 'package:noteapp/core/network/interceptors/logger_interceptor.dart';

class DioClient {
  DioClient({required String baseUrl}) {
    setUpDio(baseUrl);
  }

  late Dio _dio;
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();

  setUpDio(String baseUrl) {
    _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          responseType: ResponseType.json,
          validateStatus: (status) => true,
          followRedirects: true,
          maxRedirects: 3,
        ),
      )
      ..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
        ChuckerDioInterceptor(),
      ]);
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }

  Future<Response> postData(String apiUrl, dynamic requestModel) async {
    try {
      var response = await _dio.post(apiUrl, data: requestModel);
      return response;
    } on DioException catch (e) {
      _loadingOverlay.hide();
      return Response(requestOptions: e.requestOptions);
    }
  }

  Future<Response> putData(String apiUrl, dynamic requestModel) async {
    try {
      var response = await _dio.put(apiUrl, data: requestModel);
      return response;
    } on DioException catch (e) {
      _loadingOverlay.hide();
      return Response(requestOptions: e.requestOptions);
    }
  }

  Future<Response> getData(String apiUrl) async {
    try {
      var response = await _dio.get(apiUrl);
      return response;
    } on DioException catch (e) {
      return Response(requestOptions: e.requestOptions);
    }
  }

  Future<Response> deleteData(String apiUrl) async {
    try {
      var response = await _dio.delete(apiUrl);
      return response;
    } on DioException catch (e) {
      return Response(requestOptions: e.requestOptions);
    }
  }

  Future<Response> getDataAndDownload(String apiUrl) async {
    try {
      Dio downloadDio = Dio(
        _dio.options.copyWith(responseType: ResponseType.bytes),
      );
      downloadDio.interceptors.addAll(_dio.interceptors);
      downloadDio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        },
      );

      var response = await downloadDio.get(apiUrl);
      return response;
    } on DioException catch (e) {
      return Response(requestOptions: e.requestOptions);
    }
  }
}

  // Future<Response> getDataAndDownload(String apiUrl, String fileType) async {
  //   try {
  //     Dio downloadDio = Dio(_dio.options.copyWith(
  //         responseType: ResponseType.bytes,
  //         headers: {HttpHeaders.acceptEncodingHeader: '*'}));
  //     downloadDio.interceptors.addAll([
  //       AuthorizationInterceptor(),
  //       LoggerInterceptor(),
  //     ]);
  //     downloadDio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
  //       final client = HttpClient();
  //       client.badCertificateCallback =
  //           (X509Certificate cert, String host, int port) => true;
  //       return client;
  //     });

  //     final directory = await _getDownloadDirectory();
  //     if (directory == null) {
  //       return Response(
  //         requestOptions: RequestOptions(path: apiUrl),
  //         statusCode: 500,
  //         statusMessage: 'Unable to determine download directory',
  //       );
  //     }
  //     final fileName =
  //         'network_member_sss_${DateTime.now().millisecondsSinceEpoch}.$fileType';
  //     final filePath = '${directory.path}/$fileName';
  //     final file = File(filePath);
  //     var response = await downloadDio.download(
  //       apiUrl,
  //       file.path,
  //       onReceiveProgress: (received, total) {
  //         if (total <= 0) return;
  //         log('percentage: ${(received / total * 100).toStringAsFixed(0)}%');
  //       },
  //     );

  //     return response;
  //   } on DioException catch (e) {
  //     return Response(requestOptions: e.requestOptions);
  //   } catch (e) {
  //     return Response(
  //       requestOptions: RequestOptions(path: apiUrl),
  //       statusCode: 500,
  //       statusMessage: e.toString(),
  //     );
  //   }
  // }

  // Future<Directory?> _getDownloadDirectory() async {
  //   try {
  //     if (Platform.isIOS) {
  //       try {
  //         final downloads = await getDownloadsDirectory();
  //         if (downloads != null) {
  //           return downloads;
  //         }
  //       } catch (e) {
  //         log('Error getting iOS downloads directory: $e');
  //       }
  //       final docs = await getApplicationDocumentsDirectory();
  //       return docs;
  //     } else if (Platform.isAndroid) {
  //       final directories = [
  //         Directory('/storage/emulated/0/Download'),
  //         await getExternalStorageDirectory(),
  //         Directory('/sdcard/Download'),
  //       ];

  //       for (final dir in directories) {
  //         if (dir != null && await dir.exists()) {
  //           log('Using Android directory: ${dir.path}');
  //           return dir;
  //         }
  //       }
  //       try {
  //         final appDocDir = await getApplicationDocumentsDirectory();
  //         return appDocDir;
  //       } catch (e) {
  //         log('Failed to get any storage directory: $e');
  //       }
  //     }

  //     return null;
  //   } catch (e) {
  //     return null;
  //   }
  // }


