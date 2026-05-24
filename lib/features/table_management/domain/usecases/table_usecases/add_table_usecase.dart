import 'package:manager_portal/features/table_management/domain/repositories/table_repository.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';

class AddTableUseCase {
  final ITableRepository repository;

  AddTableUseCase(this.repository);

  Future<void> call(TableModel table) async {
    return await repository.addTable(table);
  }
}
