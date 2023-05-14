import 'package:dartz/dartz.dart';
import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dev_connector_app/src/feature/registration/domain/repository/registration_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationUseCaseProvider = Provider(
  (ref) {
    return RegistrationUseCase(ref.read(registrationRepositoryProvider));
  },
);

class RegistrationUseCase {
  final RegistrationRepository repository;

  RegistrationUseCase(this.repository);

  Future<Either<ErrorModel, bool>> call({
    required Map<String, dynamic> map,
  }) async {
    return await repository.registerUser(map: map);
  }
}
