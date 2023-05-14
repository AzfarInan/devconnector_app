import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) {
  final dio = Dio();

  // Add logger interceptor
  dio.interceptors.add(PrettyDioLogger());

  return dio;
});

final restClientProvider = Provider<RestClient>((ref) {
  final dio = ref.watch(dioProvider);
  return RestClient(dio);
});

class RestClient {
  final Dio dio;

  RestClient(this.dio);

  Future<dynamic> handle401Redirection() async {
    // Add any logic here to handle the 401 response, such as logging the user out
    // and redirecting to the login page.
  }

  void _checkFor401(Response response) {
    if (response.statusCode == 401) {
      handle401Redirection();
    }
  }

  Future<dynamic> _executeRequest(Future<dynamic> Function() request) async {
    try {
      final response = await request();
      return response;
    } on DioError catch (error) {
      if (error.response != null) {
        final response = error.response!;
        if (response.statusCode == 404 || response.statusCode == 400) {
          throw ErrorModel.fromJson(response.data);
        }
        _checkFor401(response);
        return response.data;
      } else if (error.type == DioErrorType.unknown) {
        throw ErrorModel.fromJson({'message': 'No Internet Connection'});
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _executeRequest(
      () => dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<dynamic> post(String path, dynamic data, {Options? options}) async {
    return _executeRequest(() => dio.post(path, data: data, options: options));
  }

  Future<dynamic> put(String path, dynamic data, {Options? options}) async {
    return _executeRequest(() => dio.put(path, data: data, options: options));
  }

  Future<dynamic> delete(String path, {Options? options}) async {
    return _executeRequest(() => dio.delete(path, options: options));
  }
}
