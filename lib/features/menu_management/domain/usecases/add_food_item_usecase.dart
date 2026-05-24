import 'package:manager_portal/features/menu_management/domain/repository/food_repository.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class AddFoodItemUseCase {
  final IFoodRepository repository;

  AddFoodItemUseCase(this.repository);

  Future<void> call(FoodModel food) async {
    return await repository.addFoodItem(food);
  }
}
