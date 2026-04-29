import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/utils/base_remote_datasource.dart';

abstract class OverviewRemoteDataSource {
  Future<List<OrderModel>> getAllOrders();
}

class OverviewRemoteDataSourceImpl
    with BaseRemoteDataSource
    implements OverviewRemoteDataSource {
  final FirebaseFirestore firestore;

  OverviewRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<OrderModel>> getAllOrders() {
    return performSafeCall(
      () async {
        final snapshot = await firestore
            .collection(OrderDbConstants.orders)
            .get();

        return snapshot.docs.map((doc) {
          final data = doc.data();
          // Ensure ID is set
          if (data['id'] == null || data['id'].toString().isEmpty) {
            data['id'] = doc.id;
          }
          return OrderModel.fromJson(data);
        }).toList();
      },
      taskName: 'OverviewRemoteDataSource.getAllOrders',
    );
  }
}
