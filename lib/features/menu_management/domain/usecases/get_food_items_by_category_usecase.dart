import 'package:manager_portal/features/menu_management/domain/repository/menu_repository.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class GetFoodItemsByCategoryUseCase {
  final MenuRepository repository;

  GetFoodItemsByCategoryUseCase(this.repository);

  Future<List<FoodModel>> call(String categoryId) async {
    return await repository.getFoodItemsByCategory(categoryId);
  }
}
