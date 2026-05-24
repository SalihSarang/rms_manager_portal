import 'package:manager_portal/features/menu_management/domain/repository/category_repository.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class UpdateFoodItemUsecase {
  final MenuRepository repository;

  UpdateFoodItemUsecase(this.repository);

  Future<void> execute(FoodModel food) async {
    return await repository.updateFoodItem(food);
  }
}
