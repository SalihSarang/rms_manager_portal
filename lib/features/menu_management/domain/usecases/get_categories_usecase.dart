import 'package:manager_portal/features/menu_management/domain/repository/category_repository.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';

class GetCategoriesUseCase {
  final ICategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryModel>> call() async {
    return await repository.getCategories();
  }
}
