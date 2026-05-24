import 'package:flutter/material.dart';
import 'package:manager_portal/features/auth/presentation/utils/auth_decorations.dart';
import 'package:manager_portal/features/auth/presentation/widgets/login_form_content.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AuthDecorations.loginBackground,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(32.0),
              decoration: AuthDecorations.loginCardDecoration,
              child: const LoginFormContent(),
            ),
          ),
        ),
      ),
    );
  }
}
