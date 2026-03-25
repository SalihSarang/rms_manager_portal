import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/utils/error_handler.dart';
import 'package:manager_portal/features/auth/domain/usecases/check_auth_status.dart';
import 'package:manager_portal/features/auth/domain/usecases/sign_in_manager.dart';
import 'package:manager_portal/features/auth/domain/usecases/sign_out_manager.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Business logic component for managing authentication state and actions.
///
/// Handles login submissions, logout requests, and authentication status checks.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Use case for signing in a manager.
  final SignInManager signin;

  /// Use case for signing out the current manager.
  final SignOutManager signout;

  /// Use case for checking the current authentication status.
  final CheckAuthStatus authStatus;

  /// Creates an [AuthBloc] with the required use cases and performs an initial status check.
  AuthBloc({
    required this.signin,
    required this.signout,
    required this.authStatus,
  }) : super(const LogInInitialState()) {
    on<LoginSubmitted>(_onSubmitted);
    on<LogOutSubmitted>(_onLogoutSubmitted);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPasswordVisibilityChanged>(_onPasswordVisibleChanged);
    on<CheckingAuthStatus>(_onCheckingAuthStatus);
    on<AuthStatusChanged>(_onAuthStatusChanged);

    // Listen to Auth State Changes for Hot Reload / Persistence
    FirebaseAuth.instance.authStateChanges().listen((user) {
      add(AuthStatusChanged(user));
    });

    // Initial check
    add(CheckingAuthStatus());
  }

  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;

  FormEditingState get currentFormState => _currentEditingState();

  FormEditingState _currentEditingState() {
    return FormEditingState(
      email: _email,
      password: _password,
      isPasswordVisible: _isPasswordVisible,
    );
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<AuthState> emit) {
    _email = event.email;
    emit(_currentEditingState());
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<AuthState> emit) {
    _password = event.password;
    emit(_currentEditingState());
  }

  void _onPasswordVisibleChanged(
    LoginPasswordVisibilityChanged event,
    Emitter<AuthState> emit,
  ) {
    _isPasswordVisible = !_isPasswordVisible;
    emit(_currentEditingState());
  }

  Future<void> _onLogoutSubmitted(
    LogOutSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingState());
    try {
      await signout();
      emit(Unauthenticated());
    } catch (e) {
      emit(LogoutFailure(ErrorHandler.getFriendlyMessage(e)));
    }
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingState());
    try {
      final user = await signin(event.email, event.password);

      if (user == null) {
        emit(const LoginFailure('Invalid email or password.'));
        return;
      }

      emit(LoginSuccess(user));
      emit(Authenticated(user));
      log('LoginSuccess');
      log('User Name ${user.name}');
      log('User Email ${user.email}');
    } catch (e) {
      emit(LoginFailure(ErrorHandler.getFriendlyMessage(e)));
    }
  }

  void _onCheckingAuthStatus(
    CheckingAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthChecking());
    try {
      final manager = await authStatus();

      if (manager != null) {
        emit(Authenticated(manager));
        log('User Name ${manager.name}');
        log('User Email ${manager.email}');
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(
        StatusCheckingFailure(ErrorHandler.getFriendlyMessage(e)),
      );
    }
  }

  void _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user == null) {
      emit(Unauthenticated());
    } else {
      add(CheckingAuthStatus());
    }
  }
}
