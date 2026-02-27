import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class AddNewStaff {
  final StaffRepository repository;

  AddNewStaff(this.repository);

  Future<void> call(StaffModel staff) {
    return repository.addNewStaff(staff);
  }
}
