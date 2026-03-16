import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

abstract class MenuRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> addFoodItem(FoodModel food);
  Future<void> updateFoodItem(FoodModel food);
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId);
  Future<List<FoodModel>> getAllFoodItems();
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final FirebaseFirestore firestore;

  MenuRemoteDatasourceImpl({required this.firestore});

  @override
  Future<List<CategoryModel>> getCategories() async {
    log(
      '[MenuDatasource] getCategories → calling Firestore',
      name: 'MenuRemoteDatasource',
    );
    final snapshot = await firestore
        .collection(MenuDbConstants.categories)
        .orderBy('sortOrder')
        .get();
    final categories = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return CategoryModel.fromMap(data);
    }).toList();
    log(
      '[MenuDatasource] getCategories ← received ${categories.length} categories: ${categories.map((c) => c.toMap()).toList()}',
      name: 'MenuRemoteDatasource',
    );
    return categories;
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    log(
      '[MenuDatasource] addCategory → payload: ${category.toMap()}',
      name: 'MenuRemoteDatasource',
    );
    await firestore
        .collection(MenuDbConstants.categories)
        .doc(category.id)
        .set(category.toMap());
    log(
      '[MenuDatasource] addCategory ← success for id: ${category.id}',
      name: 'MenuRemoteDatasource',
    );
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    log(
      '[MenuDatasource] updateCategory → id: ${category.id}, payload: ${category.toMap()}',
      name: 'MenuRemoteDatasource',
    );
    await firestore
        .collection(MenuDbConstants.categories)
        .doc(category.id)
        .update(category.toMap());
    log(
      '[MenuDatasource] updateCategory ← success for id: ${category.id}',
      name: 'MenuRemoteDatasource',
    );
  }

  @override
  Future<void> addFoodItem(FoodModel food) async {
    log(
      '[MenuDatasource] addFoodItem → payload: ${food.toJson()}',
      name: 'MenuRemoteDatasource',
    );
    final docRef = await firestore
        .collection(MenuDbConstants.foods)
        .add(food.toJson());
    log(
      '[MenuDatasource] addFoodItem ← success, new doc id: ${docRef.id}',
      name: 'MenuRemoteDatasource',
    );
  }

  @override
  Future<void> updateFoodItem(FoodModel food) async {
    log(
      '[MenuDatasource] updateFoodItem → id: ${food.id}, payload: ${food.toJson()}',
      name: 'MenuRemoteDatasource',
    );
    await firestore
        .collection(MenuDbConstants.foods)
        .doc(food.id)
        .update(food.toJson());
    log(
      '[MenuDatasource] updateFoodItem ← success for id: ${food.id}',
      name: 'MenuRemoteDatasource',
    );
  }

  @override
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId) async {
    log(
      '[MenuDatasource] getFoodItemsByCategory → categoryId: $categoryId',
      name: 'MenuRemoteDatasource',
    );
    final snapshot = await firestore
        .collection(MenuDbConstants.foods)
        .where('categoryId', isEqualTo: categoryId)
        .get();

    final foods = snapshot.docs
        .map((doc) => FoodModel.fromJson(doc.data(), docId: doc.id))
        .toList();
    log(
      '[MenuDatasource] getFoodItemsByCategory ← received ${foods.length} items: ${foods.map((f) => f.toJson()).toList()}',
      name: 'MenuRemoteDatasource',
    );
    return foods;
  }

  @override
  Future<List<FoodModel>> getAllFoodItems() async {
    log('[MenuDatasource] getAllFoodItems → calling Firestore', name: 'MenuRemoteDatasource');
    final snapshot = await firestore.collection(MenuDbConstants.foods).get();
    final foods = snapshot.docs
        .map((doc) => FoodModel.fromJson(doc.data(), docId: doc.id))
        .toList();
    log('[MenuDatasource] getAllFoodItems ← received ${foods.length} items', name: 'MenuRemoteDatasource');
    return foods;
  }
}
