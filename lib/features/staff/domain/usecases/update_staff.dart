import 'package:manager_portal/features/staff/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class UpdateStaffUsecase {
  final StaffRepository repository;

  UpdateStaffUsecase(this.repository);

  Future<void> call(StaffModel staff) async {
    return repository.updateStaff(staff);
  }
}
