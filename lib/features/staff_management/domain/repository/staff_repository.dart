import "package:rms_shared_package/models/staff_model/staff_model.dart";

abstract class StaffRepository {
  Future<List<StaffModel?>> getAllStaffs();
  Future<StaffModel> getStaffDetails(String staffId);
  Future<void> addNewStaff(StaffModel staff);
  Future<void> updateStaff(StaffModel staff);
  Future<void> deleteStaff(String staffId);
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}
