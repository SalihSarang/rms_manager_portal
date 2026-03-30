import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

abstract class IFoodRepository {
  Future<void> addFoodItem(FoodModel food);
  Future<void> updateFoodItem(FoodModel food);
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId);
  Future<List<FoodModel>> getAllFoodItems();
}
