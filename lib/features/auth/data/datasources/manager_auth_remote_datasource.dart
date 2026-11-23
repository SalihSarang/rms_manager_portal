import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

abstract class ManagerAuthRemoteDataSource {
  Future<ManagerModel?> signIn(String email, String password);
  Future<ManagerModel?> signInAsDemoManager({String? sessionCode});
  Future<void> signOut();
  Future<ManagerModel?> getCurrentManager();
  Future<void> updateManagerProfile(String name, String email);
  Future<void> changePassword(String currentPassword, String newPassword);
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
        if (DemoConfig.isDemoEmail(email)) {
          return await signInAsDemoManager();
        }
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
  Future<ManagerModel?> signInAsDemoManager({String? sessionCode}) {
    return performSafeCall(
      () async {
        await DemoAuthBootstrapService.signInOrBootstrapManagerDemo(
          sessionCode: sessionCode,
          auth: auth,
          firestore: firestore,
        );
        return await getCurrentManager();
      },
      taskName: 'ManagerAuthRemoteDataSource.signInAsDemoManager',
    );
  }

  @override
  Future<void> signOut() {
    return performSafeCall(
      () async {
        await DemoSessionManager.clearSession();
        await auth.signOut();
      },
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

        // If this is a demo email but the demo session ID is not yet initialized in memory,
        // wait for demo bootstrapping rather than querying the root manager collection
        if (DemoConfig.isDemoEmail(user.email) && !DemoSessionManager.isDemoMode) {
          return null;
        }

        final docSnapshot = await firestore
            .rmsCollection(ManagerDbConstants.manager)
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

  @override
  Future<void> updateManagerProfile(String name, String email) {
    return performSafeCall(
      () async {
        final user = auth.currentUser;
        if (user == null) {
          throw Exception('No authenticated manager found.');
        }

        if (name.isNotEmpty && name != user.displayName) {
          await user.updateDisplayName(name);
        }

        await firestore
            .rmsCollection(ManagerDbConstants.manager)
            .doc(user.uid)
            .set({
              'name': name,
              'email': email.isNotEmpty ? email : user.email ?? '',
            }, SetOptions(merge: true));
      },
      taskName: 'ManagerAuthRemoteDataSource.updateManagerProfile',
    );
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) {
    return performSafeCall(
      () async {
        final user = auth.currentUser;
        if (user == null || user.email == null) {
          throw Exception('No authenticated manager found.');
        }

        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(cred);
        await user.updatePassword(newPassword);
      },
      taskName: 'ManagerAuthRemoteDataSource.changePassword',
    );
  }
}
