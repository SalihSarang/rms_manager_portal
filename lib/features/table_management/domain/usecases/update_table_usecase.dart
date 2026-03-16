import 'package:manager_portal/features/table_management/domain/repository/table_repository.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

/// Use case for updating an existing table.
class UpdateTableUseCase {
  /// The repository.
  final TableRepository repository;

  /// Creates an [UpdateTableUseCase].
  UpdateTableUseCase(this.repository);

  /// Executes the use case.
  Future<void> call(TableModel table) => repository.updateTable(table);
}
