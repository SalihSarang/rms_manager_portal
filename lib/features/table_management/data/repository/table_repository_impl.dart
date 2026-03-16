import 'package:manager_portal/features/table_management/data/datasources/table_remote_datasource.dart';
import 'package:manager_portal/features/table_management/domain/repository/table_repository.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

/// Implementation of [TableRepository] that uses [TableRemoteDataSource].
class TableRepositoryImpl implements TableRepository {
  /// The remote data source.
  final TableRemoteDataSource remoteDataSource;

  /// Creates a [TableRepositoryImpl].
  TableRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TableModel>> getTables() => remoteDataSource.getTables();

  @override
  Future<void> addTable(TableModel table) => remoteDataSource.addTable(table);

  @override
  Future<void> updateTable(TableModel table) => remoteDataSource.updateTable(table);

  @override
  Future<void> deleteTable(int tableId) => remoteDataSource.deleteTable(tableId);
}
