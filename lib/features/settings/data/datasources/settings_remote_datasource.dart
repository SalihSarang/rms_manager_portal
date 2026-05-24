import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

abstract class ISettingsRemoteDataSource {
  Future<RestaurantModel> getRestaurantSettings();
  Future<void> updateRestaurantSettings(RestaurantModel settings);
}

class SettingsRemoteDataSourceImpl implements ISettingsRemoteDataSource {
  final FirebaseFirestore _firestore;

  SettingsRemoteDataSourceImpl(this._firestore);

  @override
  Future<RestaurantModel> getRestaurantSettings() async {
    final doc = await _firestore
        .collection(SettingsDbConstants.restaurantSettings)
        .doc(SettingsDbConstants.businessProfileDoc)
        .get();

    if (doc.exists) {
      return RestaurantModel.fromJson(doc.data()!);
    } else {
      // Return default if not exists
      return const RestaurantModel(
        name: 'My Restaurant',
        address: '',
        phone: '',
        email: '',
        fssaiNumber: '',
        gstin: '',
      );
    }
  }

  @override
  Future<void> updateRestaurantSettings(RestaurantModel settings) async {
    await _firestore
        .collection(SettingsDbConstants.restaurantSettings)
        .doc(SettingsDbConstants.businessProfileDoc)
        .set(settings.toJson(), SetOptions(merge: true));
  }
}
