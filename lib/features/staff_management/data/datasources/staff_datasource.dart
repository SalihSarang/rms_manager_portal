import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/utils/base_remote_datasource.dart';

import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_shared_package/constants/db_constants.dart';

abstract class IStaffRemoteDataSource {
  Future<List<StaffModel?>> getAllStaffs();
  Stream<List<StaffModel>> watchAllStaffs();
  Future<StaffModel> getStaffDetails(String staffId);
  Future<void> addNewStaff(StaffModel staff);
  Future<void> updateStaff(StaffModel staff);
  Future<void> deleteStaff(String staffId);
}

class StaffRemoteDataSourceImpl
    with BaseRemoteDataSource
    implements IStaffRemoteDataSource {
  final FirebaseFirestore firestore;

  StaffRemoteDataSourceImpl({required this.firestore});

  CollectionReference<StaffModel> get _staffCollection => firestore
      .collection(StaffDbConstants.staff)
      .withConverter<StaffModel>(
        fromFirestore: (snapshot, _) =>
            StaffModel.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (staff, _) => staff.toMap(),
      );

  @override
  Future<List<StaffModel?>> getAllStaffs() {
    return performSafeCall(() async {
      final snapshot = await _staffCollection.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    }, taskName: 'StaffRemoteDataSource.getAllStaffs');
  }

  @override
  Stream<List<StaffModel>> watchAllStaffs() {
    return _staffCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Future<StaffModel> getStaffDetails(String staffId) {
    return performSafeCall(() async {
      final doc = await _staffCollection.doc(staffId).get();
      if (doc.exists) {
        return doc.data()!;
      } else {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
          message: 'Staff with ID $staffId does not exist.',
        );
      }
    }, taskName: 'StaffRemoteDataSource.getStaffDetails');
  }

  @override
  Future<void> addNewStaff(StaffModel staff) {
    return performSafeCall(
      () => _staffCollection.doc(staff.id).set(staff),
      taskName: 'StaffRemoteDataSource.addNewStaff',
    );
  }

  @override
  Future<void> updateStaff(StaffModel staff) {
    return performSafeCall(() async {
      final docRef = _staffCollection.doc(staff.id);
      final doc = await docRef.get();

      if (!doc.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
          message: 'Staff with ID ${staff.id} does not exist.',
        );
      }

      return docRef.update(staff.toMap());
    }, taskName: 'StaffRemoteDataSource.updateStaff');
  }

  @override
  Future<void> deleteStaff(String staffId) {
    return performSafeCall(
      () => _staffCollection.doc(staffId).delete(),
      taskName: 'StaffRemoteDataSource.deleteStaff',
    );
  }
}
