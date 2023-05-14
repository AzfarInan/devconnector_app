import 'package:dartz/dartz.dart';
import 'package:dev_connector_app/src/core/constants/k.dart';
import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dev_connector_app/src/core/shared_preference/shared_prefs.dart';
import 'package:dev_connector_app/src/feature/login/data/data_source/login_data_source.dart';
import 'package:dev_connector_app/src/feature/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl({
    required this.dataSource,
  });

  final LoginDataSource dataSource;

  @override
  Future<Either<ErrorModel, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dataSource.login(email: email, password: password);

      await SharedPrefs.setString(K.bearerToken, response.data["token"]);

      return Right(response.data["success"]);
    } catch (e) {
      return Left(e as ErrorModel);
    }
  }
}
