import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:manager_portal/features/menu_management/domain/repository/menu_repository.dart';

class GetCategoriesUseCase {
  final MenuRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryModel>> call() async {
    return await repository.getCategories();
  }
}
