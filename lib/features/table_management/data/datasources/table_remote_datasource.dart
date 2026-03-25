import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/utils/base_remote_datasource.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

abstract class ITableRemoteDataSource {
  Future<List<TableModel>> getAllTables();
  Future<List<TableModel>> getTables(String hallId);
  Future<void> addTable(TableModel table);
  Future<void> updateTable(TableModel table);
  Future<void> deleteTable(String id);
}

class TableRemoteDataSourceImpl with BaseRemoteDataSource implements ITableRemoteDataSource {
  final FirebaseFirestore _firestore;

  TableRemoteDataSourceImpl(this._firestore);

  CollectionReference<TableModel> get _tablesCollection =>
      _firestore.collection(TableDbConstants.tables).withConverter<TableModel>(
            fromFirestore: (snapshot, _) => TableModel.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (table, _) => table.toMap(),
          );

  @override
  Future<List<TableModel>> getAllTables() {
    return performSafeCall(
      () async {
        final snapshot = await _tablesCollection.get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      taskName: 'TableRemoteDataSource.getAllTables',
    );
  }

  @override
  Future<List<TableModel>> getTables(String hallId) {
    return performSafeCall(
      () async {
        final snapshot = await _tablesCollection.where('hallId', isEqualTo: hallId).get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      taskName: 'TableRemoteDataSource.getTables',
    );
  }

  @override
  Future<void> addTable(TableModel table) {
    return performSafeCall(
      () => _tablesCollection.doc(table.id).set(table),
      taskName: 'TableRemoteDataSource.addTable',
    );
  }

  @override
  Future<void> updateTable(TableModel table) {
    return performSafeCall(
      () async {
        final docRef = _tablesCollection.doc(table.id);
        final doc = await docRef.get();

        if (!doc.exists) {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'not-found',
            message: 'Table with ID ${table.id} does not exist.',
          );
        }

        return docRef.update(table.toMap());
      },
      taskName: 'TableRemoteDataSource.updateTable',
    );
  }

  @override
  Future<void> deleteTable(String id) {
    return performSafeCall(
      () async {
        final docRef = _tablesCollection.doc(id);
        final doc = await docRef.get();

        if (!doc.exists) {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'not-found',
            message: 'Table with ID $id does not exist.',
          );
        }

        return docRef.delete();
      },
      taskName: 'TableRemoteDataSource.deleteTable',
    );
  }
}
