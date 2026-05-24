import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rms_shared_package/utils/base_remote_datasource.dart';
import 'package:manager_portal/firebase_options.dart';

abstract class IStaffAuthRemoteDataSource {
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class StaffAuthRemoteDataSourceImpl with BaseRemoteDataSource implements IStaffAuthRemoteDataSource {
  final FirebaseAuth auth;

  StaffAuthRemoteDataSourceImpl({required this.auth});

  @override
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return performSafeCall(
      () async {
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
        } finally {
          await secondaryApp?.delete();
        }
      },
      taskName: 'StaffAuthRemoteDataSource.createNewUserWithEmailAndPassword',
      timeoutDuration: const Duration(seconds: 30),
    );
  }
}
