import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_event.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_state.dart';
import 'package:manager_portal/features/auth/presentation/widgets/auth_button.dart';
import 'package:manager_portal/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

/// The main form area of the login screen.
///
/// Contains email and password input fields, sign-in button,
/// and the Demo Credentials button for one-tap evaluator testing.
class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedSessionCode;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _openDemoCredentialsDialog() {
    RmsDemoCredentialsDialog.show(
      context,
      currentPortalSpec: DemoConfig.manager,
      initialSessionCode: _selectedSessionCode ?? DemoSessionManager.activeSessionId,
      onAutoFill: (email, password, sessionCode) {
        _selectedSessionCode = sessionCode;
        _emailController.text = email;
        _passwordController.text = password;
        final bloc = context.read<AuthBloc>();
        bloc.add(LoginEmailChanged(email));
        bloc.add(LoginPasswordChanged(password));
      },
      onAutoFillAndSignIn: (email, password, sessionCode) {
        _selectedSessionCode = sessionCode;
        _emailController.text = email;
        _passwordController.text = password;
        final bloc = context.read<AuthBloc>();
        bloc.add(LoginEmailChanged(email));
        bloc.add(LoginPasswordChanged(password));
        bloc.add(DemoLoginSubmitted(sessionCode: sessionCode));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: SemanticColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isVisible = state is FormEditingState
            ? state.isPasswordVisible
            : false;
        return Column(
          children: [
            // Email Input
            AuthTextField(
              controller: _emailController,
              label: 'Email Address',
              hintText: 'name@company.com',
              onChanged: (value) {
                context.read<AuthBloc>().add(LoginEmailChanged(value));
              },
            ),
            const SizedBox(height: 16),

            // Password Input
            AuthTextField(
              controller: _passwordController,
              label: 'Password',
              hintText: '••••••••',
              obscureText: !isVisible,
              onChanged: (value) {
                context.read<AuthBloc>().add(LoginPasswordChanged(value));
              },
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: TextColors.secondary,
                  size: 20,
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                    const LoginPasswordVisibilityChanged(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Sign In Button
            AuthButton(
              text: 'Sign In',
              isLoading: state is LoadingState,
              onPressed: () {
                final bloc = context.read<AuthBloc>();
                final email = _emailController.text.trim();
                final password = _passwordController.text;
                if (DemoConfig.isDemoEmail(email)) {
                  bloc.add(DemoLoginSubmitted(sessionCode: _selectedSessionCode));
                } else {
                  bloc.add(LoginSubmitted(email, password));
                }
              },
            ),

            // Demo Credentials Button
            RmsDemoCredentialsButton(
              onPressed: _openDemoCredentialsDialog,
            ),
          ],
        );
      },
    );
  }
}
