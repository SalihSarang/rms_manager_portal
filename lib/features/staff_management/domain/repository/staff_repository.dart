import "package:rms_shared_package/models/staff_model/staff_model.dart";

/// Repository abstraction for managing staff members and their accounts.
abstract class StaffRepository {
  /// Fetches a list of all staff members.
  Future<List<StaffModel?>> getAllStaffs();

  /// Retrieves detailed information for a specific [staffId].
  Future<StaffModel> getStaffDetails(String staffId);

  /// Adds a new [staff] member record to the system.
  Future<void> addNewStaff(StaffModel staff);

  /// Updates an existing [staff] member's information.
  Future<void> updateStaff(StaffModel staff);

  /// Removes a staff member identified by [staffId] from the system.
  Future<void> deleteStaff(String staffId);

  /// Creates a raw authentication user with [email] and [password].
  ///
  /// Returns the unique identifier (UID) of the newly created user.
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}
