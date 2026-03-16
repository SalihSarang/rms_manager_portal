import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

/// Interface for remote table data operations.
abstract class TableRemoteDataSource {
  /// Fetches all tables from the remote database.
  Future<List<TableModel>> getTables();

  /// Adds a new table to the remote database.
  Future<void> addTable(TableModel table);

  /// Updates an existing table in the remote database.
  Future<void> updateTable(TableModel table);

  /// Deletes a table from the remote database by its ID.
  Future<void> deleteTable(int tableId);
}

/// Firestore implementation of [TableRemoteDataSource].
class TableRemoteDataSourceImpl implements TableRemoteDataSource {
  /// The Firestore instance.
  final FirebaseFirestore firestore;

  /// Creates a [TableRemoteDataSourceImpl].
  TableRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<TableModel>> getTables() async {
    log(
      '[TableRemoteDataSource] getTables -> calling Firestore',
      name: 'TableRemoteDataSource',
    );
    final snapshot = await firestore.collection(TableDbConstants.tables).get();
    final tables = snapshot.docs
        .map((doc) => TableModel.fromJson(doc.data()))
        .toList();
    log(
      '[TableRemoteDataSource] getTables <- received ${tables.length} tables',
      name: 'TableRemoteDataSource',
    );
    return tables;
  }

  @override
  Future<void> addTable(TableModel table) async {
    log(
      '[TableRemoteDataSource] addTable -> payload: ${table.toJson()}',
      name: 'TableRemoteDataSource',
    );
    // Using table.id as document ID since it's an int and we want to control it
    await firestore
        .collection(TableDbConstants.tables)
        .doc(table.id.toString())
        .set(table.toJson());
    log(
      '[TableRemoteDataSource] addTable <- success for id: ${table.id}',
      name: 'TableRemoteDataSource',
    );
  }

  @override
  Future<void> updateTable(TableModel table) async {
    log(
      '[TableRemoteDataSource] updateTable -> id: ${table.id}, payload: ${table.toJson()}',
      name: 'TableRemoteDataSource',
    );
    await firestore
        .collection(TableDbConstants.tables)
        .doc(table.id.toString())
        .update(table.toJson());
    log(
      '[TableRemoteDataSource] updateTable <- success for id: ${table.id}',
      name: 'TableRemoteDataSource',
    );
  }

  @override
  Future<void> deleteTable(int tableId) async {
    log(
      '[TableRemoteDataSource] deleteTable -> id: $tableId',
      name: 'TableRemoteDataSource',
    );
    await firestore
        .collection(TableDbConstants.tables)
        .doc(tableId.toString())
        .delete();
    log(
      '[TableRemoteDataSource] deleteTable <- success for id: $tableId',
      name: 'TableRemoteDataSource',
    );
  }
}
