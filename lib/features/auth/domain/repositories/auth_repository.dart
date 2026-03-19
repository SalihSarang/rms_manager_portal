import 'package:rms_shared_package/models/manager_model/manager_model.dart';

/// Repository abstraction for managing manager authentication and session state.
abstract class ManagerAuthRepository {
  /// Sign in a manager with [email] and [password].
  ///
  /// Returns the [ManagerModel] if successful, or `null` otherwise.
  Future<ManagerModel?> signIn(String email, String password);

  /// Signs out the currently authenticated manager.
  Future<void> signOut();

  /// Returns the currently authenticated [ManagerModel], if any.
  Future<ManagerModel?> getCurrentManager();
}
