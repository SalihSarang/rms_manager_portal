import 'package:manager_portal/features/menu_management/domain/repository/menu_repository.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class AddFoodItemUsecase {
  final MenuRepository repository;

  AddFoodItemUsecase(this.repository);

  Future<void> execute(FoodModel food) async {
    return await repository.addFoodItem(food);
  }
}
