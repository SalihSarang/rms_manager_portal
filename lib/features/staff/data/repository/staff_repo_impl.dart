import 'package:manager_portal/features/staff/data/datasources/staff_datasource.dart';
import 'package:manager_portal/features/staff/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class StaffRepositoryImpl implements StaffRepository {
  final StaffDatasource staffDatasource;
  StaffRepositoryImpl({required this.staffDatasource});
  @override
  Future<void> addNewStaff(StaffModel staff) {
    return staffDatasource.addNewStaff(staff);
  }

  @override
  Future<void> updateStaff(StaffModel staff) {
    return staffDatasource.updateStaff(staff);
  }

  @override
  Future<void> deleteStaff(String staffId) {
    return staffDatasource.deleteStaff(staffId);
  }

  @override
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return staffDatasource.createNewUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<List<StaffModel?>> getAllStaffs() {
    return staffDatasource.getAllStaffs();
  }

  @override
  Future<StaffModel> getStaffDetails(String staffId) {
    return staffDatasource.getStaffDetails(staffId);
  }
}
