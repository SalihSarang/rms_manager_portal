import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// Repository abstraction for managing menu-related data.
///
/// This repository handles operations for both categories and food items,
/// providing a unified interface for menu management.
abstract class MenuRepository {
  /// Fetches all available categories from the data source.
  ///
  /// Returns a list of [CategoryModel] objects.
  Future<List<CategoryModel>> getCategories();

  /// Adds a new [category] to the menu.
  Future<void> addCategory(CategoryModel category);

  /// Updates an existing [category] with new information.
  Future<void> updateCategory(CategoryModel category);

  /// Adds a new [food] item to the menu.
  Future<void> addFoodItem(FoodModel food);

  /// Updates an existing [food] item with new information.
  Future<void> updateFoodItem(FoodModel food);

  /// Fetches all food items belonging to a specific [categoryId].
  ///
  /// Returns a list of [FoodModel] objects filtered by the category.
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId);

  /// Fetches all food items across all categories.
  ///
  /// Returns a complete list of [FoodModel] objects.
  Future<List<FoodModel>> getAllFoodItems();
}
