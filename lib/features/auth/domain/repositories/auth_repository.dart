import 'package:rms_shared_package/models/manager_model/manager_model.dart';

/// Repository abstraction for managing manager authentication and session state.
abstract class ManagerAuthRepository {
  /// Sign in a manager with [email] and [password].
  ///
  /// Returns the [ManagerModel] if successful, or `null` otherwise.
  Future<ManagerModel?> signIn(String email, String password);

  /// Signs in using the demo manager credentials inside an isolated session.
  Future<ManagerModel?> signInAsDemoManager({String? sessionCode});

  /// Signs out the currently authenticated manager.
  Future<void> signOut();

  /// Returns the currently authenticated [ManagerModel], if any.
  Future<ManagerModel?> getCurrentManager();

  /// Updates the manager's profile information.
  Future<void> updateManagerProfile(String name, String email);

  /// Changes the manager's password after re-authenticating with [currentPassword].
  Future<void> changePassword(String currentPassword, String newPassword);
}
