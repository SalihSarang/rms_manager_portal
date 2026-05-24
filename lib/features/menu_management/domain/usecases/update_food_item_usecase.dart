import 'package:manager_portal/features/menu_management/domain/repository/food_repository.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class UpdateFoodItemUsecase {
  final IFoodRepository repository;

  UpdateFoodItemUsecase(this.repository);

  Future<void> execute(FoodModel food) async {
    return await repository.updateFoodItem(food);
  }
}
