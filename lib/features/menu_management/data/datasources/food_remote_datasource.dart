import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/utils/base_remote_datasource.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

abstract class IFoodRemoteDataSource {
  Future<void> addFoodItem(FoodModel food);
  Future<void> updateFoodItem(FoodModel food);
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId);
  Future<List<FoodModel>> getAllFoodItems();
  Stream<List<FoodModel>> watchAllFoodItems();
}

class FoodRemoteDataSourceImpl with BaseRemoteDataSource implements IFoodRemoteDataSource {
  final FirebaseFirestore firestore;

  FoodRemoteDataSourceImpl({required this.firestore});

  CollectionReference<FoodModel> get _foodCollection =>
      firestore.collection(MenuDbConstants.foods).withConverter<FoodModel>(
            fromFirestore: (snapshot, _) => FoodModel.fromJson(snapshot.data()!, docId: snapshot.id),
            toFirestore: (food, _) => food.toJson(),
          );

  @override
  Future<void> addFoodItem(FoodModel food) {
    return performSafeCall(
      () => _foodCollection.add(food),
      taskName: 'FoodRemoteDataSource.addFoodItem',
    );
  }

  @override
  Future<void> updateFoodItem(FoodModel food) {
    return performSafeCall(
      () async {
        final docRef = _foodCollection.doc(food.id);
        final doc = await docRef.get();

        if (!doc.exists) {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'not-found',
            message: 'Food item with ID ${food.id} does not exist.',
          );
        }

        return docRef.update(food.toJson());
      },
      taskName: 'FoodRemoteDataSource.updateFoodItem',
    );
  }

  @override
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId) {
    return performSafeCall(
      () async {
        final snapshot = await _foodCollection.where('categoryId', isEqualTo: categoryId).get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      taskName: 'FoodRemoteDataSource.getFoodItemsByCategory',
    );
  }

  @override
  Future<List<FoodModel>> getAllFoodItems() {
    return performSafeCall(
      () async {
        final snapshot = await _foodCollection.get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      taskName: 'FoodRemoteDataSource.getAllFoodItems',
    );
  }

  @override
  Stream<List<FoodModel>> watchAllFoodItems() {
    return _foodCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
