import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rms_shared_package/models/staff_model/staff_model.dart';

import 'package:rms_shared_package/constants/db_constants.dart';

abstract class StaffDatasource {
  Future<List<StaffModel?>> getAllStaffs();
  Future<StaffModel> getStaffDetails(String staffId);
  Future<void> addNewStaff(StaffModel staff);
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
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!.uid;
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
