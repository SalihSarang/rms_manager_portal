import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

abstract class ITableRemoteDataSource {
  Future<List<TableModel>> getAllTables();
  Future<List<TableModel>> getTables(String hallId);
  Future<void> addTable(TableModel table);
  Future<void> updateTable(TableModel table);
  Future<void> deleteTable(String id);
}

class TableRemoteDataSourceImpl implements ITableRemoteDataSource {
  final FirebaseFirestore _firestore;

  TableRemoteDataSourceImpl(this._firestore);

  CollectionReference get _tablesCollection =>
      _firestore.collection(TableDbConstants.tables);

  @override
  Future<List<TableModel>> getAllTables() async {
    final snapshot = await _tablesCollection.get();
    return snapshot.docs
        .map(
          (doc) =>
              TableModel.fromMap(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  @override
  Future<List<TableModel>> getTables(String hallId) async {
    final snapshot = await _tablesCollection
        .where('hallId', isEqualTo: hallId)
        .get();
    return snapshot.docs
        .map(
          (doc) =>
              TableModel.fromMap(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  @override
  Future<void> addTable(TableModel table) async {
    await _tablesCollection.doc(table.id).set(table.toMap());
  }

  @override
  Future<void> updateTable(TableModel table) async {
    await _tablesCollection.doc(table.id).update(table.toMap());
  }

  @override
  Future<void> deleteTable(String id) async {
    await _tablesCollection.doc(id).delete();
  }
}
