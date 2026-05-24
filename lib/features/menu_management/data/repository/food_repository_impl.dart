import 'package:manager_portal/features/menu_management/data/datasources/food_remote_datasource.dart';
import 'package:manager_portal/features/menu_management/domain/repository/food_repository.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class FoodRepositoryImpl implements IFoodRepository {
  final IFoodRemoteDataSource remoteDataSource;

  FoodRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addFoodItem(FoodModel food) {
    return remoteDataSource.addFoodItem(food);
  }

  @override
  Future<void> updateFoodItem(FoodModel food) {
    return remoteDataSource.updateFoodItem(food);
  }

  @override
  Future<List<FoodModel>> getFoodItemsByCategory(String categoryId) {
    return remoteDataSource.getFoodItemsByCategory(categoryId);
  }

  @override
  Future<List<FoodModel>> getAllFoodItems() {
    return remoteDataSource.getAllFoodItems();
  }
}
