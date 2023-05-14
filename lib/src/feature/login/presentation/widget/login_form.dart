import 'package:cool_alert/cool_alert.dart';
import 'package:dev_connector_app/src/core/constants/k.dart';
import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dev_connector_app/src/core/shared_preference/shared_prefs.dart';
import 'package:dev_connector_app/src/core/state/base_state.dart';
import 'package:dev_connector_app/src/core/widgets/input_field.dart';
import 'package:dev_connector_app/src/feature/login/presentation/riverpod/login_notifier.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends ConsumerState<ConsumerStatefulWidget> {
  /// Form Key to validate input
  final _formKey = GlobalKey<FormState>();

  /// TextEditing Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// To handle password field
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider, (previous, next) {
      if (next is ErrorState) {
        showError(context, next);
      } else if (next is SuccessState) {
        showSuccess(context);
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          emailField(),
          passwordField(),
          const SizedBox(height: 32.0),
          _loginButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    return InputField(
      controller: emailController,
      labelText: 'Email',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email address';
        } else if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget passwordField() {
    return InputField(
      controller: passwordController,
      labelText: 'Password',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      passwordField: true,
      obscurePassword: obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            obscurePassword = !obscurePassword;
          });
        },
      ),
    );
  }

  Widget _loginButton() {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(loginProvider);

      return InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            await ref.read(loginProvider.notifier).login(
                  email: emailController.text,
                  password: passwordController.text,
                );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: state is LoadingState
              ? const CircularProgressIndicator(
                  color: Colors.deepPurple,
                )
              : const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
        ),
      );
    });
  }

  Future<dynamic> showSuccess(BuildContext context) {
    return CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: SharedPrefs.getString(K.bearerToken).toString(),
    );
  }

  Future<dynamic> showError(BuildContext context, ErrorState<dynamic> next) {
    return CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: (next.data as ErrorModel).message,
    );
  }
}
