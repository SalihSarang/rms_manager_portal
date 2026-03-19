import 'package:rms_shared_package/rms_shared_package.dart';
import '../../domain/repositories/hall_repository.dart';
import '../datasources/hall_remote_datasource.dart';

class HallRepositoryImpl implements IHallRepository {
  final IHallRemoteDataSource _remoteDataSource;

  HallRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<HallModel>> getHalls() async {
    return await _remoteDataSource.getHalls();
  }

  @override
  Future<void> addHall(HallModel hall) async {
    await _remoteDataSource.addHall(hall);
  }

  @override
  Future<void> updateHall(HallModel hall) async {
    await _remoteDataSource.updateHall(hall);
  }

  @override
  Future<void> deleteHall(String id) async {
    await _remoteDataSource.deleteHall(id);
  }
}
