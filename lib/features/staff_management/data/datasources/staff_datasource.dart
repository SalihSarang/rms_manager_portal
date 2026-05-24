import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manager_portal/firebase_options.dart';
import 'package:rms_shared_package/utils/base_remote_datasource.dart';

import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_shared_package/constants/db_constants.dart';

abstract class IStaffRemoteDataSource {
  Future<List<StaffModel?>> getAllStaffs();
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
  Future<void> addNewStaff(StaffModel staff) async {
    log(
      '[StaffDatasource] addNewStaff -> id: ${staff.id}, payload: ${staff.toMap()}',
      name: 'StaffDatasource',
    );
    await firestore
        .collection(StaffDbConstants.staff)
        .doc(staff.id)
        .set(staff.toMap());
    log(
      '[StaffDatasource] addNewStaff <- success for id: ${staff.id}',
      name: 'StaffDatasource',
    );
  }

  @override
  Future<void> updateStaff(StaffModel staff) async {
    log(
      '[StaffDatasource] updateStaff -> id: ${staff.id}, payload: ${staff.toMap()}',
      name: 'StaffDatasource',
    );
    await firestore
        .collection(StaffDbConstants.staff)
        .doc(staff.id)
        .update(staff.toMap());
    log(
      '[StaffDatasource] updateStaff <- success for id: ${staff.id}',
      name: 'StaffDatasource',
    );
  }

  @override
  Future<void> deleteStaff(String staffId) async {
    log(
      '[StaffDatasource] deleteStaff -> staffId: $staffId',
      name: 'StaffDatasource',
    );
    await firestore.collection(StaffDbConstants.staff).doc(staffId).delete();
    log(
      '[StaffDatasource] deleteStaff <- success for staffId: $staffId',
      name: 'StaffDatasource',
    );
  }

  @override
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    log(
      '[StaffDatasource] createNewUserWithEmailAndPassword -> email: $email',
      name: 'StaffDatasource',
    );
    FirebaseApp? secondaryApp;
    try {
      secondaryApp = await Firebase.initializeApp(
        name: 'SecondaryApp-${DateTime.now().millisecondsSinceEpoch}',
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);

      final credential = await secondaryAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      log(
        '[StaffDatasource] createNewUserWithEmailAndPassword <- success, uid: $uid',
        name: 'StaffDatasource',
      );
      return uid;
    } catch (e) {
      log(
        '[StaffDatasource] createNewUserWithEmailAndPassword <- error: $e',
        name: 'StaffDatasource',
      );
      rethrow;
    } finally {
      await secondaryApp?.delete();
    }
  }

  @override
  Future<List<StaffModel?>> getAllStaffs() async {
    log(
      '[StaffDatasource] getAllStaffs -> calling Firestore',
      name: 'StaffDatasource',
    );
    final snapshot = await firestore.collection(StaffDbConstants.staff).get();
    final staffs = snapshot.docs
        .map((doc) => StaffModel.fromMap(doc.data(), doc.id))
        .toList();
    log(
      '[StaffDatasource] getAllStaffs <- received ${staffs.length} staff records: ${staffs.map((s) => s.toMap()).toList()}',
      name: 'StaffDatasource',
    );
    return staffs;
  }

  @override
  Future<StaffModel> getStaffDetails(String staffId) async {
    log(
      '[StaffDatasource] getStaffDetails -> staffId: $staffId',
      name: 'StaffDatasource',
    );
    final doc = await firestore
        .collection(StaffDbConstants.staff)
        .doc(staffId)
        .get();
    if (doc.exists) {
      final staff = StaffModel.fromMap(doc.data()!, doc.id);
      log(
        '[StaffDatasource] getStaffDetails <- received: ${doc.data()}',
        name: 'StaffDatasource',
      );
      return staff;
    } else {
      log(
        '[StaffDatasource] getStaffDetails <- staff not found for id: $staffId',
        name: 'StaffDatasource',
      );
      throw Exception('Staff not found');
    }
  }
}
