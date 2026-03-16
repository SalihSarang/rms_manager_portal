import 'package:manager_portal/features/table_management/domain/repository/table_repository.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

/// Use case for adding a new table.
class AddTableUseCase {
  /// The repository.
  final TableRepository repository;

  /// Creates an [AddTableUseCase].
  AddTableUseCase(this.repository);

  /// Executes the use case.
  Future<void> call(TableModel table) => repository.addTable(table);
}
