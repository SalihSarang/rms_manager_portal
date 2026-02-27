import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manager_portal/firebase_options.dart';

import 'package:rms_shared_package/models/staff_model/staff_model.dart';

import 'package:rms_shared_package/constants/db_constants.dart';

abstract class StaffDatasource {
  Future<List<StaffModel?>> getAllStaffs();
  Future<StaffModel> getStaffDetails(String staffId);
  Future<void> addNewStaff(StaffModel staff);
  Future<void> updateStaff(StaffModel staff);
  Future<void> deleteStaff(String staffId);
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class StaffDatasourceImpl implements StaffDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const StaffDatasourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> addNewStaff(StaffModel staff) async {
    await firestore
        .collection(StaffDbConstants.staff)
        .doc(staff.id)
        .set(staff.toMap());
  }

  @override
  Future<void> updateStaff(StaffModel staff) async {
    await firestore
        .collection(StaffDbConstants.staff)
        .doc(staff.id)
        .update(staff.toMap());
  }

  @override
  Future<void> deleteStaff(String staffId) async {
    await firestore.collection(StaffDbConstants.staff).doc(staffId).delete();
  }

  @override
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
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

      return credential.user!.uid;
    } catch (e) {
      rethrow;
    } finally {
      await secondaryApp?.delete();
    }
  }

  @override
  Future<List<StaffModel?>> getAllStaffs() async {
    final snapshot = await firestore.collection(StaffDbConstants.staff).get();
    return snapshot.docs
        .map((doc) => StaffModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<StaffModel> getStaffDetails(String staffId) async {
    final doc = await firestore
        .collection(StaffDbConstants.staff)
        .doc(staffId)
        .get();
    if (doc.exists) {
      return StaffModel.fromMap(doc.data()!, doc.id);
    } else {
      throw Exception('Staff not found');
    }
  }
}
