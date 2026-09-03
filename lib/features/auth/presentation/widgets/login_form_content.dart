import 'package:flutter/material.dart';
import 'package:manager_portal/features/auth/presentation/widgets/login_body.dart';
import 'package:manager_portal/features/auth/presentation/widgets/login_header.dart';

class LoginFormContent extends StatelessWidget {
  const LoginFormContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const LoginHeader(),
        const SizedBox(height: 32),
        const LoginBody(),
        // const SizedBox(height: 32),
        // LoginFooter(onHelpTap: () {}),
      ],
    );
  }
}
