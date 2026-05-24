import 'package:manager_portal/features/table_management/domain/repositories/table_repository.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class GetAllTablesUseCase {
  final ITableRepository repository;

  GetAllTablesUseCase(this.repository);

  Future<List<TableModel>> call() async {
    return await repository.getAllTables();
  }
}
