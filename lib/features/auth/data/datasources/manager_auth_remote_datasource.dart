import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rms_shared_package/utils/base_remote_datasource.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/models/manager_model/manager_model.dart';

abstract class ManagerAuthRemoteDataSource {
  Future<ManagerModel?> signIn(String email, String password);
  Future<void> signOut();
  Future<ManagerModel?> getCurrentManager();
}

class ManagerAuthRemoteDataSourceImpl
    with BaseRemoteDataSource
    implements ManagerAuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ManagerAuthRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<ManagerModel?> signIn(String email, String password) {
    return performSafeCall(
      () async {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return await getCurrentManager();
      },
      taskName: 'ManagerAuthRemoteDataSource.signIn',
    );
  }

  @override
  Future<void> signOut() {
    return performSafeCall(
      () => auth.signOut(),
      taskName: 'ManagerAuthRemoteDataSource.signOut',
    );
  }

  @override
  Future<ManagerModel?> getCurrentManager() {
    return performSafeCall(
      () async {
        final user = auth.currentUser;

        if (user == null) {
          return null;
        }
        final docSnapshot = await firestore
            .collection(ManagerDbConstants.manager)
            .doc(user.uid)
            .get();

        if (!docSnapshot.exists || docSnapshot.data() == null) {
          return null;
        }

        return ManagerModel.fromJson(docSnapshot.data()!);
      },
      taskName: 'ManagerAuthRemoteDataSource.getCurrentManager',
    );
  }
}
