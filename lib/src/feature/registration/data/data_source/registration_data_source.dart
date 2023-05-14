import 'package:dev_connector_app/src/core/network/endpoints.dart';
import 'package:dev_connector_app/src/core/network/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationDataSourceProvider = Provider(
  (ref) {
    return RegistrationDataSourceImpl(client: ref.read(restClientProvider));
  },
);

abstract class RegistrationDataSource {
  Future<Response> registerUser({
    required Map<String, dynamic> map,
  });
}

class RegistrationDataSourceImpl implements RegistrationDataSource {
  RegistrationDataSourceImpl({
    required this.client,
  });

  final RestClient client;

  @override
  Future<Response> registerUser({
    required Map<String, dynamic> map,
  }) async {
    return await client.post('${Endpoint.users}/register', map);
  }
}
