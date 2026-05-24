import 'package:manager_portal/features/menu_management/domain/repository/food_repository.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class GetAllFoodItemsUseCase {
  final IFoodRepository repository;

  GetAllFoodItemsUseCase(this.repository);

  Future<List<FoodModel>> execute() async {
    return await repository.getAllFoodItems();
  }
}
