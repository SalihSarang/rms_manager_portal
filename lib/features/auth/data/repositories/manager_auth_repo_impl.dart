import 'package:manager_portal/features/auth/data/datasources/manager_auth_remote_datasource.dart';
import 'package:manager_portal/features/auth/domain/repositories/auth_repository.dart';
import 'package:rms_shared_package/models/manager_model/manager_model.dart';

/// Implementation of [ManagerAuthRepository] using [ManagerAuthRemoteDataSource].
class ManagerAuthRepoImpl implements ManagerAuthRepository {
  final ManagerAuthRemoteDataSource remoteDataSource;

  ManagerAuthRepoImpl({required this.remoteDataSource});

  // Sign-in Manager
  @override
  Future<ManagerModel?> signIn(String email, String password) async {
    return await remoteDataSource.signIn(email, password);
  }

  @override
  Future<ManagerModel?> signInAsDemoManager({String? sessionCode}) async {
    return await remoteDataSource.signInAsDemoManager(sessionCode: sessionCode);
  }

  // Sign-out Manager
  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  //Checking Auth status
  @override
  Future<ManagerModel?> getCurrentManager() async {
    return await remoteDataSource.getCurrentManager();
  }

  @override
  Future<void> updateManagerProfile(String name, String email) async {
    await remoteDataSource.updateManagerProfile(name, email);
  }

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    await remoteDataSource.changePassword(currentPassword, newPassword);
  }
}
