import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepositoryImpl(this._firestore);

  CollectionReference<OrderModel> get _ordersCollection => _firestore
      .collection(OrderDbConstants.orders)
      .withConverter<OrderModel>(
        fromFirestore: (snapshot, _) =>
            OrderModel.fromJson({...snapshot.data()!, 'id': snapshot.id}),
        toFirestore: (order, _) => order.toJson(),
      );

  @override
  Stream<List<OrderModel>> watchLiveOrders() {
    return _ordersCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data())
              .where((order) =>
                order.orderStatus != OrderStatus.completed &&
                order.orderStatus != OrderStatus.cancelled)
              .toList(),
        );
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final snapshot = await _ordersCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
