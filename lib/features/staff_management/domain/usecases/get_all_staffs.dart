import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class GetAllStaffs {
  final StaffRepository repository;

  GetAllStaffs(this.repository);

  Future<List<StaffModel?>> call() {
    return repository.getAllStaffs();
  }
}
