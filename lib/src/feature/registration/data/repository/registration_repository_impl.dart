import 'package:dartz/dartz.dart';
import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dev_connector_app/src/feature/registration/data/data_source/registration_data_source.dart';
import 'package:dev_connector_app/src/feature/registration/domain/repository/registration_repository.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  const RegistrationRepositoryImpl(this.dataSource);

  final RegistrationDataSource dataSource;

  @override
  Future<Either<ErrorModel, bool>> registerUser({
    required Map<String, dynamic> map,
  }) async {
    try {
      await dataSource.registerUser(map: map);

      return const Right(true);
    } catch (e) {
      return Left(e as ErrorModel);
    }
  }
}
