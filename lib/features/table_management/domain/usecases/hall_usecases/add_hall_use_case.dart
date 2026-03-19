import 'package:manager_portal/features/table_management/domain/repositories/hall_repository.dart';
import 'package:rms_shared_package/models/table_models/hall_model.dart';

class AddHallUseCase {
  final IHallRepository repository;

  AddHallUseCase(this.repository);

  Future<void> call(HallModel hall) async {
    return await repository.addHall(hall);
  }
}
