import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/storage_helper/local_storage_service.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorageService.getToken();


          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }


          handler.next(options);
        },
      ),
    );

    return dio;
  }
}