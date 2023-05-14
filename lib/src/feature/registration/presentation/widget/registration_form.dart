import 'package:cool_alert/cool_alert.dart';
import 'package:dev_connector_app/src/core/exception/error_model.dart';
import 'package:dev_connector_app/src/core/state/base_state.dart';
import 'package:dev_connector_app/src/core/widgets/input_field.dart';
import 'package:dev_connector_app/src/feature/registration/presentation/riverpod/registration_notifier.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  const RegistrationForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RegistrationFormState();
  }
}

class _RegistrationFormState extends ConsumerState<ConsumerStatefulWidget> {
  /// Form Key to validate input
  final _formKey = GlobalKey<FormState>();

  /// TextEditing Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  /// To handle password fields
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(registrationProvider, (previous, next) {
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
          nameField(),
          emailField(),
          passwordField(),
          confirmPasswordField(),
          const SizedBox(height: 32.0),
          _loginButton(),
        ],
      ),
    );
  }

  Widget nameField() {
    return InputField(
      controller: nameController,
      labelText: 'Name',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
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
      obscurePassword: obscurePassword1,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword1 ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            obscurePassword1 = !obscurePassword1;
          });
        },
      ),
    );
  }

  Widget confirmPasswordField() {
    return InputField(
      controller: password2Controller,
      labelText: 'Confirm Password',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please confirm your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        } else if (value != passwordController.text) {
          return 'Password does not match';
        }
        return null;
      },
      passwordField: true,
      obscurePassword: obscurePassword2,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword2 ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            obscurePassword2 = !obscurePassword2;
          });
        },
      ),
    );
  }

  Widget _loginButton() {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(registrationProvider);

      return InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            await ref.read(registrationProvider.notifier).registerUser(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  password2: password2Controller.text,
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
                  'Registration',
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
      text: 'Success',
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
