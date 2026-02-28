import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

abstract class MenuRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> addFoodItem(FoodModel food);
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId);
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final FirebaseFirestore firestore;

  MenuRemoteDatasourceImpl({required this.firestore});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await firestore
        .collection(MenuDbConstants.categories)
        .orderBy('sortOrder')
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return CategoryModel.fromMap(data);
    }).toList();
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    await firestore
        .collection(MenuDbConstants.categories)
        .doc(category.id)
        .set(category.toMap());
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    await firestore
        .collection(MenuDbConstants.categories)
        .doc(category.id)
        .update(category.toMap());
  }

  @override
  Future<void> addFoodItem(FoodModel food) async {
    await firestore.collection(MenuDbConstants.foods).add(food.toJson());
  }

  @override
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId) async {
    final snapshot = await firestore
        .collection(MenuDbConstants.foods)
        .where('categoryId', isEqualTo: categoryId)
        .get();

    return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data())).toList();
  }
}
