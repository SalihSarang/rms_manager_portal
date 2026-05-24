import 'package:manager_portal/features/table_management/domain/repositories/hall_repository.dart';

class DeleteHallUseCase {
  final IHallRepository repository;

  DeleteHallUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteHall(id);
  }
}
