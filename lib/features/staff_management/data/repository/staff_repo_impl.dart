import 'package:manager_portal/features/staff_management/data/datasources/staff_datasource.dart';
import 'package:manager_portal/features/staff_management/data/datasources/staff_auth_datasource.dart';
import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

/// Implementation of [StaffRepository] using [IStaffRemoteDataSource] and [IStaffAuthRemoteDataSource].
class StaffRepositoryImpl implements StaffRepository {
  final IStaffRemoteDataSource remoteDataSource;
  final IStaffAuthRemoteDataSource authRemoteDataSource;

  StaffRepositoryImpl({
    required this.remoteDataSource,
    required this.authRemoteDataSource,
  });

  @override
  Future<void> addNewStaff(StaffModel staff) {
    return remoteDataSource.addNewStaff(staff);
  }

  @override
  Future<void> updateStaff(StaffModel staff) {
    return remoteDataSource.updateStaff(staff);
  }

  @override
  Future<void> deleteStaff(String staffId) {
    return remoteDataSource.deleteStaff(staffId);
  }

  @override
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return authRemoteDataSource.createNewUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<List<StaffModel?>> getAllStaffs() {
    return remoteDataSource.getAllStaffs();
  }

  @override
  Future<StaffModel> getStaffDetails(String staffId) {
    return remoteDataSource.getStaffDetails(staffId);
  }
}
