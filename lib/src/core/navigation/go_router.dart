import 'package:dev_connector_app/src/core/constants/route_names.dart';
import 'package:dev_connector_app/src/feature/login/presentation/page/login_page.dart';
import 'package:dev_connector_app/src/feature/registration/presentation/page/registration_page.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.loginRoute,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Routes.registrationRoute,
      builder: (context, state) => const RegistrationPage(),
    ),
  ],
  debugLogDiagnostics: true,
);
