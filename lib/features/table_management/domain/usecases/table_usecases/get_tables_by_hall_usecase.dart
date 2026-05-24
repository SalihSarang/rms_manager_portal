import 'package:manager_portal/features/table_management/domain/repositories/table_repository.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';

class GetTablesByHallUseCase {
  final ITableRepository repository;

  GetTablesByHallUseCase(this.repository);

  Future<List<TableModel>> call(String hallId) async {
    return await repository.getTables(hallId);
  }
}
