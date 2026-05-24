import 'package:manager_portal/features/table_management/domain/repositories/hall_repository.dart';
import 'package:rms_shared_package/models/table_models/hall_model.dart';

class GetHallsUseCase {
  final IHallRepository repository;

  GetHallsUseCase(this.repository);

  Future<List<HallModel>> call() async {
    return await repository.getHalls();
  }
}
