import 'package:rms_shared_package/rms_shared_package.dart';

abstract class IHallRepository {
  Future<List<HallModel>> getHalls();
  Future<void> addHall(HallModel hall);
  Future<void> updateHall(HallModel hall);
  Future<void> deleteHall(String id);
}
