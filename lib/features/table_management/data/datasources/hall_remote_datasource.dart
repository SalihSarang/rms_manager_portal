import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

abstract class IHallRemoteDataSource {
  Future<List<HallModel>> getHalls();
  Future<void> addHall(HallModel hall);
  Future<void> updateHall(HallModel hall);
  Future<void> deleteHall(String id);
}

class HallRemoteDataSourceImpl implements IHallRemoteDataSource {
  final FirebaseFirestore _firestore;

  HallRemoteDataSourceImpl(this._firestore);

  CollectionReference get _hallsCollection =>
      _firestore.collection(TableDbConstants.halls);

  @override
  Future<List<HallModel>> getHalls() async {
    final snapshot = await _hallsCollection.orderBy('createdAt').get();
    return snapshot.docs
        .map((doc) => HallModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  @override
  Future<void> addHall(HallModel hall) async {
    await _hallsCollection.doc(hall.id).set(hall.toMap());
  }

  @override
  Future<void> updateHall(HallModel hall) async {
    await _hallsCollection.doc(hall.id).update(hall.toMap());
  }

  @override
  Future<void> deleteHall(String id) async {
    await _hallsCollection.doc(id).delete();
  }
}
