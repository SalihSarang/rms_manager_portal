import 'package:manager_portal/features/menu_management/domain/repository/menu_repository.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';

class AddCategoryUseCase {
  final MenuRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> call(CategoryModel category) async {
    return await repository.addCategory(category);
  }
}
