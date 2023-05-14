import 'package:dev_connector_app/src/core/state/base_state.dart';
import 'package:dev_connector_app/src/feature/registration/domain/use_case/registration_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, BaseState>(
  (ref) {
    return RegistrationNotifier(
      useCase: ref.watch(registrationUseCaseProvider),
    );
  },
);

class RegistrationNotifier extends StateNotifier<BaseState> {
  final RegistrationUseCase useCase;

  RegistrationNotifier({
    required this.useCase,
  }) : super(InitialState());

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String password2,
  }) async {
    state = const LoadingState();

    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "password": password,
      "password2": password2,
    };

    final result = await useCase(map: map);
    result.fold(
      (l) => state = ErrorState(data: l),
      (r) => state = SuccessState(data: r),
    );
  }
}
