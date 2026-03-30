import 'package:manager_portal/features/table_management/domain/repositories/table_repository.dart';

class DeleteTableUseCase {
  final ITableRepository repository;

  DeleteTableUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteTable(id);
  }
}
