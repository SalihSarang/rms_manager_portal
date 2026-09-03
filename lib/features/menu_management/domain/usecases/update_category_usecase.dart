import 'package:manager_portal/features/menu_management/domain/repository/category_repository.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';

class UpdateCategoryUseCase {
  final ICategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<void> call(CategoryModel category) async {
    return await repository.updateCategory(category);
  }
}
