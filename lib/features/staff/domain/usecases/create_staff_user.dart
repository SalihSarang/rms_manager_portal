import 'package:manager_portal/features/staff/domain/repository/staff_repository.dart';

class CreateStaffUser {
  final StaffRepository repository;

  CreateStaffUser(this.repository);

  Future<String> call({required String email, required String password}) {
    return repository.createNewUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
