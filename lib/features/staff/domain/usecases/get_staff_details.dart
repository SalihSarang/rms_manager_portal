import 'package:manager_portal/features/staff/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class GetStaffDetails {
  final StaffRepository repository;

  GetStaffDetails(this.repository);

  Future<StaffModel> call(String staffId) {
    return repository.getStaffDetails(staffId);
  }
}
