import 'package:rms_shared_package/rms_shared_package.dart';
import '../../domain/repositories/table_repository.dart';
import '../datasources/table_remote_datasource.dart';

class TableRepositoryImpl implements ITableRepository {
  final ITableRemoteDataSource _remoteDataSource;

  TableRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<TableModel>> getAllTables() async {
    return await _remoteDataSource.getAllTables();
  }

  @override
  Stream<List<TableModel>> watchAllTables() {
    return _remoteDataSource.watchAllTables();
  }

  @override
  Future<List<TableModel>> getTables(String hallId) async {
    return await _remoteDataSource.getTables(hallId);
  }

  @override
  Future<void> addTable(TableModel table) async {
    await _remoteDataSource.addTable(table);
  }

  @override
  Future<void> updateTable(TableModel table) async {
    await _remoteDataSource.updateTable(table);
  }

  @override
  Future<void> deleteTable(String id) async {
    await _remoteDataSource.deleteTable(id);
  }
}
