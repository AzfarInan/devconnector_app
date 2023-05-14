import 'package:dartz/dartz.dart';
import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dev_connector_app/src/feature/registration/data/data_source/registration_data_source.dart';
import 'package:dev_connector_app/src/feature/registration/data/repository/registration_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationRepositoryProvider = Provider(
  (ref) {
    return RegistrationRepositoryImpl(ref.read(registrationDataSourceProvider));
  },
);

abstract class RegistrationRepository {
  Future<Either<ErrorModel, bool>> registerUser({
    required Map<String, dynamic> map,
  });
}
