import 'package:dev_connector_app/src/core/state/base_state.dart';
import 'package:dev_connector_app/src/feature/login/domain/use_case/login_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, BaseState>(
  (ref) {
    return LoginNotifier(useCase: ref.watch(loginUseCaseProvider));
  },
);

class LoginNotifier extends StateNotifier<BaseState> {
  final LoginUseCase useCase;

  LoginNotifier({
    required this.useCase,
  }) : super(InitialState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const LoadingState();
    final result = await useCase(email: email, password: password);
    result.fold(
      (l) => state = ErrorState(data: l),
      (r) => state = SuccessState(data: r),
    );
  }
}
