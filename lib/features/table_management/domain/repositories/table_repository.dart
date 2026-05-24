import 'package:rms_shared_package/rms_shared_package.dart';

abstract class ITableRepository {
  Future<List<TableModel>> getAllTables();
  Stream<List<TableModel>> watchAllTables();
  Future<List<TableModel>> getTables(String hallId);
  Future<void> addTable(TableModel table);
  Future<void> updateTable(TableModel table);
  Future<void> deleteTable(String id);
}
