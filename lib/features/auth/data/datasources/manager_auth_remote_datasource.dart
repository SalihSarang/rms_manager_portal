import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/models/manager_model/manager_model.dart';

abstract class ManagerAuthRemoteDataSource {
  Future<ManagerModel?> signIn(String email, String password);
  Future<void> signOut();
  Future<ManagerModel?> getCurrentManager();
}

class ManagerAuthRemoteDataSourceImpl implements ManagerAuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ManagerAuthRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<ManagerModel?> signIn(String email, String password) async {
    log(
      '[AuthDatasource] signIn → email: $email',
      name: 'ManagerAuthRemoteDataSource',
    );
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(
        '[AuthDatasource] signIn ← Firebase Auth success, uid: ${credential.user?.uid}',
        name: 'ManagerAuthRemoteDataSource',
      );
      return getCurrentManager();
    } catch (e) {
      log(
        '[AuthDatasource] signIn ← error: $e',
        name: 'ManagerAuthRemoteDataSource',
      );
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    log(
      '[AuthDatasource] signOut → calling Firebase Auth',
      name: 'ManagerAuthRemoteDataSource',
    );
    await auth.signOut();
    log(
      '[AuthDatasource] signOut ← success',
      name: 'ManagerAuthRemoteDataSource',
    );
  }

  @override
  Future<ManagerModel?> getCurrentManager() async {
    final user = auth.currentUser;
    log(
      '[AuthDatasource] getCurrentManager → uid: ${user?.uid}',
      name: 'ManagerAuthRemoteDataSource',
    );

    if (user == null) {
      log(
        '[AuthDatasource] getCurrentManager ← no current user',
        name: 'ManagerAuthRemoteDataSource',
      );
      return null;
    }
    final docSnapshot = await firestore
        .collection(ManagerDbConstants.manager)
        .doc(user.uid)
        .get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      log(
        '[AuthDatasource] getCurrentManager ← Firestore doc not found for uid: ${user.uid}',
        name: 'ManagerAuthRemoteDataSource',
      );
      return null;
    }

    final manager = ManagerModel.fromJson(docSnapshot.data()!);
    log(
      '[AuthDatasource] getCurrentManager ← received manager: ${docSnapshot.data()}',
      name: 'ManagerAuthRemoteDataSource',
    );
    return manager;
  }
}
