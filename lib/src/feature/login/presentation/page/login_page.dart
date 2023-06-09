import 'package:dev_connector_app/src/core/constants/k.dart';
import 'package:dev_connector_app/src/core/constants/route_names.dart';
import 'package:dev_connector_app/src/feature/login/presentation/widget/login_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Hero(
                  tag: K.titleTag,
                  child: Text(
                    'Dev Connector',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              Center(
                child: Hero(
                  tag: K.imageTag,
                  child: Image.asset(
                    K.backgroundLogo,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LoginForm(),
              ),
              GestureDetector(
                onTap: () {
                  _navigateToRegistrationPage(context);
                },
                child: registerText(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
      child: RichText(
        text: TextSpan(
          text: "Don't have an account, ",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontFamily: GoogleFonts.righteous().fontFamily,
          ),
          children: const <TextSpan>[
            TextSpan(
              text: 'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRegistrationPage(BuildContext context) {
    context.go(Routes.registrationRoute);
  }
}
