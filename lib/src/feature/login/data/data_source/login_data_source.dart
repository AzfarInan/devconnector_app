import 'package:dev_connector_app/src/core/network/endpoints.dart';
import 'package:dev_connector_app/src/core/network/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginDataSourceProvider = Provider(
  (ref) {
    return LoginDataSourceImpl(client: ref.read(restClientProvider));
  },
);

abstract class LoginDataSource {
  Future<Response> login({required String email, required String password});
}

class LoginDataSourceImpl implements LoginDataSource {
  LoginDataSourceImpl({
    required this.client,
  });

  final RestClient client;

  @override
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await client.post('${Endpoint.users}/login', {
      "email": email,
      "password": password,
    });
  }
}
