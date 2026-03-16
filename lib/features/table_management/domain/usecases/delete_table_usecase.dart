import 'package:manager_portal/features/table_management/domain/repository/table_repository.dart';

/// Use case for deleting a table.
class DeleteTableUseCase {
  /// The repository.
  final TableRepository repository;

  /// Creates a [DeleteTableUseCase].
  DeleteTableUseCase(this.repository);

  /// Executes the use case.
  Future<void> call(int tableId) => repository.deleteTable(tableId);
}
