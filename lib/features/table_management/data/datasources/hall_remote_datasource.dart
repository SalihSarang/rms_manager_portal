import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

abstract class IHallRemoteDataSource {
  Future<List<HallModel>> getHalls();
  Future<void> addHall(HallModel hall);
  Future<void> updateHall(HallModel hall);
  Future<void> deleteHall(String id);
}

class HallRemoteDataSourceImpl with BaseRemoteDataSource implements IHallRemoteDataSource {
  final FirebaseFirestore _firestore;

  HallRemoteDataSourceImpl(this._firestore);

  CollectionReference<HallModel> get _hallsCollection =>
      _firestore.collection(TableDbConstants.halls).withConverter<HallModel>(
            fromFirestore: (snapshot, _) => HallModel.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (hall, _) => hall.toMap(),
          );

  @override
  Future<List<HallModel>> getHalls() {
    return performSafeCall(
      () async {
        final snapshot = await _hallsCollection.orderBy('createdAt').get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      taskName: 'HallRemoteDataSource.getHalls',
    );
  }

  @override
  Future<void> addHall(HallModel hall) {
    return performSafeCall(
      () => _hallsCollection.doc(hall.id).set(hall),
      taskName: 'HallRemoteDataSource.addHall',
    );
  }

  @override
  Future<void> updateHall(HallModel hall) {
    return performSafeCall(
      () async {
        final docRef = _hallsCollection.doc(hall.id);
        final doc = await docRef.get();

        if (!doc.exists) {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'not-found',
            message: 'Hall with ID ${hall.id} does not exist.',
          );
        }

        return docRef.update(hall.toMap());
      },
      taskName: 'HallRemoteDataSource.updateHall',
    );
  }

  @override
  Future<void> deleteHall(String id) {
    return performSafeCall(
      () async {
        final docRef = _hallsCollection.doc(id);
        final doc = await docRef.get();

        if (!doc.exists) {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'not-found',
            message: 'Hall with ID $id does not exist.',
          );
        }

        return docRef.delete();
      },
      taskName: 'HallRemoteDataSource.deleteHall',
    );
  }
}
