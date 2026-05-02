import 'package:flutter/material.dart';
import 'package:manager_portal/features/auth/presentation/widgets/login_view.dart';

/// Main entry point for the authentication flow.
///
/// This screen provides a container for the login form content,
/// and applies a premium gradient background.
class LoginScreen extends StatelessWidget {
  /// Creates a new [LoginScreen].
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}
