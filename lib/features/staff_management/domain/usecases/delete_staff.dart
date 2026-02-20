import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';

class DeleteStaffUsecase {
  final StaffRepository repository;

  DeleteStaffUsecase(this.repository);

  Future<void> call(String staffId) async {
    return repository.deleteStaff(staffId);
  }
}
