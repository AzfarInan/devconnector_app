import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dev_connector_app/src/feature/login/data/data_source/login_data_source.dart';
import 'package:dev_connector_app/src/feature/login/data/repository/login_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

final loginRepositoryProvider = Provider(
  (ref) {
    return LoginRepositoryImpl(dataSource: ref.read(loginDataSourceProvider));
  },
);

abstract class LoginRepository {
  Future<Either<ErrorModel, bool>> login({
    required String email,
    required String password,
  });
}
