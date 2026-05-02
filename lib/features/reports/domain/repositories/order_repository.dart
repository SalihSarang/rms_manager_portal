import 'package:rms_shared_package/rms_shared_package.dart';

abstract class IOrderRepository {
  Stream<List<OrderModel>> watchLiveOrders();
  Future<List<OrderModel>> getAllOrders();
}
