import 'package:rms_shared_package/models/table_model/table_model.dart';

/// Repository interface for table management operations.
abstract class TableRepository {
  /// Fetches all tables.
  Future<List<TableModel>> getTables();

  /// Adds a new table.
  Future<void> addTable(TableModel table);

  /// Updates an existing table.
  Future<void> updateTable(TableModel table);

  /// Deletes a table by its ID.
  Future<void> deleteTable(int tableId);
}
