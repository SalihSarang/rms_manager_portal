import 'package:manager_portal/features/table_management/domain/repository/table_repository.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

/// Use case for fetching all tables.
class GetTablesUseCase {
  /// The repository.
  final TableRepository repository;

  /// Creates a [GetTablesUseCase].
  GetTablesUseCase(this.repository);

  /// Executes the use case.
  Future<List<TableModel>> call() => repository.getTables();
}
